
PROJ=blinky

CFLAGS=-Wall -Wextra -Wimplicit-function-declaration -Wredundant-decls -Wstrict-prototypes -Wundef -Wshadow -g -fno-common -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -MD
LDFLAGS=--static -lc -lnosys -T stm32.ld -nostartfiles -Wl,--gc-sections -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -lm -Wl,-Map=$(PROJ).map

CC=arm-none-eabi-gcc
OBJCOPY=arm-none-eabi-objcopy

TGTTYPE=libopencm3_stm32f4

OBJS=$(PROJ).o

all: $(PROJ).bin

$(PROJ).bin: $(PROJ).elf
	$(OBJCOPY) -Obinary $(PROJ).elf $(PROJ).bin

$(PROJ).elf: $(OBJS)
	$(CC) -o $(PROJ).elf $(OBJS) $(TGTTYPE).a $(LDFLAGS)

