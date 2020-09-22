/*=============================================================================
 * Copyright (c) 2020, Fabiola de las Casas <fabioladelascasas@gmail.com>
 * All rights reserved.
 * License: Free
 * Date: 2020/09/22
 * Version: v1.1
 *===========================================================================*/

#include "zeros.h"

void Czeros(uint32_t * vector, uint32_t longitud)
{
	uint32_t i = 0;
	for (i = 0; i< longitud; i++)
		vector[i] = 0;
}

uint32_t CSum(uint32_t firstOperand, uint32_t secondOperand)
{
	return firstOperand+secondOperand;
}

