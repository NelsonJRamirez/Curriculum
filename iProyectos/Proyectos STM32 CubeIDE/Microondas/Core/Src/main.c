/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2023 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "adc.h"
#include "dac.h"
#include "dma.h"
#include "i2c.h"
#include "tim.h"
#include "usart.h"
#include "gpio.h"
#include "max_matrix_stm32.h"
#include "i2c-lcd.h"
#include "math.h"
/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */
// Tamaño de la matriz LED
#define MATRIX_SIZE 8

#define PI 3.1415926

// Define el número de puntos en la onda
#define NUM_PUNTOS 1000

// Arreglo para almacenar los valores de la onda
uint32_t wave_val[NUM_PUNTOS];
/*
void c_wave_square_(double voltDiv, double dutyCycle) {
    int highPeriod = (int)(NUM_PUNTOS * dutyCycle);
    int lowPeriod = NUM_PUNTOS - highPeriod;

    for (int i = 0; i < NUM_PUNTOS; i++) {
        if (i < highPeriod) {
            // Calcular el valor para la parte alta de la onda
            wave_val[i] = (uint32_t)(voltDiv * (4096 / 2));
        } else {
            // Calcular el valor para la parte baja de la onda
            wave_val[i] = 0;
        }
    }
}
*/
void c_wave_square_(double voltDiv, double dutyCycle) {
    int highPeriod = (int)(NUM_PUNTOS * dutyCycle);
    int lowPeriod = NUM_PUNTOS - highPeriod;

    for (int i = 0; i < NUM_PUNTOS; i++) {
        if (i < highPeriod) {
            // Calcular el valor para la parte alta de la onda
            wave_val[i] = (uint32_t)(voltDiv * (4096 / 2));
        } else {
            // Calcular el valor para la parte baja de la onda
            wave_val[i] = 0;
        }
    }
}
// Llamar a la función c_wave_square_ con los valores deseados
double dutyCycle = 0.5;  // Por ejemplo, un ciclo de trabajo del 50%

void c_wave_triangle_(double voltDiv, double dutyCycle) {
    int halfPeriod = NUM_PUNTOS / 2;
    int dutyCyclePoints = halfPeriod * dutyCycle;

    for (int i = 0; i < NUM_PUNTOS; i++) {
        if (i < dutyCyclePoints) {
            // Calcular el valor para la primera mitad de la onda
            wave_val[i] = (uint32_t)((voltDiv * i / dutyCyclePoints) * (4096 / 2));
        } else {
            // Calcular el valor para la segunda mitad de la onda
            wave_val[i] = (uint32_t)((voltDiv * (NUM_PUNTOS - i) / (NUM_PUNTOS - dutyCyclePoints)) * (4096 / 2));
        }
    }
}
/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void) {
	/* USER CODE BEGIN 1 */

	/* USER CODE END 1 */

	/* MCU Configuration--------------------------------------------------------*/

	/* Reset of all peripherals, Initializes the Flash interface and the Systick. */
	HAL_Init();

	/* USER CODE BEGIN Init */

	/* USER CODE END Init */

	/* Configure the system clock */
	SystemClock_Config();

	/* USER CODE BEGIN SysInit */

	/* USER CODE END SysInit */

	/* Initialize all configured peripherals */
	MX_GPIO_Init();
	MX_DMA_Init();
	MX_USART2_UART_Init();
	MX_DAC_Init();
	MX_TIM2_Init();
	MX_ADC1_Init();
	MX_I2C1_Init();
	/* USER CODE BEGIN 2 */
	HAL_TIM_Base_Start(&htim2);
	//if(iSierra == 1)
		c_wave_triangle_(0, 1); // Inicializar la forma de onda sin desplazamiento (voltDiv = 0, timeDiv = 1)

	//if(iSenoidal == 1)
		c_wave_sine_(0,1);

	//if(iCuadrada == 1)
		//c_wave_square_(0,1);
		// Generar la forma de onda cuadrada
		 //   c_wave_square_(3.3, 0.5); // Ejemplo con voltaje de 3.3V y ciclo de trabajo del 50%

	max_init(0x03);
	lcd_init();
	//write_char(3, 1);
	//HAL_Delay(2000);
	HAL_DAC_Start_DMA(&hdac, DAC_CHANNEL_1, wave_val, 100, DAC_ALIGN_12B_R);
	//HAL_DAC_Start_DMA(&hdac1, &led_value, 1);
	/* USER CODE END 2 */
	uint8_t MSG[50] = { '\0' };

	HAL_TIM_Encoder_Start(&htim2, TIM_CHANNEL_ALL);

	int pushButtonPressed = 0;
	int touchCount = 0;
	int iStart1 = 0;

	int previousEncoderValueBackup = 0;
	int previous_iStart1 = 0;
	int encoderValue = 0;
	int previousEncoderValue = 0;

	//double voltDiv = 1.0;  // Valor inicial de Volt/Div
	double timeDiv = 1.0;  // Valor inicial de Volt/Div
	static int iSenoidal = 0;
	static int iCuadrada = 0;
	static int iSierra = 0;
	static int iLinea = 0;
	float voltDivValues[] = {0.41, 0.82, 1.23, 1.64, 2.05, 2.46, 2.87, 3.28, 3.3, 3.3};
	static int buttonPressCount = 0;
	/* Infinite loop */

	// Generar la forma de onda cuadrada
			    double voltDiv = 3.3; // Voltaje pico de la onda
			    double dutyCycle = 0.5; // Ciclo de trabajo del 50%
			    c_wave_square_(voltDiv, dutyCycle);

			    // Generar la onda cuadrada en el pin GPIOA8
			    while (1) {
			        for (int i = 0; i < NUM_PUNTOS; i++) {
			            if (wave_val[i] > 0) {
			                GPIOC->BSRR = GPIO_BSRR_BS_0; // Encender el pin GPIOA8
			            } else {
			                GPIOC->BSRR = GPIO_BSRR_BR_0; // Apagar el pin GPIOA8
			            }

			            // Retraso para ajustar la frecuencXonda
			            for (int delay = 0; delay < 1000; delay++) {
			                // Pequeño retraso
			            }
			        }

		// Mostrar la forma de onda en la matriz LED
		max_clear(); // Limpiar la matriz LED antes de mostrar la siguiente forma de onda

		// Iterar sobre cada columna de la matriz LED
		for (int col = 0; col < MATRIX_SIZE; col++) {
			// Mapear el valor de la forma de onda al rango de la matriz LED
			uint8_t led_value = wave_val[col] / (4096 / MATRIX_SIZE);

			// Encender el LED correspondiente en la columna actual
			setled(col, MATRIX_SIZE - 1 - led_value, 1);

			// Calcular el retraso basado en el valor de timeDiv
			uint32_t delay_ms = (uint32_t)(10 / timeDiv);

			// Retraso opcional para ajustar la velocidad de visualización
			HAL_Delay(delay_ms); // Ajusta el valor según sea necesario
		}

		// Retraso opcional para mantener los LEDs encendidos antes de apagarse progresivamente
		HAL_Delay(10); // Ajusta el valor según sea necesario

		// Apagar los LEDs progresivamente en sentido inverso
		for (int col = MATRIX_SIZE - 1; col >= 0; col--) {
			// Mapear el valor de la forma de onda al rango de la matriz LED
			uint8_t led_value = wave_val[col] / (4096 / MATRIX_SIZE);

			// Apagar el LED correspondiente en la columna actual
			setled(col, MATRIX_SIZE - 1 - led_value, 0);

			// Calcular el retraso basado en el valor de timeDiv
			uint32_t delay_ms = (uint32_t)(10 / timeDiv);

			// Retraso opcional para ajustar la velocidad de apagado
			HAL_Delay(delay_ms); // Ajusta el valor según sea necesario
		}


		 for (int i = 0; i < NUM_PUNTOS; i++) {
		            if (wave_val[i] > 0) {
		                // Encender el pin GPIOA8
		                HAL_GPIO_WritePin(GPIOC, GPIO_PIN_0, GPIO_PIN_SET);
		            } else {
		                // Apagar el pin GPIOA8
		                HAL_GPIO_WritePin(GPIOC, GPIO_PIN_0, GPIO_PIN_RESET);
		            }

		            // Retraso opcional para ajustar la velocidad de la onda
		            //HAL_Delay(50); // Ajusta el valor según sea necesario
		        }


		// Obtener el valor del encoder
		encoderValue = TIM2->CNT;
		if (iSenoidal == 1) {
			if (iStart1 == 0) {
					        // Verificar si el valor de iStart1 ha cambiado de 1 a 0
					        if (previous_iStart1 == 1 && iStart1 == 0) {
					            encoderValue = previousEncoderValueBackup;
					        }

					        // Limitar el valor del encoder a un máximo de 10
					        if (encoderValue > 10) {
					            encoderValue = 10;
					            TIM2->CNT = encoderValue;
					        }

					        // Verificar si el valor del encoder ha cambiado
					        if (encoderValue != previousEncoderValue) {
					            // Calcular el nuevo valor de voltDiv según el valor del encoder
					            voltDiv = encoderValue * 0.1;

					            // Limitar el rango de voltDiv entre 0.1 y 3.0
					            if (voltDiv < 0.1) {
					                voltDiv = 0.1;
					            } else if (voltDiv > 3.0) {
					                voltDiv = 3.0;
					            }

					            // Actualizar la forma de onda con el nuevo voltDiv
					            c_wave_sine_(voltDiv, timeDiv);

					            // Actualizar el valor del encoder previo
					            previousEncoderValue = encoderValue;
					        }
					    } else {
					        // Verificar si el valor de iStart1 ha cambiado de 0 a 1
					        if (previous_iStart1 == 0 && iStart1 == 1) {
					            previousEncoderValueBackup = previousEncoderValue;
					        }

					        // Limitar el valor del encoder a un máximo de 10
					        if (encoderValue > 20) {
					            encoderValue = 20;
					            TIM2->CNT = encoderValue;
					        }

					        // Verificar si el valor del encoder ha cambiado
					        if (encoderValue != previousEncoderValue) {
					            // Calcular el nuevo valor de timeDiv según el valor del encoder
					            timeDiv = encoderValue * 0.1;

					            // Limitar el rango de timeDiv entre 0.1 y 3.0
					            if (timeDiv < 0.1) {
					                timeDiv = 0.1;
					            } else if (timeDiv > 3.0) {
					                timeDiv = 3.0;
					            }

					            // Actualizar la forma de onda con el nuevo timeDiv
					            c_wave_sine_(voltDiv, timeDiv);

					            // Actualizar el valor del encoder previo
					            previousEncoderValue = encoderValue;
					        }
					    }
		}
		if (iCuadrada == 1) {
			if (iStart1 == 0) {
				// Verificar si el valor de iStart1 ha cambiado de 1 a 0
				if (previous_iStart1 == 1 && iStart1 == 0) {
					encoderValue = previousEncoderValueBackup;
				}

				// Limitar el valor del encoder a un máximo de 10
				if (encoderValue > 10) {
					encoderValue = 10;
					TIM2->CNT = encoderValue;
				}

				// Verificar si el valor del encoder ha cambiado
				if (encoderValue != previousEncoderValue) {
					// Calcular el nuevo valor de voltDiv según el valor del encoder
					double voltDiv = encoderValue * 0.1;

					// Limitar el rango de voltDiv entre 0.1 y 3.0
					if (voltDiv < 0.1) {
						voltDiv = 0.1;
					} else if (voltDiv > 3.0) {
						voltDiv = 3.0;
					}

					// Actualizar la forma de onda con el nuevo voltDiv
					c_wave_square_(voltDiv, dutyCycle);

					// Actualizar el valor del encoder previo
					previousEncoderValue = encoderValue;
				}
			} else {
				// Verificar si el valor de iStart1 ha cambiado de 0 a 1
				if (previous_iStart1 == 0 && iStart1 == 1) {
					previousEncoderValueBackup = previousEncoderValue;
				}

				// Limitar el valor del encoder a un máximo de 10
				if (encoderValue > 10) {
					encoderValue = 10;
					TIM2->CNT = encoderValue;
				}

				// Verificar si el valor del encoder ha cambiado
				if (encoderValue != previousEncoderValue) {
					// Calcular el nuevo valor de dutyCycle según el valor del encoder
					double dutyCycle = encoderValue / 10.0;

					// Limitar el rango de dutyCycle entre 0.1 y 0.9
					if (dutyCycle < 0.1) {
						dutyCycle = 0.1;
					} else if (dutyCycle > 0.9) {
						dutyCycle = 0.9;
					}

					// Actualizar la forma de onda con el nuevo dutyCycle
					c_wave_square_(voltDiv, dutyCycle);

					// Actualizar el valor del encoder previo
					previousEncoderValue = encoderValue;
				}
			}

		}
		if (iSierra = 1) {
			if (iStart1 == 0) {
				// Verificar si el valor de iStart1 ha cambiado de 1 a 0
				if (previous_iStart1 == 1 && iStart1 == 0) {
					encoderValue = previousEncoderValueBackup;
				}

				// Limitar el valor del encoder a un máximo de 10
				if (encoderValue > 16) {
					encoderValue = 16;
					TIM2->CNT = encoderValue;
				}

				// Verificar si el valor del encoder ha cambiado
				if (encoderValue != previousEncoderValue) {
					// Calcular el nuevo valor de voltDiv según el valor del encoder
					double voltDiv = encoderValue * 0.1;

					// Limitar el rango de voltDiv entre 0.1 y 3.0
					if (voltDiv < 0.1) {
						voltDiv = 0.1;
					} else if (voltDiv > 3.0) {
						voltDiv = 3.0;
					}

					// Actualizar la forma de onda con el nuevo voltDiv
					c_wave_triangle_(voltDiv, dutyCycle);

					// Actualizar el valor del encoder previo
					previousEncoderValue = encoderValue;
				}
			} else {
				// Verificar si el valor de iStart1 ha cambiado de 0 a 1
				if (previous_iStart1 == 0 && iStart1 == 1) {
					previousEncoderValueBackup = previousEncoderValue;
				}

				// Limitar el valor del encoder a un máximo de 10
				if (encoderValue > 20) {
					encoderValue = 20;
					TIM2->CNT = encoderValue;
				}

				// Verificar si el valor del encoder ha cambiado
				if (encoderValue != previousEncoderValue) {
					// Calcular el nuevo valor de dutyCycle según el valor del encoder
					double dutyCycle = encoderValue / 10.0;

					// Limitar el rango de dutyCycle entre 0.1 y 0.9
					if (dutyCycle < 0.1) {
						dutyCycle = 0.1;
					} else if (dutyCycle > 0.9) {
						dutyCycle = 0.9;
					}

					// Actualizar la forma de onda con el nuevo dutyCycle
					c_wave_triangle_(voltDiv, dutyCycle);

					// Actualizar el valor del encoder previo
					previousEncoderValue = encoderValue;
				}
			}

		}
		// Mostrar el valor del encoder en la I2C LCD
		sprintf(MSG, "Encoder: %d ", encoderValue);
		lcd_put_cur(0, 0);
		lcd_send_string(MSG);

		if (iStart1 == 0) {
			if (iSenoidal == 1 || iCuadrada == 1 || iLinea == 1 && iSierra == 0) {
				// Mostrar el valor de voltDiv en la LCD
				if (encoderValue == 1) {
					sprintf(MSG, "Volt/Div: 0.33 V  ");
				} else if (encoderValue == 2) {
					sprintf(MSG, "Volt/Div: 0.66 V  ");
				} else if (encoderValue == 3) {
					sprintf(MSG, "Volt/Div: 0.99 V  ");
				} else if (encoderValue == 4) {
					sprintf(MSG, "Volt/Div: 1.32 V  ");
				} else if (encoderValue == 5) {
					sprintf(MSG, "Volt/Div: 1.65 V  ");
				} else if (encoderValue == 6) {
					sprintf(MSG, "Volt/Div: 1.98 V  ");
				} else if (encoderValue == 7) {
					sprintf(MSG, "Volt/Div: 2.31 V  ");
				} else if (encoderValue == 8) {
					sprintf(MSG, "Volt/Div: 2.64 V  ");
				} else if (encoderValue == 9) {
					sprintf(MSG, "Volt/Div: 2.97 V  ");
				} else if (encoderValue == 10) {
					sprintf(MSG, "Volt/Div: 3.3 V  ");
				} else {
					sprintf(MSG, "Volt/Div: 0 V ");
				}
			}
			lcd_put_cur(1, 0);
			lcd_send_string(MSG);

			if (iSierra == 1 && iSenoidal == 0 && iCuadrada == 0 && iLinea == 0) {
				// Mostrar el valor de voltDiv en la LCD
				if (encoderValue == 1) {
					sprintf(MSG, "Volt/Div: 0.20 V  ");
				} else if (encoderValue == 2) {
					sprintf(MSG, "Volt/Div: 0.4 V  ");
				} else if (encoderValue == 3) {
					sprintf(MSG, "Volt/Div: 0.6 V  ");
				} else if (encoderValue == 4) {
					sprintf(MSG, "Volt/Div: 0.8 V  ");
				} else if (encoderValue == 5) {
					sprintf(MSG, "Volt/Div: 1 V  ");
				} else if (encoderValue == 6) {
					sprintf(MSG, "Volt/Div: 1.2 V  ");
				} else if (encoderValue == 7) {
					sprintf(MSG, "Volt/Div: 1.4 V  ");
				} else if (encoderValue == 8) {
					sprintf(MSG, "Volt/Div: 1.6 V  ");
				} else if (encoderValue == 9) {
					sprintf(MSG, "Volt/Div: 1.8 V  ");
				} else if (encoderValue == 10) {
					sprintf(MSG, "Volt/Div: 2 V  ");
				} else if (encoderValue == 11) {
					sprintf(MSG, "Volt/Div: 2.2 V  ");
				} else if (encoderValue == 12) {
					sprintf(MSG, "Volt/Div: 2.4 V  ");
				} else if (encoderValue == 13) {
					sprintf(MSG, "Volt/Div: 2.6 V  ");
				} else if (encoderValue == 14) {
					sprintf(MSG, "Volt/Div: 2.8 V  ");
				} else if (encoderValue == 15) {
					sprintf(MSG, "Volt/Div: 3 V  ");
				} else if (encoderValue == 16) {
					sprintf(MSG, "Volt/Div: 3.3 V  ");
				} else {
					sprintf(MSG, "Volt/Div: 0 V");
				}
			}

			lcd_put_cur(1, 0);
			lcd_send_string(MSG);
		}

		if (iStart1 == 1) {
			if (iSenoidal == 1 || iCuadrada == 1 || iLinea == 1 || iSierra == 1) {
				// Mostrar el valor de voltDiv en la LCD
				if (encoderValue == 1) {
					sprintf(MSG, "Time/Div: 0.1 ms  ");
				} else if (encoderValue == 2) {
					sprintf(MSG, "Time/Div: 0.2 ms  ");
				} else if (encoderValue == 3) {
					sprintf(MSG, "Time/Div: 0.3 ms  ");
				} else if (encoderValue == 4) {
					sprintf(MSG, "Time/Div: 0.4 ms  ");
				} else if (encoderValue == 5) {
					sprintf(MSG, "Time/Div: 0.5 ms  ");
				} else if (encoderValue == 6) {
					sprintf(MSG, "Time/Div: 0.6 ms  ");
				} else if (encoderValue == 7) {
					sprintf(MSG, "Time/Div: 0.7 ms  ");
				} else if (encoderValue == 8) {
					sprintf(MSG, "Time/Div: 0.8 ms  ");
				} else if (encoderValue == 9) {
					sprintf(MSG, "Time/Div: 0.9 ms  ");
				} else if (encoderValue == 10) {
					sprintf(MSG, "Time/Div: 1 ms  ");
				} else if (encoderValue == 11) {
					sprintf(MSG, "Time/Div: 1.1 ms  ");
				} else if (encoderValue == 12) {
					sprintf(MSG, "Time/Div: 1.2 ms  ");
				} else if (encoderValue == 13) {
					sprintf(MSG, "Time/Div: 1.3 ms  ");
				} else if (encoderValue == 14) {
					sprintf(MSG, "Time/Div: 1.4 ms  ");
				} else if (encoderValue == 15) {
					sprintf(MSG, "Time/Div: 1.5 ms  ");
				} else if (encoderValue == 16) {
					sprintf(MSG, "Time/Div: 1.6 ms  ");
				} else if (encoderValue == 17) {
					sprintf(MSG, "Time/Div: 1.7 ms  ");
				} else if (encoderValue == 18) {
					sprintf(MSG, "Time/Div: 1.8 ms  ");
				} else if (encoderValue == 19) {
					sprintf(MSG, "Time/Div: 1.9 ms  ");
				} else if (encoderValue == 20) {
					sprintf(MSG, "Time/Div: 2 ms  ");
				} else {
					sprintf(MSG, "Time/Div: 0 ms");
				}
			}
			lcd_put_cur(1, 0);
					lcd_send_string(MSG);

				}
		if (HAL_GPIO_ReadPin(GPIOA, GPIO_PIN_8) == GPIO_PIN_RESET
				&& pushButtonPressed == 0) {
			pushButtonPressed = 1;

			// Incrementar el contador de toques del botón
			touchCount++;
			if (touchCount == 1) {
				lcd_clear();
				lcd_put_cur(0, 14);
				lcd_send_string("1"); // Mostrar "1" en la posición (1,4) de la LCD
				iStart1 = 0;
			} else if (touchCount == 2) {
				lcd_clear();
				lcd_put_cur(0, 14);
				lcd_send_string("2"); // Mostrar "2" en la posición (1,4) de la LCD
				touchCount = 0;  // Reiniciar touchCount a 0
				iStart1 = 1;
			}
		} else if (HAL_GPIO_ReadPin(GPIOA, GPIO_PIN_8) == GPIO_PIN_SET) {
			pushButtonPressed = 0;
		}


		if (HAL_GPIO_ReadPin(GPIOC, GPIO_PIN_13) == GPIO_PIN_RESET) {
		    // El botón está presionado

		    // Incrementar el contador de pulsaciones
		    buttonPressCount++;

			// Cambiar el estado de acuerdo al número de pulsaciones
			if (buttonPressCount == 1) {
				max_clear();
				iSenoidal = 1;
				iCuadrada = 0;
				iSierra = 0;
				iLinea = 0;
				lcd_put_cur(0, 15);
				lcd_send_string("S"); // Mostrar S

			} else if (buttonPressCount == 2) {
				max_clear();
				iSenoidal = 0;
				iCuadrada = 1;
				iSierra = 0;
				iLinea = 0;
				lcd_put_cur(0, 15);
				lcd_send_string("C"); // Mostrar C
			} else if (buttonPressCount == 3) {
				max_clear();
				iSenoidal = 0;
				iCuadrada = 0;
				iSierra = 1;
				iLinea = 0;
				lcd_put_cur(0, 15);
				lcd_send_string("D"); // Mostrar D
			} else if (buttonPressCount == 4) {
				max_clear();
				iSenoidal = 0;
				iCuadrada = 0;
				iSierra = 0;
				iLinea = 1;
				lcd_put_cur(0, 15);
				lcd_send_string("L"); // Mostrar L
			} else if (buttonPressCount == 5) {
				// Reiniciar el contador de pulsaciones y volver al estado inicial
				buttonPressCount = 1;
				iSenoidal = 1;
				iCuadrada = 0;
				iSierra = 0;
				iLinea = 0;
			}
		}

		previousEncoderValue = encoderValue;
		previous_iStart1 = iStart1;
		HAL_Delay(100);
	}

}





void c_wave_sine_(double voltDiv, double timeDiv) {
	for (int i = 0; i < NUM_PUNTOS; i++) {
		// Calcular el desplazamiento de tiempo basado en el valor del encoder
		double timeShift = (double) i * (2 * PI / (NUM_PUNTOS * timeDiv));

		// Calcular el valor de la onda senoidal en el punto actual
		double value = (sin(timeShift) * voltDiv + voltDiv) * (4096 / 2);

		// Almacenar el valor de la onda en el arreglo
		wave_val[i] = (uint32_t) value;
	}
}
/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};
  RCC_PeriphCLKInitTypeDef PeriphClkInit = {0};

  /** Initializes the RCC Oscillators according to the specified parameters
  * in the RCC_OscInitTypeDef structure.
  */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI|RCC_OSCILLATORTYPE_HSE;
  RCC_OscInitStruct.HSEState = RCC_HSE_ON;
  RCC_OscInitStruct.HSEPredivValue = RCC_HSE_PREDIV_DIV1;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
  RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL9;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }

  /** Initializes the CPU, AHB and APB buses clocks
  */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2) != HAL_OK)
  {
    Error_Handler();
  }
  PeriphClkInit.PeriphClockSelection = RCC_PERIPHCLK_I2C1|RCC_PERIPHCLK_ADC1;
  PeriphClkInit.I2c1ClockSelection = RCC_I2C1CLKSOURCE_HSI;
  PeriphClkInit.Adc1ClockSelection = RCC_ADC1PLLCLK_DIV1;

  if (HAL_RCCEx_PeriphCLKConfig(&PeriphClkInit) != HAL_OK)
  {
    Error_Handler();
  }
}

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
	/* User can add his own implementation to report the HAL error return state */
	__disable_irq();
  while (1)
  {
  }
  /* USER CODE END Error_Handler_Debug */
}

#ifdef  USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t *file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */
