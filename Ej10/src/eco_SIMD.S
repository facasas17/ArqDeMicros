/** Ejemplo de archivo de assembler */

/* Copyright 2018, Facundo Larosa - Danilo Zecchin
 * All rights reserved.
 *
 * This file is part of arquitecturaDeMicroprocesadores.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived from this
 *    software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 */

	/**
	 * Directiva al ensablador que permite indicar que se encarga de buscar
	 * la instruccion mas apropiada entre thumb y thumb2
	 */
	.syntax unified

	/**
	 * .text permite indicar una seccion de codigo.
	 */
	.text

	/**
	 * .global permite definir un simbolo exportable,
	 * es decir que podemos verlo desde otros modulos (equivalente a extern).
     * Definimos la rutina como global para que sea visible desde otros modulos.
     */
	.global ecoSIMD

	/**
	 * Indicamos que la siguiente subrutina debe ser ensamblada en modo thumb,
	 * entonces en las direcciones en el ultimo bit tendran el 1 para que se reconozcan como en modo thumb.
	 * Siempre hay que ponerla antes de la primer instruccion.
	 */
	.thumb_func


/**
 *	prototipo de la funcion en C
 *
 *  void ecoEnC (int16_t * vectorIn, int16_t *vectorEco, uint32_t longitud, uint32_t offsetEco);
 *
*/
#define ARRAY_ECO  6

#define vectorIn 	r0
#define vectorEco 	r1
#define longitud	r2
#define offsetEco	r3
#define j 			r4
#define i 			r5
#define division    r6
#define actual		r7
#define ceros       r8
#define eco_cant	r9

ecoSIMD:
 	push {r3-r9,lr}  /* guardamos la direccion de retorno en la pila */

	mov i, #0 			/* contador del loop, i = 0*/
	mov j, #0 			/* contador del loop, i = 0*/
	asr  longitud,1		/* longitud <= longitud/2 porque trabajo con registros de 32b pero uso vectores de 16b*/
	mov eco_cant, offsetEco
	asr  eco_cant,1		/* eco_cant <= eco_cant/2 porque trabajo con la mitad de ciclos */

loopSinEco:
  	ldr  actual, [vectorIn, i, LSL 2]	/* Me muevo de a 32 bits */
  	str  actual, [vectorEco, i, LSL 2]
  	add i, 1
  	cmp i, eco_cant
  	bne loopSinEco

	mov ceros, #0

loopConEco:
  	ldr 	actual, [vectorIn, i, LSL 2]
  	ldr 	division, [vectorIn, j, LSL 2]
  	shadd16 division,division,ceros	/* Sumo ceros y divido por 2.  */
  	qadd16	actual, actual, division
	str  	actual, [vectorEco, i, LSL 2]
  	add 	i, 1
  	add 	j, 1
  	cmp 	longitud, i
  	bne 	loopConEco

	pop {r3-r9,pc}   /* retorno */

	/* otras alternativas para el retorno */
	/* 1. mov pc,lr
	/  2. bx lr */
	/* pop {pc} */
