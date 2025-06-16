#!/usr/bin/env python3
# Copyright (c) 2014-2025 The Bitnion Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

"""
Detect circular dependencies in Bitnion C++ source files using include-what-you-use output.
"""

import os
import sys
import re
import subprocess
import networkx as nx

IWYU_OUTPUT_FILE = "bitnion_iwyu.out"

def extract_dependencies(filename):
    dependencies = []
    with open(filename, "r", encoding="utf8") as f:
        for line in f:
            match = re.match(r"^(.+?)\s+should include:\s+(.+)$", line)
            if match:
                source = match.group(1).strip()
                target = match.group(2).strip()
                dependencies.append((source, target))
    return dependencies

def build_dependency_graph(dependencies):
    graph = nx.DiGraph()
    for source, target in dependencies:
        graph.add_edge(source, target)
    return graph

def detect_cycles(graph):
    try:
        cycles = list(nx.simple_cycles(graph))
        return cycles
    except Exception as e:
        print(f"Error detecting cycles: {e}")
        return []

def main():
    if not os.path.exists(IWYU_OUTPUT_FILE):
        print(f"Error: {IWYU_OUTPUT_FILE} not found. Please run include-what-you-use to generate it.")
        sys.exit(1)

    print("Analyzing include dependencies from:", IWYU_OUTPUT_FILE)
    dependencies = extract_dependencies(IWYU_OUTPUT_FILE)
    graph = build_dependency_graph(dependencies)
    cycles = detect_cycles(graph)

    if cycles:
        print("\nDetected circular dependencies:")
        for cycle in cycles:
            print(" -> ".join(cycle))
        sys.exit(1)
    else:
        print("No circular dependencies detected.")
        sys.exit(0)

if __name__ == "__main__":
    main()

