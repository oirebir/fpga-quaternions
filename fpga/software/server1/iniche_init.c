/******************************************************************************
* Copyright (c) 2006 Altera Corporation, San Jose, California, USA.           *
* All rights reserved. All use of this software and documentation is          *
* subject to the License Agreement located at the end of this file below.     *
*******************************************************************************                                                                             *
* Date - October 24, 2006                                                     *
* Module - iniche_init.c                                                      *
*                                                                             *                                                                             *
******************************************************************************/

/******************************************************************************
 * NicheStack TCP/IP stack initialization and Operating System Start in main()
 * for Simple Socket Server (SSS) example. 
 * 
 * This example demonstrates the use of MicroC/OS-II running on NIOS II.       
 * In addition it is to serve as a good starting point for designs using       
 * MicroC/OS-II and Altera NicheStack TCP/IP Stack - NIOS II Edition.                                                                                           
 *      
 * Please refer to the Altera NicheStack Tutorial documentation for details on 
 * this software example, as well as details on how to configure the NicheStack
 * TCP/IP networking stack and MicroC/OS-II Real-Time Operating System.  
 */
  
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdint.h>
#include <io.h>
#include <fcntl.h>
/* MicroC/OS-II definitions */
#include "../server1_bsp/HAL/inc/includes.h"

#include "system.h"

#include "dm9000a.h"

/* Simple Socket Server definitions */
#include "simple_socket_server.h"
#include "alt_error_handler.h"

/* Nichestack definitions */
#include "../server1_bsp/iniche/src/h/nios2/ipport.h"
#include "../server1_bsp/iniche/src/h/tcpport.h"
#include "../server1_bsp/iniche/src/h/libport.h"
#include "../server1_bsp/iniche/src/nios2/osport.h"
#include "basic_io.h"
#include "LCD.h"
#include "altera_avalon_pio_regs.h"
/* Definition of task stack for the initial task which will initialize the NicheStack
 * TCP/IP Stack and then initialize the rest of the Simple Socket Server example tasks. 
 */
OS_STK    SSSInitialTaskStk[TASK_STACKSIZE];

/* Declarations for creating a task with TK_NEWTASK.  
 * All tasks which use NicheStack (those that use sockets) must be created this way.
 * TK_OBJECT macro creates the static task object used by NicheStack during operation.
 * TK_ENTRY macro corresponds to the entry point, or defined function name, of the task.
 * inet_taskinfo is the structure used by TK_NEWTASK to create the task.
 */
TK_OBJECT(to_ssstask);
TK_ENTRY(SSSSimpleSocketServerTask);

struct inet_taskinfo ssstask = {
      &to_ssstask,
      "simple socket server",
      SSSSimpleSocketServerTask,
      4,
      APP_STACK_SIZE,
};

#define FLOAT_SIZE sizeof(float)

union ufloat {
	float f;
	uint32_t b;
};

void print_float(float f) {
	union ufloat uf;
	uf.f = f;
	int i = 0;
	for(i = 31; i >= 0; i--) {
		if((uf.b & 1<<i) == 1<<i) {
			printf("1");
		} else {
			printf("0");
		}
	}
}

void print_float32(uint32_t f) {
	int i = 0;
	for(i = 31; i >= 0; i--) {
		if((f & 1<<i) == 1<<i) {
			printf("1");
		} else {
			printf("0");
		}
	}
}

void print_half(uint16_t h) {
	int i = 0;
	for(i = 15; i >= 0; i--) {
		if((h & 1<<i) == 1<<i) {
			printf("1");
		} else {
			printf("0");
		}
	}
}

uint32_t as_uint(const float x) {
    return *(uint32_t*)&x;
}

float as_float(const uint32_t x) {
    return *(float*)&x;
}

float half_to_float(const uint16_t  x) { // IEEE-754 16-bit floating-point format (without infinity): 1-5-10, exp-15, +-131008.0, +-6.1035156E-5, +-5.9604645E-8, 3.311 digits
    const uint32_t e = (x&0x7C00)>>10; // exponent
    const uint32_t m = (x&0x03FF)<<13; // mantissa
    const uint32_t v = as_uint((float)m)>>23; // evil log2 bit hack to count leading zeros in denormalized format
    return as_float((x&0x8000)<<16 | (e!=0)*((e+112)<<23|m) | ((e==0)&(m!=0))*((v-37)<<23|((m<<(150-v))&0x007FE000))); // sign : normalized : denormalized
}

uint16_t float_to_half(const float x) { // IEEE-754 16-bit floating-point format (without infinity): 1-5-10, exp-15, +-131008.0, +-6.1035156E-5, +-5.9604645E-8, 3.311 digits
    const uint32_t b = as_uint(x)+0x00001000; // round-to-nearest-even: add last bit after truncated mantissa
    const uint32_t e = (b&0x7F800000)>>23; // exponent
    const uint32_t m = b&0x007FFFFF; // mantissa; in line below: 0x007FF000 = 0x00800000-0x00001000 = decimal indicator flag - initial rounding
    return (b&0x80000000)>>16 | (e>112)*((((e-112)<<10)&0x7C00)|m>>13) | ((e<113)&(e>101))*((((0x007FF000+m)>>(125-e))+1)>>1) | (e>143)*0x7FFF; // sign : normalized : denormalized : saturate
}
/* SSSInitialTask will initialize the NicheStack
 * TCP/IP Stack and then initialize the rest of the Simple Socket Server example 
 * RTOS structures and tasks. 
 */
void SSSInitialTask(void *task_data)
{
  INT8U error_code;
  
  /*
   * Initialize Altera NicheStack TCP/IP Stack - Nios II Edition specific code.
   * NicheStack is initialized from a task, so that RTOS will have started, and 
   * I/O drivers are available.  Two tasks are created:
   *    "Inet main"  task with priority 2
   *    "clock tick" task with priority 3
   */   
  alt_iniche_init();
  netmain(); 

  /* Wait for the network stack to be ready before proceeding. 
   * iniche_net_ready indicates that TCP/IP stack is ready, and IP address is obtained.
   */
  while (!iniche_net_ready)
    TK_SLEEP(1);

  /* Now that the stack is running, perform the application initialization steps */
  
  /* Application Specific Task Launching Code Block Begin */

  printf("\nSimple Socket Server starting up\n");

  /* Create the main simple socket server task. */
  //TK_NEWTASK(&ssstask);
  
  /*create os data structures */
  //SSSCreateOSDataStructs();

  /* create the other tasks */
  //SSSCreateTasks();

  /* Application Specific Task Launching Code Block End */
  
  /*This task is deleted because there is no need for it to run again */
  //error_code = OSTaskDel(OS_PRIO_SELF);
  //alt_uCOSIIErrorHandler(error_code, 0);
  LCD_Init();
  
  int sw, but;
  struct sockaddr_in sa;
  int res;
  int SocketFD;
  char buf[1024];
  SocketFD = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
  printf("Socket criado\n");
  memset(&sa, 0, sizeof sa);
  sa.sin_family = AF_INET;
  sa.sin_port = htons(5000); // ALTERAR PORTA A SER UTILIZADA AQUI
  res = inet_pton(AF_INET, "10.183.10.221", &sa.sin_addr); //ALTERAR O IP DO SERVIDOR AQUI
  if (connect(SocketFD, (struct sockaddr *)&sa, sizeof sa) == -1) {
	perror("connect failed");
	close(SocketFD);
	exit(EXIT_FAILURE);
  }
	char buffer[80];

	float quaternion[2][4];
	int data;
	while (1)
	{
		if (recv(SocketFD, buffer, sizeof(buffer), 0) < 0)
		{
			exit(EXIT_FAILURE);
		}
		//{LCD_Line2(); LCD_Show_Text(buffer);}

		// Recep??o primeiro quaternion
		if (recv(SocketFD, buffer, sizeof(buffer), 0) < 0)
		{
			exit(EXIT_FAILURE);
		}
		//for (data = 0; data < 4; data++)
			//quaternion[0][data] = parse(buffer, data); //need to parse
		// Escrita na mem?ria
		IOWR(QUAT_0_BASE, 0, quaternion[0][0]); // Tempo
		IOWR(QUAT_0_BASE, 0, quaternion[0][1]); // Eixo X
		IOWR(QUAT_0_BASE, 0, quaternion[0][2]); // Eixo Y
		IOWR(QUAT_0_BASE, 0, quaternion[0][3]); // Eixo Z

		// Recep??o segundo quaternion
		if (recv(SocketFD, buffer, sizeof(buffer), 0) < 0) LCD_Show_Text("Conection error quat1");
		//for (data = 0; data < 4; data++)
			//quaternion[1][data] = parse(buffer, data); //need to parse
		// Escrita na mem?ria
		IOWR(QUAT_0_BASE, 1, quaternion[1][0]); // Tempo
		IOWR(QUAT_0_BASE, 1, quaternion[1][1]); // Eixo X
		IOWR(QUAT_0_BASE, 1, quaternion[1][2]); // Eixo Y
		IOWR(QUAT_0_BASE, 1, quaternion[1][3]); // Eixo Z

		// Descobrir como evitar ms
		msleep(100);

		quaternion[2][0] = IORD(QUAT_0_BASE, 2); // Tempo
		quaternion[2][0] = IORD(QUAT_0_BASE, 2); // Eixo X
		quaternion[2][0] = IORD(QUAT_0_BASE, 2); // Eixo Y
		quaternion[2][0] = IORD(QUAT_0_BASE, 2); // Eixo Z

		//buffer = unparse(quaternion[2]); //need to parse
		if (send(SocketFD, buffer, sizeof(buffer), 0) < 0) LCD_Show_Text("Conection error quat2");
	}
}

/* Main creates a single task, SSSInitialTask, and starts task scheduler.
 */

int main (int argc, char* argv[], char* envp[])
{
  
  INT8U error_code;

  DM9000A_INSTANCE( DM9000A_0, dm9000a_0 );
  DM9000A_INIT( DM9000A_0, dm9000a_0 );

  /* Clear the RTOS timer */
  OSTimeSet(0);

  /* SSSInitialTask will initialize the NicheStack
   * TCP/IP Stack and then initialize the rest of the Simple Socket Server example
   * RTOS structures and tasks.
   */
  error_code = OSTaskCreateExt(SSSInitialTask,
                             NULL,
                             (void *)&SSSInitialTaskStk[TASK_STACKSIZE],
                             SSS_INITIAL_TASK_PRIORITY,
                             SSS_INITIAL_TASK_PRIORITY,
                             SSSInitialTaskStk,
                             TASK_STACKSIZE,
                             NULL,
                             0);
  alt_uCOSIIErrorHandler(error_code, 0);

  /*
   * As with all MicroC/OS-II designs, once the initial thread(s) and
   * associated RTOS resources are declared, we start the RTOS. That's it!
   */
  OSStart();
  
  while(1); /* Correct Program Flow never gets here. */

  return -1;
}

/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2006 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
* Altera does not recommend, suggest or require that this reference design    *
* file be used in conjunction or combination with any other product.          *
******************************************************************************/
