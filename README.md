# Honours-ALU

## Introduction

Creation and simulation of a 8/16/32/64-bit Arithmetic Logic Units using the Xilinx ISE Suite. VHDL was the language of choice, and iSim was used to benchmark the different ALUs through set stimulus cases. 

## Design

Basic ALU using VHDL and tested through iSim benchmarks. N-bit refers to either the 8, 16, 32, or 64-bit ALU.

### Operations (Arithmetic, Bitwise Logical & Relational)

| Opcode        | Function      | Example                               |
| ------------- | ------------- | ------------------------------------- |
| 000           | Addition      | `ALU_OUT <= INP_A + INP_B`            |
| 001           | Subtraction   | `ALU_OUT <= INP_A - INP_B`            |
| 010           | Increment     | `ALU_OUT <= INP_A + 1`                |
| 011           | Decrement     | `ALU_OUT <= INP_A - 1`                |
| 100           | Equality      | `if (INP_A == INP_B) ALU_OUT <= x'1'` |
| 101           | AND           | `ALU_OUT <= A AND B`                  |
| 110           | OR            | `ALU_OUT <= A OR B`                   |
| 111           | XOR           | `ALU_OUT <= A XOR B`                  |

### Inputs

| Name          | Purpose           | Size           |
| ------------- | ----------------- | -------------- |
| INP_A, INP_B  | Operands          | N-bit signed   |
| ALU_SEL       | Function Selector | 3-bit unsigned |

### Outputs

| Name          | Purpose    | Size          |
| ------------- | ---------- | ------------- |
| ALU_OUT       | Result     | N-bit signed  |
| C_OUT         | Carry Flag | 1 bit         |
| Z_OUT         | Zero Flag  | 1 bit         |
| S_OUT         | Sign Flag  | 1 bit         |

## Testing

## Results

## Conlusion

