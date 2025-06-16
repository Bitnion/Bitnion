# Building Bitnion with Microsoft Visual Studio

This document provides instructions for building the Bitnion Core project using Microsoft Visual Studio on Windows.

## Requirements

- Windows 10 or later
- Visual Studio 2019 or 2022 with C++ tools installed
- Git

## Build Steps

1. Clone the Bitnion repository:
   ```sh
   git clone https://github.com/yourusername/bitnion.git
   cd bitnion
   ```

2. Open the Visual Studio solution:
   - Navigate to `build_msvc` directory
   - Open `bitnion.sln` with Visual Studio

3. Choose the desired configuration:
   - Platform: `x64`
   - Configuration: `Release` or `Debug`

4. Build the solution:
   - Press `Ctrl+Shift+B` or select `Build → Build Solution`

## Output Binaries

The following binaries will be produced in `build_msvc\\x64\\Release\\`:

- `bitniond.exe` — Bitnion full node daemon
- `bitnion-cli.exe` — RPC command-line tool
- `test_bitnion.exe` — Unit test binary

## Project Structure

- `libbitnion_*`: Static libraries (e.g. consensus, server, wallet)
- `libunivalue`: JSON utility library
- `libsecp256k1`: Cryptographic signature library

## Notes

- This build uses the MSBuild toolchain, not Autotools or CMake.
- Make sure all dependencies and headers are properly copied or generated before building.
- If you encounter issues, verify that all `.vcxproj` and `.targets` files are correctly configured for Bitnion.

## Contact

For support or contributions, contact the Bitnion Core Team at:

- 📧 bitnion@gmail.com
