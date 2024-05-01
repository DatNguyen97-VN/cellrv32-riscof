#!/usr/bin/env bash

set -e

cd $(dirname "$0")

# prepare simulation output files for UART0 simulation mode
# -> direct simulation output (neorv32.uart0.sim_mode.[text|data].out)
touch neorv32.uart0.sim_mode.data.out
chmod 777 neorv32.uart0.sim_mode.data.out
touch neorv32.uart0.sim_mode.text.out
chmod 777 neorv32.uart0.sim_mode.text.out

VSIM="${VSIM:-vsim.exe}"

# Start simulation
QUESTA_TIMEOUT="2ms"

# custom arguments
QUESTA_RUN_ARGS="${@}"

echo "Using simulation runtime args: $QUESTA_TIMEOUT";

#run simulation
# -voptargs="+acc" option for debug mode to add wave internal signal
$VSIM -do "source add_wave_debug.tcl;run $QUESTA_TIMEOUT; exit" $QUESTA_RUN_ARGS -c -l sim_log.log -voptargs=+acc cellrv32.neorv32_riscof_tb

# Rename final signature file
cp -f cellrv32.uart0.sim_mode.data.out DUT-cellrv32.signature