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
#include "dma.h"
#include "tim.h"
#include "usart.h"
#include "gpio.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
#include "max_matrix_stm32.h"
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
#define MATRIX_SIZE 8 // Tamaño de la matriz LED
#define ADC_MAX_VALUE 3682 // Valor máximo del ADC
#define VOLTAGE_MAX 2.7 // Voltaje máximo suministrado por el generador de funciones

// Matriz LED
uint8_t led_matrix[MATRIX_SIZE][MATRIX_SIZE];

// Valor actual de Volt/Div
double volt_div = 1.0; // Valor inicial de Volt/Div

// Función para mostrar la matriz LED
void display_led_matrix() {
    for (uint8_t row = 0; row < MATRIX_SIZE; row++) {
        for (uint8_t col = 0; col < MATRIX_SIZE; col++) {
            setled(col, row, led_matrix[row][col]);
        }
    }
}

// Función para actualizar la matriz LED con los valores de la forma de onda
void update_led_matrix(uint32_t adc_value) {
    // Mapear el valor del ADC al rango de la matriz LED
    uint32_t led_value = (adc_value * MATRIX_SIZE) / ADC_MAX_VALUE;

    // Actualizar la matriz LED con los valores de la forma de onda
    for (uint8_t row = 0; row < MATRIX_SIZE; row++) {
        for (uint8_t col = 0; col < MATRIX_SIZE; col++) {
            if (col < led_value && row == col) {
                led_matrix[row][col] = 1;
            } else {
                led_matrix[row][col] = 0;
            }
        }
    }
}

// Función para leer el valor del encoder
int read_encoder() {
    return (TIM2->CNT >> 2);
}
//uint32_t medida;

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

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
	MX_ADC1_Init();
	MX_TIM1_Init();
	/* USER CODE BEGIN 2 */
	//HAL_ADC_Start_DMA(&hadc1, &medida, 1); //max value = 3682
	max_init(0x03);
	/* USER CODE END 2 */
	write_char(3, 1);
	HAL_Delay(2000);
	/* Infinite loop */
	/* USER CODE BEGIN WHILE */
	max_clear();
	HAL_TIM_Encoder_Start(&htim2, TIM_CHANNEL_ALL);

	    // Configurar la matriz LED
	    // Asegúrate de tener la función setled correctamente implementada y configurada para tu hardware

	    while (1) {
	        // Leer el valor analógico del ADC
	        uint32_t adc_value = 0;
	        HAL_ADC_Start_DMA(&hadc1, &adc_value, 1);

	        // Actualizar el valor de Volt/Div según el encoder
	        int encoder_value = read_encoder();
	        volt_div = encoder_value * 0.1;

	        // Ajustar el voltaje máximo según el valor de Volt/Div
	        double voltage_max_adjusted = VOLTAGE_MAX / volt_div;

	        // Actualizar la matriz LED con los valores de la forma de onda
	        update_led_matrix((adc_value * voltage_max_adjusted) / ADC_MAX_VALUE);

	        // Mostrar la matriz LED
	        display_led_matrix();
	    }
	}
/**
 * @brief System Clock Configuration
 * @retval None
 */
void SystemClock_Config(void) {
	RCC_OscInitTypeDef RCC_OscInitStruct = { 0 };
	RCC_ClkInitTypeDef RCC_ClkInitStruct = { 0 };
	RCC_PeriphCLKInitTypeDef PeriphClkInit = { 0 };

	/** Initializes the RCC Oscillators according to the specified parameters
	 * in the RCC_OscInitTypeDef structure.
	 */
	RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
	RCC_OscInitStruct.HSEState = RCC_HSE_ON;
	RCC_OscInitStruct.HSEPredivValue = RCC_HSE_PREDIV_DIV1;
	RCC_OscInitStruct.HSIState = RCC_HSI_ON;
	RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
	RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
	RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL9;
	if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK) {
		Error_Handler();
	}

	/** Initializes the CPU, AHB and APB buses clocks
	 */
	RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK | RCC_CLOCKTYPE_SYSCLK
			| RCC_CLOCKTYPE_PCLK1 | RCC_CLOCKTYPE_PCLK2;
	RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
	RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
	RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
	RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

	if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2) != HAL_OK) {
		Error_Handler();
	}
	PeriphClkInit.PeriphClockSelection =
			RCC_PERIPHCLK_TIM1 | RCC_PERIPHCLK_ADC1;
	PeriphClkInit.Tim1ClockSelection = RCC_TIM1CLK_HCLK;
	PeriphClkInit.Adc1ClockSelection = RCC_ADC1PLLCLK_DIV1;

	if (HAL_RCCEx_PeriphCLKConfig(&PeriphClkInit) != HAL_OK) {
		Error_Handler();
	}
}

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */

/**
 * @brief  This function is executed in case of error occurrence.
 * @retval None
 */
void Error_Handler(void) {
	/* USER CODE BEGIN Error_Handler_Debug */
	/* User can add his own implementation to report the HAL error return state */
	__disable_irq();
	while (1) {
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
