/*
 * ejercicio3_C.c
 *
 *  Created on: 22 de set. de 2020
 *      Author: dzecchin
 */

#include "pack32to16.h"

void pack32to16EnC (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud)
{
	uint32_t i = 0;

	for(i=0; i < longitud; i++)
	{
		vectorOut[i] = vectorIn[i] & 0x0000FFFF;
	}
}
