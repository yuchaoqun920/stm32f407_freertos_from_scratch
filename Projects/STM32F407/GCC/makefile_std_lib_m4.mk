
# STD Defines
# DDEFS += -D STM32F40X -D USE_STDPERIPH_DRIVER -D HSE_VALUE=8000000
DDEFS =

# source director
ifeq (${PLATFORM}, f403)
STM32F4_STD_LIB     = $(LIB_DIR)/STM32F4xx_Driver
else
STM32F4_STD_LIB     = $(LIB_DIR)/STM32F4xx_HAL_Driver
endif
STM32F4_CORE_DIR    = $(LIB_DIR)/CMSIS/CM3/CoreSupport
STM32F4_DEVICE_DIR  = $(LIB_DIR)/CMSIS/Device/ST/STM32F4xx
STM32F4_SRC_DIR     = $(STM32F4_STD_LIB)/src
STM32F4_INC_DIR     = $(STM32F4_STD_LIB)/inc

# startup
ASM_SRC  += $(STM32F4_DEVICE_DIR)/Source/Templates/gcc/startup_stm32f407xx.s
#ASM_SRC  += $(PROJECT_DIR)/startup_stm32f405xc.s

# CMSIS
# system in user source folder
#SRC  += $(STM32F4_DEVICE_DIR)/Source/Templates/system_stm32f30x.c
#SRC  += $(STM32F4_CORE_DIR)/core_cm3.c

# use libraries, please add or remove when you use or remove it.
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_adc.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_adc_ex.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_can.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_cortex.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_crc.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_dac.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_dac_ex.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_dma.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_flash.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_flash_ex.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_gpio.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_i2c.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_iwdg.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_pwr.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_rcc.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_rcc_ex.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_rtc.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_rtc_ex.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_spi.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_tim.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_tim_ex.c
SRC  += $(STM32F4_SRC_DIR)/stm32f4xx_hal_uart.c


# include directories
INCLUDE_DIRS += $(STM32F4_CORE_DIR)
INCLUDE_DIRS += $(STM32F4_DEVICE_DIR)
INCLUDE_DIRS += $(STM32F4_INC_DIR)
INCLUDE_DIRS += $(STM32F4_STD_LIB)
INCLUDE_DIRS += $(LIB_DIR)/CMSIS/include
INCLUDE_DIRS += $(STM32F4_DEVICE_DIR)/include
