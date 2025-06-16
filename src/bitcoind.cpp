// Copyright (c) 2009-2025 The Bitnion Core developers
// Distributed under the MIT software license, see COPYING or https://opensource.org/licenses/MIT

#include <clientversion.h>
#include <config/bitnion-config.h>
#include <init.h>
#include <interfaces/chain.h>
#include <interfaces/init.h>
#include <node/context.h>
#include <util/system.h>
#include <util/strencodings.h>
#include <util/translation.h>

#include <boost/thread.hpp>

static std::unique_ptr<interfaces::Init> g_bitniond;

int main(int argc, char* argv[])
{
    SetupEnvironment();

    // Print basic startup info
    tfm::format(std::cout,
        "===============================================\n"
        "  Bitnion Daemon (bitniond) - A Bitnion-Quality Node\n"
        "  Total Supply: 15,000,000 BNO\n"
        "  Final Mining Year: ~2137\n"
        "  Premine: 1,000,000 BNO to 100,000 early supporters\n"
        "  Contact: bitnion@gmail.com\n"
        "  Version: %s\n"
        "===============================================\n\n",
        FormatFullVersion());

    g_bitniond = interfaces::MakeNode();
    return g_bitniond->main(argc, argv);
}
