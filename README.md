# Honours-ALU

## Introduction

Creation and simulation of four (8/16/32/64-bit) different Arithmetic Logic Units using the Xilinx ISE Suite. VHDL was the language of choice, and iSim was used to benchmark the different ALUs through set stimulus cases. 

## Design

Basic ALU using VHDL and tested through iSim benchmarks. N-bit refers to either the 8, 16, 32, or 64-bit ALU.

### Operations (Arithmetic, Bitwise Logical & Relational)

| Opcode        | Function      | Example                               |
| ------------- | ------------- | ------------------------------------- |
| 000           | Addition      | `OUT_RES <= INP_A + INP_B`            |
| 001           | Subtraction   | `OUT_RES <= INP_A - INP_B`            |
| 010           | Increment     | `OUT_RES <= INP_A + 1`                |
| 011           | Decrement     | `OUT_RES <= INP_A - 1`                |
| 100           | Equality      | `if (INP_A == INP_B) OUT_RES <= x'1'` |
| 101           | AND           | `OUT_RES <= A AND B`                  |
| 110           | OR            | `OUT_RES <= A OR B`                   |
| 111           | XOR           | `OUT_RES <= A XOR B`                  |

### Inputs

| Name          | Purpose           | Size           |
| ------------- | ----------------- | -------------- |
| INP_A, INP_B  | Operands          | N-bit signed   |
| INP_SEL       | Function Selector | 3-bit unsigned |

### Outputs

| Name    | Purpose       | Size          |
| ------- | ------------- | ------------- |
| OUT_RES | Result        | N-bit signed  |
| OUT_OV  | Overflow flag | 1 bit         |
| OUT_ZE  | Zero flag     | 1 bit         |
| OUT_SI  | Sign flag     | 1 bit         |

## Testing

## Results

## Conlusion

