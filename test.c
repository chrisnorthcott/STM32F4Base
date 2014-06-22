#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>

static void setup(void)
{
	//set up leds (D12-D15)
	rcc_periph_clock_enable(RCC_GPIOD);
	gpio_mode_setup(GPIOD, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, GPIO12|GPIO13|GPIO14|GPIO15);
	//set up button (A0)
	rcc_periph_clock_enable(RCC_GPIOA);
	gpio_mode_setup(GPIOA, GPIO_MODE_INPUT, GPIO_PUPD_NONE, GPIO0);
}

static void wait(int us)
{
	int i;
	for(i=0; i<us; i++){
		__asm__("nop");
	}
}

volatile int button_pressed = 0;

static void loop()
{
	if((GPIOA_IDR & (1 << 0)) != 0){
		if(button_pressed == 0)
			button_pressed = 1;
		else
			button_pressed = 0;

	if(button_pressed == 0)
		gpio_clear(GPIOD, GPIO14);
		gpio_clear(GPIOD, GPIO15);
		gpio_toggle(GPIOD, GPIO12);
		wait(50000);
		gpio_toggle(GPIOD, GPIO13);
		wait(50000);
	}else{
		gpio_clear(GPIOD, GPIO12);
		gpio_clear(GPIOD, GPIO13);
		gpio_toggle(GPIOD, GPIO14);
		wait(50000);
		gpio_toggle(GPIOD, GPIO15);
		wait(50000);
	}
}

int main(void)
{
	setup();

	/* Blink the LED (PC8) on the board. */
	while (1) {
		loop();
	}

	return 0;
}
