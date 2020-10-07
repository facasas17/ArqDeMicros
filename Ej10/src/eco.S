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
	.global eco

	/**
	 * Indicamos que la siguiente subrutina debe ser ensamblada en modo thumb,
	 * entonces en las direcciones en el ultimo bit tendran el 1 para que se reconozcan como en modo thumb.
	 * Siempre hay que ponerla antes de la primer instruccion.
	 */
	.thumb_func


/**
 *	prototipo de la funcion en C
 *
 *	void pack32to16EnC (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud);
 *
 *	En r0 se cargara vectorIn y en r1 se carga vectorOut y en r3 longitud.
*/

#define vectorIn 	r0
#define vectorEco 	r1
#define longitud	r2
#define offsetEco	r3
#define i			r4
#define j			r5
#define aux			r6
#define ecoIn		r7

eco:
 	push {r4-r7,lr}  		/* guardamos la direccion de retorno en la pila */
	mov i, offsetEco 		/* contador del loop, i = longitud vector*/

	// REVISAR INDICE. SI HAY QUE RESTAR 1 O NO
loopSinEco:
	ldrsh aux, [vectorIn, i, LSL 1]
	strh aux, [vectorEco, i, LSL 1]
	subs i, #1
	bpl loopSinEco

	mov j, #0
	mov i, offsetEco 	/* Le resto 1 para hacer el salto bien en el loopConEco */
	add i, #1
loopConEco:
	ldrsh aux, [vectorIn, i, LSL 1]
	ldrsh ecoIn, [vectorIn, j, LSL 1]
	asr ecoIn, #1	/* ecoIn <= ecoIn / 2 */
	adds aux, ecoIn	/* aux = aux + ecoIn*/
	ssat aux, 16, aux
	strh aux, [vectorEco, i, LSL 1]
	add i, #1
	add j, #1
	cmp i, longitud
	bne loopConEco

	pop {r4-r7, pc}	 /* retorno */

	/* otras alternativas para el retorno */
	/* 1. mov pc,lr
	/  2. bx lr */
	/* pop {pc} */
