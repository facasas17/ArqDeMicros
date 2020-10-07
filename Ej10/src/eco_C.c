/*
 * ejercicio3_C.c
 *
 *  Created on: 22 de set. de 2020
 *      Author: dzecchin
 */

#include "eco.h"

void ecoEnC (int16_t * vectorIn, int16_t *vectorEco, uint32_t longitud, uint32_t offsetEco)
{
	uint32_t i = 0, j = 0;

	for(i=0; i < offsetEco; i++)
	{
		vectorEco[i] = vectorIn[i];
	}
	for (i=offsetEco; i<longitud; i++)
	{
		vectorEco[i] = vectorIn[j]/2 + vectorIn[i];
		if(vectorEco[i]>MAX_BITS)
			vectorEco[i] = MAX_BITS;
		j++;
	}
}
