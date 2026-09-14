# Digital ASIC Design Coursework

RTL-to-GDS coursework: Verilog/SystemVerilog design, verification, synthesis,
DFT, STA, and place-and-route, done as part of my Digital ASIC Design course.

## Structure

```
.
├── Assignments/         # Graded assignments
│   ├── Verilog Assignments/    # 1: combinational logic, 2: up/down counter,
│   │                           # 3: 16-bit ALU, 4: ALU top + register file,
│   │                           # 5: CRC/LFSR + garage-door FSM
│   ├── UART/                   # TX and RX blocks (FSM + datapath)
│   ├── FIFO/                   # Asynchronous FIFO
│   ├── FIFO_DEPTH/             # FIFO depth sizing analysis
│   ├── RST_SYNC/                # Reset synchronizer
│   ├── Integer_Clock_Divider/  # Clock divider (even/odd)
│   ├── DATA_SYNC/               # Data/CDC synchronizer
│   ├── Synthesis Assignments/  # Assignment 1 (GUI vs. script synthesis)
│   ├── Synthesis/               # Assignments 2.0 / 3.0 (incl. pipelined ALU)
│   ├── DFT/                      # Scan insertion on UART_TX
│   ├── PnR&GLS/                  # Place-and-route + gate-level sim (ALU)
│   ├── STA Assignments/          # Setup/hold timing analysis
│   └── TCL Assignments/          # TCL scripting exercises 1 & 2
│
├── Labs/                 # In-session lab exercises
│   ├── Verilog Labs/      # Labs 1–3: combinational/sequential basics
│   ├── Synthesis Labs/    # Session 1: GTECH vs. TSMC schematics
│   ├── TCL Labs/          # Sessions 1–2: TCL fundamentals
│   ├── DFT/               # Lab_DFT_1/2 + solutions (ALU, system-level DFT)
│   └── STA Labs/          # Setup/hold analysis walkthroughs
│
└── README.md
```

## Toolchain

- **Simulation:** ModelSim / QuestaSim
- **Synthesis:** Synopsys Design Compiler
- **Equivalence checking:** Synopsys Formality
- **Place & route:** Cadence Encounter/Innovus
- **Scripting:** TCL
- **Process:** TSMC 0.13 µm (via university-licensed standard-cell library)

## Layout convention (per assignment folder)

Most assignment folders follow the same pattern:

```
<assignment>/
├── rtl/          # Design source
├── <name>.pdf    # Assignment spec / write-up
├── *_tb.sv        # Testbench(es)
├── syn/ or dft/ or pnr/   # Tool run directory: scripts, reports, netlists
└── std_cells/    # (not tracked — see note above)
```

## Notes

- Waveform PDFs under `WFs/` are exported ModelSim views kept for the
  write-up; the raw `.wlf`/`.vcd` dumps are excluded from version control
  (regenerate by re-running the testbench).
- Reports (`area.rpt`, `setup.rpt`, `hold.rpt`, `power.rpt`, etc.) reflect the
  results at time of submission and are kept for reference.
