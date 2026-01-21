# RIVES CORE node v2

```
Cartesi Rollups Node version: 2.0.x
```

The RiscV Entertainment System (RIVES) CORE allows users to play riscv-binaries of games on a RISC-v Cartesi Machine on the browser, submit the game moves onchain so the session will be replayed in a Cartesi Rollups App to generate a provable score. Naturally you can upload you own games.

DISCLAIMERS

For now, this is not a final product and should not be used as one.

## Requirements

- [cartesapp](https://github.com/prototyp3-dev/cartesapp/), an high level framwork for python cartesi rollup app

## Instructions

Install Cartesapp:

```shell
python3 -m venv .venv
. .venv/bin/activate
pip3 install cartesapp[dev]@git+https://github.com/prototyp3-dev/cartesapp@v1.2.0
```

## Setup

Set the `OPERATOR_ADDRESS` on the cartesi.toml file:

```shell
build_args = ["OPERATOR_ADDRESS=0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"]
```

## Running

Run the App environment with:

```shell
cartesapp node
```

### Running Backend in dev mode

To run the backend in dev mode and speedup the development process you should run

```shell
cartesapp node --dev
```

## Building

Build backend with:

```shell
cartesapp build
```

Obs: you can find the sources for rivemu [here](https://github.com/rives-io/riv)
