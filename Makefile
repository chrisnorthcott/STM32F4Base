
PROJ=test

CFLAGS=-DSTM32F4 -I./ocm-includes -Wall -Wextra -Wimplicit-function-declaration -Wredundant-decls -Wstrict-prototypes -Wundef -Wshadow -g -fno-common -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -MD
LDFLAGS=--static -L./ocm-libs -lc -lnosys -T stm32.ld -nostartfiles -Wl,--gc-sections -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -lm -Wl,-Map=$(PROJ).map

CC=arm-none-eabi-gcc
OBJCOPY=arm-none-eabi-objcopy

TGTTYPE=libopencm3_stm32f4

OBJS=$(PROJ).o

all: $(PROJ).bin

$(PROJ).bin: $(PROJ).elf
	$(OBJCOPY) -Obinary $(PROJ).elf $(PROJ).bin

$(PROJ).elf: $(OBJS)
	$(CC) -o $(PROJ).elf $(OBJS) $(TGTTYPE).a $(LDFLAGS)

test: $(PROJ).elf
	echo "ST-Link should be running";
	arm-none-eabi-gdb $(PROJ.elf) -ex "target extended-remote :4242" -ex "load" -ex "kill" -ex "continue"

clean:
	rm *.o *.elf *.bin *.map *.d
