extern void setup(void);
extern void loop(void);

void setup()
{

}

void loop()
{
	__asm("nop");
}

/* Arduino-like Setup/Loop structure */

int main(void)
{
	setup();
	while(1)
	{
		loop();
	}
}
