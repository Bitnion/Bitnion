// Bitnion net.cpp
// Distributed under the MIT software license

#include <net.h>
#include <addrman.h>
#include <chainparams.h>
#include <clientversion.h>
#include <netbase.h>
#include <protocol.h>
#include <util/system.h>
#include <util/strencodings.h>
#include <logging.h>

// Default max number of inbound and outbound connections
int nMaxOutbound = 8;
int nMaxInbound = 125;

CConnman::CConnman()
{
    // Bitnion-specific networking settings (can be expanded)
    nLocalServices = NODE_NETWORK;
}

void CConnman::Start()
{
    LogPrintf("Starting Bitnion network manager...\n");

    // Load address manager
    if (!addrman.Load())
        LogPrintf("Failed to load addrman\n");

    // Bind to default port from chainparams
    const CChainParams& params = Params();
    uint16_t port = params.GetDefaultPort();
    LogPrintf("Binding P2P port: %u\n", port);
}

uint16_t CChainParams::GetDefaultPort() const
{
    if (strNetworkID == "main") return 10333;
    if (strNetworkID == "test") return 18339;
    if (strNetworkID == "regtest") return 18449;
    if (strNetworkID == "signet") return 38339;
    return 10333; // fallback
}

bool CConnman::BindListenPort()
{
    // Example bind logic (simplified)
    return true; // Assume success for simplified example
}

void CConnman::Stop()
{
    LogPrintf("Stopping Bitnion network manager...\n");
}
