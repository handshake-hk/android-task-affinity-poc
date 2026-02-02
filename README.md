# Android Task Affinity PoC Generator

This tool automates the generation of a Proof-of-Concept (PoC) Android application to demonstrate Task Affinity vulnerabilities (StrandHogg, Task Hijacking). It allows for rapid customization of the taskAffinity attribute and application branding via Docker.

## Prerequisites

- Docker installed.
- The project image built locally:

```
docker build -t android-ta-poc .
```

## Usage

The generated APK will be available in your local `./output` directory after the build completes.

### Basic Usage (Default image, no logo)

Set the targetapp environment variable to the package name of the app you wish to target.

```sh
docker run --rm \
  -v $(pwd)/output:/data/output \
  -e targetapp="com.example.victimapp" \
  android-ta-poc
```

### Custom Logo Injection

To make the PoC look more convincing, you can mount a custom `.png` from your host to the container.

```sh
docker run --rm \
  -v $(pwd)/output:/data/output \
  -v $(pwd)/my_custom_logo.png:/data/logo.png \
  -e targetapp="com.example.victimapp" \
  android-ta-poc
```

## Disclaimer

This tool is for educational and authorized security testing purposes only. Unauthorized use against systems without prior consent is illegal.
