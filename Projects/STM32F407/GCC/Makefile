

TOOLCHAIN    = arm-none-eabi-
CC           = $(TOOLCHAIN)gcc
CP           = $(TOOLCHAIN)objcopy
AS           = $(TOOLCHAIN)gcc -x assembler-with-cpp
HEX          = $(CP) -O ihex
BIN          = $(CP) -O binary -S

# all the files will be generated with this name (main.elf, main.bin, main.hex, etc)
PROJECT_NAME=f407

# define platform, specify the target processor & bsp		f105, f401
#PLATFORM     = f105
# PLATFORM     = f401
PLATFORM     = f407

# define mcu, specify the target processor
ifeq (${PLATFORM}, f105)
MCU          = cortex-m3
$(warning MCU cortex-m3) 
endif

ifeq (${PLATFORM}, f401)
MCU          = cortex-m4
$(warning MCU cortex-m4) 
endif

ifeq (${PLATFORM}, f407)
MCU          = cortex-m4
$(warning MCU cortex-m4) 
endif

ifndef MCU
$(error MCU not specified!) 
endif


# define root dir
ROOT_DIR     = ./../../../
# TOP_ROOT_DIR = ./../../../

# define include dir
INCLUDE_DIRS =

# define stm32f10x std lib dir
LIB_DIR      = $(ROOT_DIR)/Drivers

# define freertos dir
FREERTOS_DIR = $(ROOT_DIR)/Middlewares/Third_Party/FreeRTOS/Source
#FREERTOS_DIR = $(TOP_ROOT_DIR)/stm32/bootloader/Middlewares/Third_Party/FreeRTOS/Source

# define user dir
PROJECT_DIR     = ../
USER_DIR        = $(PROJECT_DIR)/Src
BSP_DIR 		= $(ROOT_DIR)/Drivers/BSP/STM32F4-Discovery
# COMMON_DIR      = $(TOP_ROOT_DIR)/common
PLATFORM_DIR 	= $(USER_DIR)/$(PLATFORM)
MTM_PROTOCOL_DIR = $(COMMON_DIR)/mtm_protcol
MODBUS_DIR      = $(ROOT_DIR)/Middlewares/Third_Party/MODBUS
UNITYTEST_DIR   = $(ROOT_DIR)/Middlewares/Third_Party/UnityTest
# BOOTLOADER_DIR  = $(TOP_ROOT_DIR)/stm32/bootloader/

# define bin dir
BIN_DIR      = $(PROJECT_DIR)/bin
BUILD_DIR = build
OBJ_DIR = $(BUILD_DIR)/obj
DEPS_DIR  = $(BUILD_DIR)/deps

# Modbus Slave
# ifeq (${MB_SLAVE}, 1)
# UNITTEST=1
# endif

# link file
ifeq (${PLATFORM}, f407)
# LINK_SCRIPT  = $(PROJECT_DIR)/GCC/stm32_flash_f407.ld
LINK_SCRIPT  = $(PROJECT_DIR)/GCC/STM32F407VGTx_FLASH.ld
endif

ifeq (${PLATFORM}, f401)
LINK_SCRIPT  = $(PROJECT_DIR)/GCC/stm32_flash_f407.ld
endif

ifeq (${PLATFORM}, f105)
LINK_SCRIPT  = $(PROJECT_DIR)/GCC/stm32_flash_f105.ld
endif

# user specific
SRC       =
ASM_SRC   =
SRC      += $(PROJECT_DIR)/GCC/syscalls.c
SRC      += $(BSP_DIR)/stm32f4_discovery.c
SRC      += $(USER_DIR)/main.c
SRC      += $(USER_DIR)/stm32f4xx_it.c
SRC      += $(USER_DIR)/system_stm32f4xx.c
SRC      += $(USER_DIR)/stm32f4xx_hal_msp.c

ifeq (${UNITTEST}, 1)
SRC      += $(UNITYTEST_DIR)/unity.c
SRC      += $(USER_DIR)/UnityTest/TestProductionCode.c
SRC      += $(USER_DIR)/UnityTest/test_runners/TestProductionCode_Runner.c
endif

# user include
INCLUDE_DIRS    = $(ROOT_DIR)
INCLUDE_DIRS    += $(ROOT_DIR)/Inc
ifeq (${PLATFORM}, f407)
INCLUDE_DIRS    += $(ROOT_DIR)/Inc/f4xx
# $(warning $(ROOT_DIR)/Inc/f4xx)
else
INCLUDE_DIRS    += $(ROOT_DIR)/Inc/f1xx
# $(warning $(ROOT_DIR)/Inc/f1xx)
endif
INCLUDE_DIRS    += $(BSP_DIR)
INCLUDE_DIRS    += $(PROJECT_DIR)/Inc
INCLUDE_DIRS    += $(ROOT_DIR)/libs
INCLUDE_DIRS    += $(ROOT_DIR)/libs/sys_log/include
INCLUDE_DIRS    += $(ROOT_DIR)/libs/middle_driver/inc
INCLUDE_DIRS    += $(ROOT_DIR)/Drivers/MNC/Inc
INCLUDE_DIRS    += $(USER_DIR)/update
INCLUDE_DIRS    += $(COMMON_DIR)
INCLUDE_DIRS    += $(COMMON_DIR)/ddf_com
INCLUDE_DIRS    += $(COMMON_DIR)/img_com
INCLUDE_DIRS    += $(COMMON_DIR)/lib_com
INCLUDE_DIRS    += $(COMMON_DIR)/mtm_protcol
INCLUDE_DIRS    += $(FREERTOS_DIR)/include
INCLUDE_DIRS    += $(MODBUS_DIR)/include
INCLUDE_DIRS    += $(MODBUS_DIR)/port
INCLUDE_DIRS    += $(MODBUS_DIR)/rtu
INCLUDE_DIRS    += $(UNITYTEST_DIR)
INCLUDE_DIRS    += $(USER_DIR)/UnityTest
INCLUDE_DIRS    += $(USER_DIR)
INCLUDE_DIRS    += $(ROOT_DIR)/FWLIB/inc
INCLUDE_DIRS    += $(ROOT_DIR)/CORE
INCLUDE_DIRS    += $(BOOTLOADER_DIR)/UnityTest

# include sub makefiles
ifeq (${PLATFORM}, f407)
include makefile_std_lib_m4.mk   # STM32 Standard Peripheral Library
include makefile_freertos_m4.mk  # freertos source
else
include makefile_std_lib.mk   # STM32 Standard Peripheral Library
include makefile_freertos.mk  # freertos source
endif

INCDIR  = $(patsubst %, -I%, $(INCLUDE_DIRS))

# run from Flash
DEFS	 = $(DDEFS) -DRUN_FROM_FLASH=1

OBJECTS  = $(ASM_SRC:.s=.o) $(SRC:.c=.o)

# Define optimisation level here
OPT = -Os

# M4
# MC_FLAGS = -mcpu=$(MCU) -mfpu=fpv4-sp-d16 -mfloat-abi=softfp -D STM32F105xC -D STM32F401xC
MC_FLAGS = -mcpu=$(MCU) -ffunction-sections -fdata-sections
#MC_FLAGS = -mcpu=$(MCU) -ffunction-sections -fdata-sections -D STM32F105xC -D NOBOOTLOADER

ifeq (${PLATFORM}, f407)
MC_FLAGS += -D STM32F407xx -D STM32F40_41xxx -D USE_STDPERIPH_DRIVER
# MC_FLAGS += -D STM32F401xC
else
MC_FLAGS += -D STM32F105xC
endif

ifeq (${MB_SLAVE}, 1)
MC_FLAGS += -D CONFIG_MODBUS_SLAVE=1 -D SYSLOG_DIRECT_PRINT=1
endif
ifeq (${UNITTEST}, 1)
# MC_FLAGS += -D NOBOOTLOADER=1 -D UNITTEST=1 -D SYSLOG_DIRECT_PRINT=1
MC_FLAGS += -D UNITTEST=1 -D SYSLOG_DIRECT_PRINT=1
OPT = -Os
endif

# Use Short Filename While logging
# MC_FLAGS += -U__FILE__ -D__FILE__='"$(subst $(dir $<),,$<)"'
MC_FLAGS += -DHOST_COMPILER_LINUX=1 

ifeq (${PLATFORM}, f407)
MC_FLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16 
endif

AS_FLAGS = $(MC_FLAGS) -mthumb  -Wa,-amhls=$(<:.s=.lst)
CP_FLAGS = $(MC_FLAGS) $(OPT) -mthumb -fomit-frame-pointer -Wall -fverbose-asm -Wa,-ahlms=$(<:.c=.lst) $(DEFS)
LD_FLAGS = $(MC_FLAGS) -mthumb -Xlinker --gc-sections -T$(LINK_SCRIPT) -Wl,-Map=$(PROJECT_NAME).map,--cref,--no-warn-mismatch $(LIBDIR) $(LIB)

DEBUG = 1
ifeq (${DEBUG}, 1)
AS_FLAGS += -g
CP_FLAGS += -g
LD_FLAGS += -g --specs=nano.specs
endif
#
# makefile rules
#
all: $(OBJECTS) $(PROJECT_NAME).elf  $(PROJECT_NAME).hex $(PROJECT_NAME).bin
	$(TOOLCHAIN)size $(PROJECT_NAME).elf

%o: %c
	$(CC) -c $(CP_FLAGS) -I . $(INCDIR) $< -o $@

%o: %s
	$(AS) -c $(AS_FLAGS) $< -o $@

%elf: $(OBJECTS)
	$(CC) $(OBJECTS) $(LD_FLAGS) $(LIBS) -o $@

%hex: %elf
	$(HEX) $< $@

%bin: %elf
	$(BIN)  $< $@

z2flash: $(PROJECT).bin
	st-flash --reset write $(PROJECT).bin 0x0800A000
	-rm -rf .bin
	-rm -rf .elf
	-rm -rf .hex
	-rm -rf .map 

z21flash: $(PROJECT).bin
	st-flash --reset write $(PROJECT).bin 0x08010000
	-rm -rf .bin
	-rm -rf .elf
	-rm -rf .hex
	-rm -rf .map 

erase:
	st-flash erase

	

clean:
	-rm -rf $(OBJECTS)
	-rm -rf $(PROJECT_NAME).elf
	-rm -rf $(PROJECT_NAME).map
	-rm -rf $(PROJECT_NAME).hex
	-rm -rf $(PROJECT_NAME).bin
	-rm -rf $(SRC:.c=.lst)
	-rm -rf $(ASM_SRC:.s=.lst)

