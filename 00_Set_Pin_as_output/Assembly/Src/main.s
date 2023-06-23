
@Se definen algunas constantes utilizando la directiva .equ
.equ RCC_BASE,				0x40023800
.equ AHB1ENR_OFFSET,		0x30

.equ RCC_AHB1ENR,			(RCC_BASE + AHB1ENR_OFFSET)
.equ GPIOA_BASE,			0x40020000

.equ GPIOA_MODDER_OFFSET,	0x00
.equ GPIOA_MODDER,			(GPIOA_BASE + GPIOA_MODDER_OFFSET)

.equ GPIOA_ODR_OFFSET,		0x14
.equ GPIOA_ODR,				(GPIOA_BASE + GPIOA_ODR_OFFSET)


.equ GPIOA_EN,				(1<<0)
.equ MODDER5_OUT,			(1<<10)
.equ LED_ON,				(1<<5)


				.syntax unified @ sintaxis unificada
				.cpu cortex-m4  @ el procesador objetivo es Cortex-M4
				.fpu softvfp    @ se utilizará una FPU (unidad de punto flotante) de software
				.thumb          @ el código será en modo Thumb (un conjunto de instrucciones de 16 bits)
				.section	.text
				.globl	__main

__main: @  función principal del programa

				/*Enable clock acces to GPIOA*/

				//load address of RCC_AHB1ENR to r0
				ldr r0,=RCC_AHB1ENR @  Carga en el registro r0 el valor de la dirección de memoria asociada a la etiqueta RCC_AHB1ENR.
									@  La instrucción ldr se utiliza para cargar un valor de memoria en un registro.



				//load value at address found in r0 into r1
				ldr r1,[r0] @ Carga en el registro r1 el valor almacenado en la dirección de memoria contenida en el registro r0.
				            @ En este caso, se está cargando el valor contenido en la dirección de memoria asociada a RCC_AHB1ENR en el registro r1.

				orr r1,#GPIOA_EN @ Realiza una operación OR bit a bit entre el valor almacenado en el registro r1 y el valor de la etiqueta GPIOA_EN.
				                 @ Luego, el resultado se almacena nuevamente en el registro r1.
				                 @ Esta instrucción se utiliza para establecer un bit específico en el registro r1.



				//store content in r1 at address found in r0
				str r1,[r0] @ Almacena el valor contenido en el registro r1 en la dirección de memoria contenida en el registro r0.
				            @ En este caso, se está almacenando el valor actualizado en RCC_AHB1ENR.



				/*Set PAS as output*/
				ldr r0,=GPIOA_MODDER @ Carga en el registro r0 el valor de la dirección de memoria asociada a la etiqueta GPIOA_MODDER.
									 @ Al igual que en la primera instrucción, se utiliza ldr para cargar una dirección de memoria en un registro.

				ldr r1,[r0] @ Carga en el registro r1 el valor almacenado en la dirección de memoria contenida en el registro r0.
				            @ Aquí, se está cargando el valor contenido en la dirección de memoria asociada a GPIOA_MODDER en el registro r1.
				orr r1,#MODDER5_OUT @ Realiza una operación OR bit a bit entre el valor almacenado en el registro r1 y el valor de la etiqueta MODDER5_OUT.
				                    @ Luego, el resultado se almacena nuevamente en el registro r1.
				str r1,[r0] @ Almacena el valor contenido en el registro r1 en la dirección de memoria contenida en el registro r0.
				            @ En este caso, se está almacenando el valor actualizado en GPIOA_MODDER.



				/*Set PAS high*/
				ldr r0,=GPIOA_ODR @ Carga en el registro r0 el valor de la dirección de memoria asociada a la etiqueta GPIOA_ODR.
				LDR R1,=LED_ON @ Carga en el registro r1 el valor de la etiqueta LED_ON.
				str r1,[r0] @ Almacena el valor contenido en el registro r1 en la dirección de memoria contenida en el registro r0.
				            @ En este caso, se está almacenando el valor de LED_ON en GPIOA_ODR.

				bx lr @ Realiza un salto a la dirección de retorno contenida en el registro lr.
				      @ Esta instrucción se utiliza para salir de la función y volver al llamador.




				.align
				.end
