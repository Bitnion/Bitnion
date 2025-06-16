// =============================================================================
// Bitnion (BNO) – A Fair and Foundational Cryptocurrency
//
// ▪ Name:         Bitnion
// ▪ Symbol:       BNO
// ▪ Smallest Unit: nion (1 BNO = 100,000,000 nion)
// ▪ Max Supply:   15,000,000 BNO
// ▪ Premine:      1,000,000 BNO allocated in genesis block
// ▪ Launch Year:  2025
// ▪ Final Mining: Estimated around the year 2137
// ▪ Halving:      Every 205,000 blocks
// ▪ Developer:    The Bitnion Core Team
// ▪ Network ID:   "bitnion"
//
// Contact: bitnion@gmail.com
// =============================================================================

#include <init.h>
#include <chainparams.h>
#include <validation.h>
#include <net.h>
#include <scheduler.h>
#include <util/system.h>
#include <util/strencodings.h>
#include <walletinitinterface.h>
#include <util/memory.h>
#include <interfaces/chain.h>
#include <interfaces/init.h>
#include <node/context.h>

std::unique_ptr<interfaces::Init> interfaces::MakeNodeInit(NodeContext& node) {
    return MakeWalletInit(node);
}

void InitLogging()
{
    // Setup log file and categories
    LogPrintf("\n\n************** Bitnion Core Logging Started **************\n");
    LogPrintf("* Version:       Bitnion Core 1.0.0\n");
    LogPrintf("* Network:       %s\n", Params().NetworkIDString());
    LogPrintf("* Developer:     The Bitnion Core Team\n");
    LogPrintf("* Website/Contact: bitnion@gmail.com\n");
    LogPrintf("**********************************************************\n\n");

    // Log system information
    LogPrintf("CPU cores available: %d\n", GetNumCores());
    LogPrintf("Startup time: %s\n", FormatISO8601DateTime(GetTime()));
}

void InitParameterInteraction()
{
    // Handle any special parameter rules here if needed.
    if (gArgs.IsArgSet("-bind") || gArgs.IsArgSet("-whitebind"))
        gArgs.ForceSetArg("-listen", "1");

    if (gArgs.IsArgSet("-connect") && gArgs.GetArgs("-connect").size() == 1 && gArgs.GetArgs("-connect")[0] == "0")
        gArgs.ForceSetArg("-dnsseed", "0");

    if (gArgs.IsArgSet("-proxy")) {
        gArgs.ForceSetArg("-listen", "0");
        gArgs.ForceSetArg("-discover", "0");
    }

    if (!gArgs.GetBoolArg("-listen", DEFAULT_LISTEN)) {
        gArgs.ForceSetArg("-upnp", "0");
        gArgs.ForceSetArg("-natpmp", "0");
    }

    if (gArgs.IsArgSet("-blocknotify"))
        LogPrintf("Using external block notification script.\n");
}

std::string LicenseInfo()
{
    // Return Bitnion license info
    return "Bitnion Core is a derivative of Bitcoin Core\n"
           "Copyright (C) 2009-2025 The Bitnion Core Developers\n"
           "\n"
           "This is free software licensed under the MIT license.\n"
           "See the accompanying file COPYING or visit:\n"
           "https://opensource.org/licenses/MIT\n";
}

