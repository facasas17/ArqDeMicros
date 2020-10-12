/*
 * avgDiff_C.c
 *
 *  Created on: 11 de Oct. de 2020
 *      Author: Fabiola de las Casas Escardó
 */

#include "avgDiff.h"

void avgDifferenceC (uint8_t * vecIn, uint8_t * vecOut, uint32_t length)
{
	uint32_t i = 0;
	uint32_t avg = 0;

	for(i=0; i < length; i++)
	{
		avg += vecIn[i];
	}
	avg = avg /length;
	for(i=0; i < length; i++)
	{
		if (vecIn[i] < avg)
			vecOut[i] = 0;
		else vecOut[i] = vecIn[i] - avg;
		if (vecOut[i] > MAX_NUM)
			vecOut[i] = MAX_NUM;
	}
}
