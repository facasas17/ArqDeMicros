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
	.global avgDifferenceASM

	/**
	 * Indicamos que la siguiente subrutina debe ser ensamblada en modo thumb,
	 * entonces en las direcciones en el ultimo bit tendran el 1 para que se reconozcan como en modo thumb.
	 * Siempre hay que ponerla antes de la primer instruccion.
	 */
	.thumb_func


/**
 *	prototipo de la funcion en C
 *
 *	void avgDifferenceC (uint8_t * vecIn, uint8_t * vecOut, uint32_t length);
 *
 *	En r0 se cargara vecIn, en r1 vecOut y en r2 length.
*/

#define vecIn 	r0
#define vecOut 	r1
#define length	r2
#define i		r3
#define avg		r4
#define aux		r5

avgDifferenceASM:
 	push {r4-r5,lr}  	/* guardamos la direccion de retorno en la pila */

 	mov i, #0			/* Inicio contador de loop */
 	mov avg, #0

loopAvg:
	ldrb aux, [vecIn, i]	/* Cargo aux=*(vecIn+i) */
	add avg, avg, aux
	add i, #1				/* Me desplazo de a 1 porque estan en bloques de 8bits */
	usat avg, 8, avg		/* Chequeo saturacion */
	cmp i, length
	bne loopAvg
	udiv avg, avg, length

	mov i, #0

loopDiff:
	ldrb aux, [vecIn, i]	/* Cargo aux=*(vecIn+i) */
	subs aux, aux, avg
	usat aux, 8, aux		/* Chequeo saturacion */
	strb aux, [vecOut, i]
	add i, #1
	cmp i, length
	bne loopDiff

	pop {r4-r5, pc}	 /* retorno */

	/* otras alternativas para el retorno */
	/* 1. mov pc,lr
	/  2. bx lr */
	/* pop {pc} */
