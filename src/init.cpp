// Bitnion init.cpp
// MIT License

#include <init.h>
#include <chainparams.h>
#include <validation.h>
#include <net.h>
#include <net_processing.h>
#include <scheduler.h>
#include <txdb.h>
#include <wallet/wallet.h>
#include <util/system.h>
#include <util/strencodings.h>
#include <miner.h>
#include <consensus/validation.h>
#include <warnings.h>

static std::unique_ptr<CConnman> g_connman;

void Shutdown()
{
    LogPrintf("Bitnion shutdown initiated\n");
    StopNode();
    FlushStateToDisk(Params(), FlushStateMode::ALWAYS);
    g_connman.reset();
    LogPrintf("Bitnion shutdown complete\n");
}

bool AppInitBasicSetup()
{
    InitLogging();
    InitParameterInteraction();
    return true;
}

bool AppInitParameterInteraction()
{
    return true;
}

bool AppInitSanityChecks()
{
    if (!ECC_InitSanityCheck())
        return false;

    return true;
}

void StartNode()
{
    g_connman = std::make_unique<CConnman>();
    g_connman->Start();
    StartScheduler();
    StartScriptCheckWorker();
    StartNodeThreads();
}

bool AppInitMain()
{
    const CChainParams& chainparams = Params();

    if (!LoadBlockIndex(chainparams))
        return false;

    if (!InitBlockIndex(chainparams))
        return false;

    if (!LoadChainTip(chainparams))
        return false;

    if (!ActivateBestChain(nullptr, chainparams))
        return false;

    StartNode();

    return true;
}

int main(int argc, char* argv[])
{
    SetupEnvironment();
    if (!AppInitBasicSetup())
        return EXIT_FAILURE;

    if (!AppInitParameterInteraction())
        return EXIT_FAILURE;

    if (!AppInitSanityChecks())
        return EXIT_FAILURE;

    if (!AppInitMain())
        return EXIT_FAILURE;

    LogPrintf("Bitnion node started successfully.\n");

    while (!ShutdownRequested())
    {
        MilliSleep(200);
    }

    Shutdown();

    return EXIT_SUCCESS;
}
