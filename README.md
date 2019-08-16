# LÖVE Game Template

LÖVE game template with different build tools.

## Requirements

- [LÖVE 11.x](https://love2d.org/)
- [yarn](https://yarnpkg.com)
- macOS Mojave (not tested in other OSs)

## Setup

This will install all dependencies under `./packages`.

```shell
make init
```

## Run

To run the current code immediately without building it,
you can either run `love ./` in the game folder or `make run`.


## Build

Creates a zipped `.love` file under, a macOS app
and opens it. All files are generated under `./build`.

```shell
make build
```