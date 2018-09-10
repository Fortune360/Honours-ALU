# Honours-ALU and CSA design

## Introduction

Creation and simulation of two sets of four (8/16/32/64-bit) different Arithmetic Logic Units using the Xilinx ISE Suite. One set using a custom 4-bit block-carry-skip-adder design for it's adder, and the other using the xilinx library adder. The rest of the functions are identical to act as fixed variables when comparing propagation delays. 

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
| CLK, ACT      | Used for testbench | 1 bit, 1 bit       | ACT to simulate ALU Active (TB). | 

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

## Results

### ALU Reports

**ALUs using custom CSA:**
| Size    | Delay (ns) | Slices | LUTS | IOBs | Power Consumption |
| ------- | ---------- | ------ | ---- | ---- | ----------------- |
| 8 bit   |            |        |      |      |                   |
| 16 bit  |            |        |      |      |                   |
| 32 bit  |            |        |      |      |                   |
| 64 bit  |            |        |      |      |                   |
| 128 bit |            |        |      |      |                   |

**ALUs using default library:**
| Size    | Delay (ns) | Slices | LUTS | IOBs | Power Consumption |
| ------- | ---------- | ------ | ---- | ---- | ----------------- |
| 8 bit   |            |        |      |      |                   |
| 16 bit  |            |        |      |      |                   |
| 32 bit  |            |        |      |      |                   |
| 64 bit  |            |        |      |      |                   |
| 128 bit |            |        |      |      |                   |

Note: 
* Slices, LUTS, IOBS refer to Area.
* Propagation delays taken from Synthesis report.

## Conlusion


