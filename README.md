# RIVES CORE node v2

```
Cartesi Rollups Node version: 2.0.x
```

The RiscV Entertainment System (RIVES) CORE allows users to play riscv-binaries of games on a RISC-v Cartesi Machine on the browser, submit the game moves onchain so the session will be replayed a Cartesi Rollups App to generate a provable score. Naturally you can upload you own games.

DISCLAIMERS

For now, this is not a final product and should not be used as one.

## Requirements

- [cartesapp](https://github.com/prototyp3-dev/cartesapp/), an high level framwork for python cartesi rollup app

## Building

Define a .env file with some variables:

```shell
OPERATOR_ADDRESS=0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
```

Build backend with:

```shell
cartesapp build
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

Obs: you should define the following variables in `.env` file: OPERATOR_ADDRESS

Obs: you can find the sources for rivemu [here](https://github.com/rives-io/riv)
