/*
 * ejercicio3_C.c
 *
 *  Created on: 22 de set. de 2020
 *      Author: dzecchin
 */

#include "maximo.h"

void maxC (int32_t * vectorIn, uint32_t longitud, uint32_t *indice)
{
	uint32_t i = 0;

	for(i=0; i < longitud; i++)
	{
		if (vectorIn[i] > vectorIn[*indice])
			*indice = i;
	}
}
