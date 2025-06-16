#!/usr/bin/env python3
# Copyright (c) 2009-2025 The Bitnion Core Developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or https://opensource.org/licenses/MIT

"""
Bitnion Core - Unit Test for security-check.py

This test ensures that the static analysis script (security-check.py)
properly flags insecure C/C++ patterns, such as unsafe functions (e.g., strcpy).
"""

import os
import unittest
import tempfile
import shutil
import subprocess

class TestSecurityCheck(unittest.TestCase):

    def setUp(self):
        self.test_dir = tempfile.mkdtemp()
        self.test_file_path = os.path.join(self.test_dir, "test.cpp")

    def tearDown(self):
        shutil.rmtree(self.test_dir)

    def _write_source(self, code):
        with open(self.test_file_path, "w", encoding="utf-8") as f:
            f.write(code)

    def _run_check(self):
        script_path = os.path.abspath(os.path.join(os.path.dirname(__file__), "security-check.py"))
        result = subprocess.run(
            [script_path, self.test_dir],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        return result.returncode, result.stdout

    def test_detects_strcpy(self):
        self._write_source("int main() { char a[10]; strcpy(a, \\"test\\"); return 0; }")
        code, output = self._run_check()
        self.assertNotEqual(code, 0)
        self.assertIn("strcpy", output)

    def test_detects_printf(self):
        self._write_source("int main() { printf(\\"Hello\\"); return 0; }")
        code, output = self._run_check()
        self.assertNotEqual(code, 0)
        self.assertIn("printf", output)

    def test_no_warning_on_safe_code(self):
        self._write_source("int main() { return 0; }")
        code, output = self._run_check()
        self.assertEqual(code, 0)
        self.assertIn("No dangerous function usage", output)

if __name__ == "__main__":
    unittest.main()

