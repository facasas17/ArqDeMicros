/*=============================================================================
 * Copyright (c) 2020, Fabiola de las Casas <fabioladelascasas@gmail.com>
 * All rights reserved.
 * License: Free
 * Date: 2020/09/22
 * Version: v1.1
 *===========================================================================*/

/** @brief Este es el ejercicio 1 de la guía de Arquitectura de Microcontroladores.
 */

/*==================[inclusions]=============================================*/

#include "main.h"
#include "board.h"
#include "zeros.h"

/*==================[macros and definitions]=================================*/

/*==================[internal data declaration]==============================*/
volatile uint32_t * DWT_CTRL   = (uint32_t *)0xE0001000;
volatile uint32_t * DWT_CYCCNT = (uint32_t *)0xE0001004;

/*==================[internal functions declaration]=========================*/

/** @brief hardware initialization function
 *	@return none
 */
static void initHardware(void);

/*==================[internal data definition]===============================*/

/*==================[external data definition]===============================*/

/*==================[internal functions definition]==========================*/

static void initHardware(void)
{
	Board_Init();
	SystemCoreClockUpdate();
	//SysTick_Config(SystemCoreClock / 1000);
}

/*==================[external functions definition]==========================*/

int main(void)
{
	volatile uint32_t cyclesC=0,cyclesAsm=0;

	uint32_t longitud_vect = 10;
	uint32_t vector_zeros[longitud_vect];

	initHardware();

	*DWT_CTRL  |= 1;

	*DWT_CYCCNT = 0;
	Czeros(vector_zeros, longitud_vect);
	cyclesC=*DWT_CYCCNT;

	*DWT_CYCCNT = 0;
	asmZeros(vector_zeros, longitud_vect);
	cyclesAsm=*DWT_CYCCNT;

	while (1)
	{
		__WFI(); //wfi
	}
}

/** @} doxygen end group definition */

/*==================[end of file]============================================*/
