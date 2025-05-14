# CPU08BITS

Implementação didática de uma CPU simples de 8 bits em VHDL, incluindo uma unidade de processamento (CPU) e uma memória RAM. Este projeto é ideal para estudos de arquitetura de computadores, lógica digital e simulação de hardware.

## Componentes

- **CPU08**: Processador de 8 bits com registradores, unidade lógica e aritmética (ULA), decodificação de instruções e controle de fluxo.
- **RAM**: Memória RAM de 32 posições de 8 bits, com suporte a leitura, escrita e inicialização de valores.

## Funcionalidades

- Execução de instruções básicas: MOV, ADD, SUB, AND, OR.
- Controle de fluxo simples via máquina de estados.
- Inicialização automática da RAM com instruções de exemplo.
- Projeto modular e fácil de expandir.

## Como usar

1. Clone este repositório.
2. Importe os arquivos `.vhd` em seu simulador ou ferramenta de síntese VHDL favorita (ModelSim, GHDL, Vivado, etc).
3. Simule a CPU e a RAM para observar o funcionamento das instruções e o fluxo de dados.

## Estrutura

- `CPU08.vhd`: Implementação da CPU de 8 bits.
- `RAM.vhd`: Implementação da memória RAM de 8 bits.
- (Adicione outros arquivos se necessário)

## Objetivo

Este projeto tem fins educacionais e serve como base para quem deseja aprender sobre o funcionamento interno de processadores e memórias digitais.
