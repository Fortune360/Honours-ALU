# Honours-ALU and CSA design

## Introduction

Creation and simulation of four (8/16/32/64-bit) different Arithmetic Logic Units using the Xilinx ISE Suite. 

## Design

Basic Arithmetic Logic Unit using VHDL. N-bit refers to either the 8, 16, 32, or 64-bit ALU.

### Operations (Arithmetic, Bitwise Logical & Relational)

| Opcode        | Function      | Example                               | Notes                             |
| ------------- | ------------- | ------------------------------------- | --------------------------------- |
| 000           | Addition      | `OUT_RES <= INP_A + INP_B`            | It's fucked                       |
| 001           | Subtraction   | `OUT_RES <= INP_A - INP_B`            | Also fucked                       |
| 010           | Increment     | `OUT_RES <= INP_A + 1`                | Works                             |
| 011           | Decrement     | `OUT_RES <= INP_A - 1`                | Works                             |
| 100           | Equality      | `if (INP_A == INP_B) OUT_RES <= x'1'` | Works                             |
| 101           | AND           | `OUT_RES <= A AND B`                  | Works                             |
| 110           | OR            | `OUT_RES <= A OR B`                   | Works                             |
| 111           | XOR           | `OUT_RES <= A XOR B`                  | Works                             |

### Inputs

| Name          | Purpose            | Size               | Note                               |
| ------------- | ------------------ | ------------------ | ---------------------------------- |
| INP_A, INP_B  | Operands           | N-bit logic_vector |                                    |
| INP_SEL       | Function Selector  | 3-bit unsigned     |                                    |
| C_IN          | Carry in           | 1 bit              | Used to switch adder to subtractor |
| CLK, ACT      | Used for testbench | 1 bit, 1 bit       | ACT to simulate ALU Active         | 

### Outputs

| Name    | Purpose                       | Size                | Notes         |
| ------- | ----------------------------- | ------------------- | ------------- |
| OUT_RES | Result                        | N-bit logic_vector  |               |
| OUT_OC  | Overflow/Underflow/Carry flag | 1 bit               | Needs testing |
| OUT_ZE  | Zero flag                     | 1 bit               |               |
| OUT_SI  | Sign flag                     | 1 bit               | Needs work    |
| OUT_PA  | Parity flag                   | 1-bit               | Needs work    |

Note: 
* Overflow flag is used for signed addition and subtraction (Underflow).
* Zero flag is set if OUT_RES is cleared.
* Sign flag is set if OUT_RES is a negative value.
* Parity flag is set if there are a even number of `1`s and `0`s.

## Results

### ALU Reports

| Size    | Delay (ns) | Slices | LUTS | IOBs | Power Consumption |
| ------- | ---------- | ------ | ---- | ---- | ----------------- |
| 8 bit   | 8.243      |        |      |      |                   |
| 16 bit  | 7.949      |        |      |      |                   |
| 32 bit  | 8.893      |        |      |      |                   |
| 64 bit  | 10.781     |        |      |      |                   |
| 128 bit | 14.557     |        |      |      |                   |

Note: Slices, LUTS, IOBS refer to Area.

### Synthesis Report

`ALU with CSA`: 14.68ns propagation delay. </br>
`ALU with Lib`: 8.243ns propagation delay. </br>
Note: These are 8-bit ALU results.

## Conlusion

## TODO:

* Fix Adder/Sub.
* Scale CSA & ALU.
* Get timings.
