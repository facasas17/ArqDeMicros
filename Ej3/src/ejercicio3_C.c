/*
 * ejercicio3_C.c
 *
 *  Created on: 22 de set. de 2020
 *      Author: dzecchin
 */

#include "ejercicio3.h"

void productoEscalar16EnC (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar)
{
	uint32_t i;

	for(i=0 ; i < longitud ; i++)
	{
		//*(vectorOut+i) = *(vectorIn+i) * escalar;
		vectorOut[i] = vectorIn[i] * escalar;
	}

}
