# Convert main.elf into an executable memory initialization file main.hex

current_dir = $(shell pwd)

# Path to CELLRV32 executable generator
CELLRV32_EXG_PATH = ../cellrv32/sw/image_gen

# RISC-V GCC
RISCV_PREFIX ?= riscv32-unknown-elf-
OBJCOPY = $(RISCV_PREFIX)objcopy

# Host native compiler
CC_X86 = gcc -Wall -O -g

# CELLRV32 executable image generator
IMAGE_GEN = $(CELLRV32_EXG_PATH)/image_gen

# install/compile tools
$(IMAGE_GEN): $(CELLRV32_EXG_PATH)/image_gen.c
	@echo Compiling $(IMAGE_GEN)
	@$(CC_X86) $< -o $(IMAGE_GEN)

# Generate final executable from .text (defined by platform-specific linker script)
main.bin: $(current_dir)/main.elf
	@$(OBJCOPY) -I elf32-little $< -j .text -O binary $@

# Generate CELLRV32 RAW executable image in plain hex format
main.hex: main.bin $(IMAGE_GEN)
	@set -e
	@$(IMAGE_GEN) -raw_hex $< $@ $(shell basename $(CURDIR))

# Remove artifacts
clean:
	@rm -f *.o *.bin *.out *.hex *.signature
