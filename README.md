# Honours-ALU and CSA design

## Introduction

Creation and simulation of four (8/16/32/64-bit) different Arithmetic Logic Units using the Xilinx ISE Suite. 

## Design

Basic Arithmetic Logic Unit using VHDL. N-bit refers to either the 8, 16, 32, or 64-bit ALU.

### Operations (Arithmetic, Bitwise Logical & Relational)

| Opcode        | Function      | Example                               | Notes                             |
| ------------- | ------------- | ------------------------------------- | --------------------------------- |
| 000           | Addition      | `OUT_RES <= INP_A + INP_B`            | Overflow not being caught         |
| 001           | Subtraction   | `OUT_RES <= INP_A - INP_B`            | Overflow not being caught         |
| 010           | Increment     | `OUT_RES <= INP_A + 1`                | Overflow issue 127 -> -128        |
| 011           | Decrement     | `OUT_RES <= INP_A - 1`                | Overflow issue -128 -> 127        |
| 100           | Equality      | `if (INP_A == INP_B) OUT_RES <= x'1'` | Re-testing required with int := 0 |
| 101           | AND           | `OUT_RES <= A AND B`                  | No known issues.                  |
| 110           | OR            | `OUT_RES <= A OR B`                   | No known issues.                  |
| 111           | XOR           | `OUT_RES <= A XOR B`                  | No known issues.                  |

### Inputs

| Name          | Purpose            | Size           | Note                                                         |
| ------------- | ------------------ | -------------- | ------------------------------------------------------------ |
| INP_A, INP_B  | Operands           | N-bit signed   |                                                              |
| INP_SEL       | Function Selector  | 3-bit unsigned |                                                              |
| C_IN          | Carry in           | 1 bit          |                                                              |
| CLK, ACT      | Used for testbench | 1 bit, 1 bit   | CLK to simulate CPU Control Unit, ACT to simulate ALU Active |

### Outputs

| Name    | Purpose       | Size          |
| ------- | ------------- | ------------- |
| OUT_RES | Result        | N-bit signed  |
| OUT_OV  | Overflow flag | 1 bit         |
| OUT_ZE  | Zero flag     | 1 bit         |
| OUT_SI  | Sign flag     | 1 bit         |

## Results

### ALU Reports

| Size   | Power Consumption | Slices | LUTS | IOBs | Delay (ns) |
| ------ | ----------------- | ------ | ---- | ---- | ---------- |
| 8 bit  |                   |        |      |      |            |
| 16 bit |                   |        |      |      |            |
| 32 bit |                   |        |      |      |            |
| 64 bit |                   |        |      |      |            |

Note: Slices, LUTS, IOBS refer to Area.

### Synthesis Report

ALU + CSA: 14.68ns propagation delay.
ALU + Lib: 8.243ns propagation delay.

## Conlusion

