# Bitnion CI and Test Infrastructure

This directory contains shell scripts and configuration files used for building, testing, and validating the Bitnion Core software.  
It is inspired by and adapted from Bitcoin Core's CI pipeline but has been rewritten and restructured to serve Bitnion's architecture, naming conventions, and project scope.

---

## 🔧 Directory Structure

\`\`\`
ci/
├── README.md                  → This documentation
├── test/                      → Shell scripts for building & testing Bitnion
│   ├── 00_setup_env.sh
│   ├── 00_setup_env_native_msan.sh
│   ├── 00_setup_env_native_tsan.sh
│   ├── 00_setup_env_native_valgrind.sh
│   ├── 00_setup_env_native_nowallet.sh
│   ├── 00_setup_env_native_qt5.sh
│   ├── 00_setup_env_native_multiprocess.sh
│   ├── 00_setup_env_win64.sh
│   ├── 00_setup_env_s390x.sh
│   ├── 03_before_install.sh
│   ├── 04_install.sh
│   ├── 05_before_script.sh
│   ├── 06_script_a.sh
│   ├── 06_script_b.sh
│   ├── wrap-valgrind.sh
│   ├── wrap-qemu.sh
│   ├── wrap-wine.sh
test_run_all.sh                → Full test pipeline entrypoint
\`\`\`

---

## 🧱 Build Targets

These scripts ensure proper integration with Bitnion Core modules:
- \`src/chainparams.cpp\`
- \`src/pow.cpp\`
- \`src/validation.cpp\`
- \`bitnion/README.md\`
- \`src/init.cpp\`, etc.

And generate the expected Bitnion binaries:
- \`bitniond\`, \`bitnion-cli\`, \`bitnion-util\`, \`bitnion-qt\`

---

## ✅ Execution Order (Standard CI Flow)

1. \`ci/test/03_before_install.sh\`  
2. \`ci/test/05_before_script.sh\`  
3. One of the \`00_setup_env_*.sh\` configurations  
4. \`ci/test/06_script_a.sh\`  
5. \`ci/test/06_script_b.sh\`  
6. \`ci/test/04_install.sh\`  
7. Optionally:  
   - \`wrap-valgrind.sh\`  
   - \`wrap-qemu.sh\`  
   - \`wrap-wine.sh\`  
8. Or simply: \`ci/test_run_all.sh\` to run everything

---

## 📌 Notes

- All scripts are POSIX-compliant and portable  
- Designed for use in GitHub Actions, Termux, Arch Linux, Docker  
- Bitnion branding is enforced across all paths and binaries  

---

## 📜 License

Bitnion Core is released under the MIT license.  
See the [\`LICENSE\`](../../LICENSE) or [\`COPYING\`](../../COPYING) file for details.

---

Bitnion Core Development Team  
2025
