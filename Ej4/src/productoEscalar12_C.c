/*
 * ejercicio3_C.c
 *
 *  Created on: 22 de set. de 2020
 *      Author: dzecchin
 */

#include "productoEscalar12.h"

void productoEscalar12EnC (uint16_t * vectorIn, uint16_t * vectorOut, uint32_t longitud, uint16_t escalar)
{
	uint32_t i;

	for(i=0 ; i < longitud ; i++)
	{
		vectorOut[i] = vectorIn[i] * escalar;
		if (vectorOut[i] > 4095)
			vectorOut[i] = 4095;
	}

}
