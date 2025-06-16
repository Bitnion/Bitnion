# Bitnion Core Developer Tools

This directory contains tools used by Bitnion Core developers to assist in development, maintenance, formatting, and documentation processes.

These scripts help ensure that the Bitnion codebase maintains high quality, code style consistency, proper licensing, and accurate manual pages.

---

## Included Tools

| File                        | Purpose                                                                 |
|-----------------------------|-------------------------------------------------------------------------|
| `clang-format-diff.py`      | Formats only changed lines using clang-format to enforce code style.    |
| `copyright_header.py`       | Checks or inserts standard MIT license headers into source files.        |
| `gen-manpages.sh`           | Generates manpages from Bitnion CLI tool outputs using `help2man`.       |
| `circular-dependencies.py`  | Detects circular header dependencies using IWYU output.                  |
| `symbol-check.py`           | Ensures binary symbols remain compliant with dynamic linking rules.     |
| `security-check.py`         | Performs simple static code checks for security-sensitive patterns.      |

---

## Requirements

Several of these tools require external dependencies:

- `clang-format`
- `help2man`
- `include-what-you-use` (for circular dependency check)
- `python3` (for all Python scripts)
- `ImageMagick` (optional, for logo and favicon generation)

Please install them using your system or Termux package manager.

---

## Example Usage

Format changed lines:
```bash
git diff -U0 HEAD~1 | ./contrib/devtools/clang-format-diff.py


