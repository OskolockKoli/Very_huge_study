#include "RTE_Components.h" 
#include CMSIS_device_header

void delay(volatile uint32_t count){//1 002 560 = 1sec
while(count--)
__NOP();
}
//PB2 - 4000, PB15 - 8000 
int main(){
RCC->AHBENR |= RCC_AHBENR_GPIOBEN; //включаем в работу GPIOB с помощью CMSIS
*(uint32_t*) (0x40021014) |= 0x00040000; //включаем в работу GPIOB с помощью адресов регистров

GPIOB->MODER |= GPIO_MODER_MODER2_0; // уст. линию PB2 в режим вывода с помощью CMSIS
*(uint32_t*) (0x48000400) |= 0x40000000; // уст. линию PB14 в режим вывода с помощью адресов регистров

volatile uint16_t HP=57;
uint8_t st=0;

while(1){
    st=1-st;
    *(uint32_t*)(0x48000418)|=0x00008000;
    delay(HP);
    *(uint32_t*)(0x48000428)|=0x00008000;
    delay(HP);
    if(st==1){
        GPIOB->BSRR =GPIO_BSRR_BS_2;
    }else{
        GPIOB->BSRR =GPIO_BSRR_BR_2;
    }

}
}
