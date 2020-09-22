/*=============================================================================
 * Copyright (c) 2020, Fabiola de las Casas <fabioladelascasas@gmail.com>
 * All rights reserved.
 * License: Free
 * Date: 2020/09/22
 * Version: v1.1
 *===========================================================================*/

#ifndef _ZEROS_H_
#define _ZEROS_H_

/*==================[inclusions]=============================================*/
#include <stdint.h>

/*==================[cplusplus]==============================================*/

#ifdef __cplusplus
extern "C" {
#endif

/*==================[macros]=================================================*/

/*==================[typedef]================================================*/

/*==================[external data declaration]==============================*/

/*==================[external functions declaration]=========================*/

/**
 * Funcion que iniciliaza en cero un vector
 * @param vector
 * @param longitud
 * @return none
 */
extern void asmZeros(uint32_t * vector, uint32_t longitud);
extern void Czeros(uint32_t * vector, uint32_t longitud);
uint32_t CSum(uint32_t firstOperand, uint32_t secondOperand);
/*==================[cplusplus]==============================================*/

#ifdef __cplusplus
}
#endif

/** @} doxygen end group definition */
/*==================[end of file]============================================*/
#endif /* #ifndef _MAIN_H_ */
