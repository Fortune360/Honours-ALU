# Honours-ALU and CSA design

## Introduction

Creation and simulation of two sets of four (8/16/32/64-bit) different Arithmetic Logic Units using the Xilinx ISE Suite. One set using a custom 4-bit block-carry-skip-adder design for it's adder, and the other using the xilinx library adder. The rest of the functions are identical to act as fixed variables when comparing propagation delays and area (LUTs). 

## Design

Basic Arithmetic Logic Unit using VHDL. N-bit refers to either the 8, 16, 32, or 64-bit ALU.

### Operations (Arithmetic, Bitwise Logical & Relational)

| Opcode        | Function      | Example                               | Notes                  |
| ------------- | ------------- | ------------------------------------- | ---------------------- |
| 000           | Addition      | `OUT_RES <= INP_A + INP_B`            | Supports carry in.     |
| 001           | Subtraction   | `OUT_RES <= INP_A - INP_B`            |                        |
| 010           | Increment     | `OUT_RES <= INP_A + 1`                |                        |
| 011           | Decrement     | `OUT_RES <= INP_A - 1`                |                        |
| 100           | Equality      | `if (INP_A = INP_B) OUT_RES <= x'1'`  | Sets all bits if true. |
| 101           | AND           | `OUT_RES <= A AND B`                  |                        |
| 110           | OR            | `OUT_RES <= A OR B`                   |                        |
| 111           | XOR           | `OUT_RES <= A XOR B`                  |                        |

### Inputs

| Name          | Purpose            | Size               | Note                             |
| ------------- | ------------------ | ------------------ | -------------------------------- |
| INP_A, INP_B  | Operands           | N-bit logic_vector |                                  |
| INP_SEL       | Function Selector  | 3-bit unsigned     |                                  |
| C_IN          | Carry in           | 1 bit              |                                  |
| CLK, (ACT)    | Used for testbench | 1 bit, 1 bit       | ACT to simulate ALU Active (TB). | 

### Outputs

| Name    | Purpose             | Size                | Notes                             |
| ------- | ------------------- | ------------------- | --------------------------------- |
| OUT_RES | Result              | N-bit logic_vector  | Unsigned.                         |
| OUT_OC  | Overflow/Carry flag | 1 bit               |                                   |
| OUT_ZE  | Zero flag           | 1 bit               | Set if results' bits are cleared. |
| OUT_SI  | Sign flag           | 1 bit               | Set if negative.                  |

Note: 
* Overflow flag is used for signed addition and subtraction (Underflow).
* Zero flag is set if OUT_RES is cleared.
* Sign flag is set if OUT_RES is a negative value.

## Testing

Testbenches are given (appended _TB). Below are the [13] purposeful tests run on the Spartan-3E FPGA Board.

| Switches | INP_A    | INP_B    | Shows                             | Integer equation     |
| -------- | -------- | -------- | --------------------------------- | -------------------- |
| 0000     | 00011100 | 00100001 | Addition with carry in.           | `28 + 33 + (1) = 61` |
| 0001     | 11111111 | 00000001 | Addition with overflow.           | `255 + 1 = (1)x`     |
| 0010     | 00001100 | 00000100 | Subtraction with even result.     | `16 - 8 = 8`         |
| 0011     | 00000110 | 10100000 | Subtraction with sign change.     | `6 - 160 = -154`     |
| 0100     | 00100111 | 00100111 | Subtraction with cleared result.  | `39 - 39 = 0`        |
| 0101     | 01001101 | N/A      | INP_A increment.                  | `77 => 78`           |
| 0110     | 11111111 | N/A      | INP_A increment with overflow.    | `256 => (1)x`        |
| 0111     | 00110110 | N/A      | INP_A decrement.                  | `54 => 53`           |
| 1000     | 00000000 | N/A      | INP_A decrement with 'underflow'. | `0 => (1)x`          |
| 1001     | 00111001 | 00111001 | Equality (true)                   | ` => 11111111`       |
| 1010     | 10100111 | 00101101 | Equality (false)                  | ` => 00000000`       |
| 1011     | 10101011 | 00011011 | AND                               | `00001011`           |
| 1100     | 10101000 | 11100001 | OR                                | `11101001`           |
| 1101     | 11000110 | 10010011 | XOR                               | `01010101`           |

Note: 
* This was only done using the 8-bit ALU with CSA, as each bit of the 8-bit result could be shown on an individual LED.
* Pin allocations can be found in the constraints.ucf file.
* Four switchs used in following order; `SW0`, `SW1`, `SW2`, `SW3`.
* `x` implies the result does not matter, as the overflow flag is set `(1)`.

## Results

### ALU Reports

**ALUs using default library:**

| Size (bit) | Prop (ns) | LL     | Slices | Slice FFs | LUTs | IOs  | Bonded IOBs | IOB FFs | GCLKs |
| ---------- | --------- | ------ | ------ | --------- | ---- | ---- | ----------- | ------- | ----- |
| 8          | 11.134    | 23     | 53     | 9         | 101  | 32   | 32          | 9       | 1     |
| 16         | 12.223    | 39     | 104    | 17        | 203  | 56   | 56          | 17      | 1     |
| 32         | 14.121    | 71     | 206    | 33        | 402  | 104  | 104         | 33      | 1     |
| 64         | 17.917    | 135    | 399    | 65        | 789  | 200  | 200         | 65      | 1     |

128-bit ALU: **Error (\*) More than 100% of Device resources are used.**

Note: 
* Data Path: INP_A -> Result_N. N being the bit size of the ALU minus one (count from 0).
* Propagation delays taken from Synthesis report, rest from utilization summary.
* Prop; Propgation Delay.
* LL; Levels of Logic.
* FF; Flip Flop.
* LUT; LookUp Table.
* IO; Input/Output.
* IOB; Input/Output Block.

**ALUs using custom CSA:**

| Size (bit) | Prop (ns) | LL     | Slices | Slice FFs | LUTs | IOs  | Bonded IOBs | IOB FFs | GCLKs |
| ---------- | --------- | ------ | ------ | --------- | ---- | ---- | ----------- | ------- | ----- |
| 8          |  14.996   | 10     | 12     | N/A       | 22   | 26   | 26          | N/A     | N/A   |
| 16         |  24.941   | 20     | 108    | 17        | 205  | 56   | 56          | 17      | 1     |
| 32         |  43.938   | 36     | 207    | 33        | 295  | 104  | 104         | 33      | 1     |
| 64         |  80.804   | 66     | 409    | 65        | 778  | 200  | 200         | 65      | 1     |

Note: 
* (8 bit) Data Path: INP_A -> C_OUT.
* (16 bit) Data Path: INP_A -> TEMP_OC.
* (32 bit) Data Path: INP_A -> TEMP_OC.
* (64 bit) Data Path: INP_A -> TEMP_OC.

### Graphed Results

**LookUp Tables**

![Alt text](/images/LUTs.png?raw=true "Title")

**Propagation Delays (ns)**

![Alt text](/images/Prop.png?raw=true "Title")

## Future Work

Re-implemented Carry Skip Adder.
* Varying block size.
* Componentizing skip logic.
</br>

Varying supported Opcodes.
* Either size (number of operations),
* Or complexity.
</br>
Focus on externals which house a standard ALU design.
* Comparison of CPU versus GPU designs on an FPGA.
* Potential tweaks to ALU to target special cases.
</br>
