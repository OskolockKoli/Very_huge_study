#include "RTE_Components.h"
#include CMSIS_device_header
void delay(volatile uint32_t count){
while(count--)
__NOP();
}
int main(void)
{
// Вспомогательные переменные
volatile uint32_t StartUpCounter = 0, HSEStatus = 0;
SET_BIT(RCC -> CR,RCC_CR_HSEON);// включаем HSE
do {// ждем вхождения в работу HSE
HSEStatus = RCC->CR & RCC_CR_HSERDY;
StartUpCounter++;
} while((HSEStatus == 0) && (StartUpCounter != 0x5000));
//если за 0x5000 итераций, HSE не запустился, то проблемы в аппаратуре
if ((RCC->CR & RCC_CR_HSERDY) != RESET) {
// настраиваем буфер FLASH предварительной выборки команд
FLASH->ACR = FLASH_ACR_LATENCY_1;
// настройка PLL на 28 МГц = 8 МГц(HSE)/2*12
// сначала выключаем чтобы изменить биты PLL, после настройки включим
CLEAR_BIT(RCC -> CR,RCC_CR_PLLON);
// PLLSRC=HSE
// PLLCLK=PLLSRC /2 * 7
RCC->CFGR2 |= (uint32_t)RCC_CFGR2_PREDIV_DIV2;

RCC->CFGR |= (uint32_t)(RCC_CFGR_PLLSRC_HSE_PREDIV| RCC_CFGR_PLLMUL7);
SET_BIT(RCC -> CR,RCC_CR_PLLON); // включаем PLL
// ждём запуск и стабилизацию PLL
while((RCC->CR & RCC_CR_PLLRDY) == 0){}
// выбираем выход PLL источником тактирования МК
RCC->CFGR |= (uint32_t)RCC_CFGR_SW_PLL;
//Ожидаем установки PLL источником тактирования МК
while ((RCC->CFGR & (uint32_t)RCC_CFGR_SWS) != (uint32_t)RCC_CFGR_SWS_PLL){}
}
else
{ while(1){} } // HSE не запустился

SystemCoreClockUpdate();//устанавливается в глобальной переменной SystemCoreClock
// Настройка MCO на PLLCLK/2
SET_BIT(RCC -> CFGR, RCC_CFGR_MCO_PLL);
SET_BIT(RCC -> AHBENR,RCC_AHBENR_GPIOAEN); //разрешаем тактирование GPIOA
//для PA8 устанавливаем Alternate function mode

SET_BIT(GPIOA -> MODER,GPIO_MODER_MODER8_1);
//для восьмой линии выбираем AF0 режим работы MCO
CLEAR_BIT(GPIOA -> AFR[1], GPIO_AFRH_AFRH0_Msk);

//разрешаем тактирование GPIOD GPIOF
SET_BIT(RCC->AHBENR,RCC_AHBENR_GPIODEN);
SET_BIT(RCC->AHBENR,RCC_AHBENR_GPIOFEN);
//устанавливаем работу линий PD13,PF6 на вывод
SET_BIT(GPIOD->MODER,GPIO_MODER_MODER13_0);
SET_BIT(GPIOF->MODER,GPIO_MODER_MODER6_0);

//линию PF6 в режим вывода с открытым стоком
SET_BIT(GPIOF->OTYPER,GPIO_OTYPER_OT_6);
//подтягиваем PF6 к питанию Pull-up
SET_BIT(GPIOF->PUPDR, GPIO_PUPDR_PUPDR6_0);
while(1){
//устанавливаем (1) на выходе линий PD13,PF6
GPIOD->BSRR= GPIO_ODR_13;
GPIOF->BSRR= GPIO_ODR_6;
delay(40); // задержка
//сбрасываем в (0) выходы линий PD13,PF6
GPIOD->BRR= GPIO_ODR_13;
GPIOF->BRR= GPIO_ODR_6;
delay(40);
}
}
