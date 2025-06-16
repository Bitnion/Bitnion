// Copyright (c) 2009-2025 The Bitnion Core developers
// Distributed under the MIT software license

#include <config/bitnion-config.h>
#include <util/strencodings.h>
#include <util/system.h>
#include <tinyformat.h>
#include <univalue.h>

#include <boost/algorithm/string.hpp>
#include <iostream>
#include <string>
#include <vector>

int main(int argc, char* argv[])
{
    SetupEnvironment();

    std::cout << "===============================================\\n";
    std::cout << "     Bitnion Command Line Interface (bitnion-cli)\\n";
    std::cout << "     For interacting with a running bitniond node\\n";
    std::cout << "     Contact: bitnion@gmail.com\\n";
    std::cout << "===============================================\\n";

    std::cout << "CLI ready. For help, type: bitnion-cli help\\n";

    return 0;
}
