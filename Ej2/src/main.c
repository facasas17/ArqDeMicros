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
	uint32_t longitud_vect = 10;
	uint32_t vector_zeros[longitud_vect];

	initHardware();

	//Czeros(vector_zeros, longitud_vect);
	asmZeros(vector_zeros, longitud_vect);
	longitud_vect = CSum(20, 30);

	while (1)
	{
		__WFI(); //wfi
	}
}

/** @} doxygen end group definition */

/*==================[end of file]============================================*/
