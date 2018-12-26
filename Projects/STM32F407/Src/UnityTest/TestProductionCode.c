
#include "unity.h"
#include "stdio.h"
#include "cmsis_os.h"
#include "stm32f4_discovery.h"

/* sometimes you may want to get at local data in a module.
 * for example: If you plan to pass by reference, this could be useful
 * however, it should often be avoided */
//extern sys_config_t sys_cfg;

#define __MODELE_NAME__ "UNITTEST"

#if 1
#define UNITY_LOG(FORMAT, ...)           do{\
        printf("T%08d", HAL_GetTick()); \
		printf("[%s %d]", __MODELE_NAME__, __LINE__);printf(FORMAT"\n",##__VA_ARGS__);\
	}while(0)
#else
#define UNITY_LOG(...)
#endif

/* Global variables ---------------------------------------------------------*/

void setUp(void)
{
    /* This is run before EACH TEST */
}

void tearDown(void)
{
}

void test_Run1(void)
{
    UNITY_LOG("[HAL] Version: %08X, RevID: %08X, DevID: %08X",
              HAL_GetHalVersion(), HAL_GetREVID(), HAL_GetDEVID());
    uint32_t uid[3];
    HAL_GetUID(uid);
    UNITY_LOG("[UID] %08X %08X %08X", uid[0], uid[1], uid[2]);
}

void test_systime(void)
{
    UNITY_LOG("[SYSTICK] CTL: %X", SysTick->CTRL);
    UNITY_LOG("[SYSTICK] LOAD: %X", SysTick->LOAD);
    UNITY_LOG("[SYSTICK] VAL: %X", SysTick->VAL);
    UNITY_LOG("[SYSTICK] CALIB: %X", SysTick->CALIB);

    UNITY_LOG("Tick Freq: %d", HAL_GetTickFreq());
    uint32_t time_start = HAL_GetTick();
    osDelay(5000);
    uint32_t time_stop = HAL_GetTick();
    UNITY_LOG("[TIME] %d-%d=%d", time_stop, time_start, time_stop - time_start);

    time_start = HAL_GetTick();
    UNITY_LOG("HAL Delay Start");
    HAL_Delay(5000);
    time_stop = HAL_GetTick();
    UNITY_LOG("[TIME2] %d-%d=%d", time_stop, time_start, time_stop - time_start);

    TEST_ASSERT_EQUAL(time_stop - time_start, 100);
}