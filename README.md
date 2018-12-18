基于探索者F4开发板，实现stm32f407+freertos和基本的单元测试

### 0 基础SDK：
STM32Cube_FW_F4_V1.23.0

### 1 printf重定向到串口  

```
#ifdef __GNUC__
#define PUTCHAR_PROTOTYPE int __io_putchar(int ch)
#else
#define PUTCHAR_PROTOTYPE int fputc(int ch, FILE *f)
#endif

PUTCHAR_PROTOTYPE
{
HAL_UART_Transmit( &huart_debug, ( uint8_t* )&ch, 1, 100 );
return ch;
}
```


### 3 FreeRTOS  
[FreeRTOS在STM32F4上移植](https://blog.csdn.net/Zach_z/article/details/77435898)
[STM32CubeF4 FreeRTOS Examples don't work correctly with HAL_GetTick](https://www.cnblogs.com/shangdawei/p/4684798.html)
#### 3.1 添加响应的c文件；  
#### 3.2 配置freeRTOSConfig.h
#### 3.3 增加task代码；  
#### 3.4 去除SVC_Handler和PendSV_Handler，不然编译错误；  
```
./../../..//Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/port.o: In function `SVC_Handler':
/Users/yuchaoqun/Desktop/Didi.so/Project/stm32f407_freertos_from_scratch/Projects/STM32F407/GCC/../../..//Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/port.c:275: multiple definition of `SVC_Handler'
..//Src/stm32f4xx_it.o:stm32f4xx_it.c:(.text.SVC_Handler+0x0): first defined here
./../../..//Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/port.o: In function `PendSV_Handler':
/Users/yuchaoqun/Desktop/Didi.so/Project/stm32f407_freertos_from_scratch/Projects/STM32F407/GCC/../../..//Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/port.c:439: multiple definition of `PendSV_Handler'
..//Src/stm32f4xx_it.o:stm32f4xx_it.c:(.text.PendSV_Handler+0x0): first defined here
collect2: error: ld returned 1 exit status
make: *** [f407.elf] Error 1
```

#### 3.5 put osSystickHandler in SysTick_Handler  
```
/**
* @brief This function handles SysTick Handler.
* @param None
* @retval None
*/
void SysTick_Handler(void)
{
HAL_IncTick();
osSystickHandler();
}
```