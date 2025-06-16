// =============================================================================
// Bitnion (BNO) – A Fair and Foundational Cryptocurrency
//
// ▪ Name:         Bitnion
// ▪ Symbol:       BNO
// ▪ Smallest Unit: nion (1 BNO = 100,000,000 nion)
// ▪ Max Supply:   15,000,000 BNO
// ▪ Premine:      1,000,000 BNO allocated to 100,000 early supporters
// ▪ Launch Year:  2025
// ▪ Final Mining: Estimated around the year 2137
// ▪ Halving:      Every 205,000 blocks (~4 years)
// ▪ Network ID:   "bitnion"
// ▪ Developer:    The Bitnion Core Team
// ▪ Standard:     Designed to match the security and quality of Bitcoin Core
//
// Contact: bitnion@gmail.com
// =============================================================================

#include <chainparams.h>
#include <consensus/merkle.h>
#include <tinyformat.h>
#include <util/system.h>
#include <util/strencodings.h>
#include <versionbitsinfo.h>

#include <cassert>

static CBlock CreateGenesisBlock(uint32_t nTime, uint32_t nNonce, uint32_t nBits,
                                 int32_t nVersion, const CAmount& genesisReward)
{
    const char* pszTimestamp = "Bitnion 2025 – 1M BNO to 100,000 early supporters – Total 15M – bitnion@gmail.com";
    const CScript genesisOutputScript = CScript() << ParseHex("04678afdb0fe5548271967f1a67130b7105cd6a828e03909a67962e0ea1f61deb649f6bc3f4cef38c4f35504e51ec112de5c384df7ba0b8d578a4c702b6bf11d5f") << OP_CHECKSIG;

    CMutableTransaction txNew;
    txNew.nVersion = 1;
    txNew.vin.resize(1);
    txNew.vout.resize(1);
    txNew.vin[0].scriptSig = CScript() << 486604799 << CScriptNum(4)
        << std::vector<unsigned char>((const unsigned char*)pszTimestamp, (const unsigned char*)pszTimestamp + strlen(pszTimestamp));
    txNew.vout[0].nValue = genesisReward;
    txNew.vout[0].scriptPubKey = genesisOutputScript;

    CBlock genesis;
    genesis.nTime    = nTime;
    genesis.nBits    = nBits;
    genesis.nNonce   = nNonce;
    genesis.nVersion = nVersion;
    genesis.vtx.push_back(MakeTransactionRef(std::move(txNew)));
    genesis.hashPrevBlock.SetNull();
    genesis.hashMerkleRoot = BlockMerkleRoot(genesis);
    return genesis;
}

static CBlock CreateGenesisBlock(uint32_t nTime, uint32_t nNonce, uint32_t nBits)
{
    return CreateGenesisBlock(nTime, nNonce, nBits, 1, 1000000 * COIN); // Premine: 1M BNO
}

class CMainParams : public CChainParams {
public:
    CMainParams() {
        strNetworkID = "bitnion";

        consensus.nSubsidyHalvingInterval = 205000; // Halving every 205,000 blocks
        consensus.BIP34Height = 1;
        consensus.BIP34Hash = uint256();
        consensus.BIP65Height = 1;
        consensus.BIP66Height = 1;
        consensus.nPowTargetTimespan = 14 * 24 * 60 * 60; // 2 weeks
        consensus.nPowTargetSpacing = 10 * 60;            // 10 minutes per block
        consensus.fPowAllowMinDifficultyBlocks = false;
        consensus.fPowNoRetargeting = false;
        consensus.nRuleChangeActivationThreshold = 1916;  // 95% of 2016
        consensus.nMinerConfirmationWindow = 2016;

        consensus.vDeployments[Consensus::DEPLOYMENT_TAPROOT].bit = 2;
        consensus.vDeployments[Consensus::DEPLOYMENT_TAPROOT].nStartTime = 0;
        consensus.vDeployments[Consensus::DEPLOYMENT_TAPROOT].nTimeout = 999999999999ULL;

        consensus.nMinimumChainWork = uint256();
        consensus.defaultAssumeValid = uint256();

        pchMessageStart[0] = 0xb1;
        pchMessageStart[1] = 0xf3;
        pchMessageStart[2] = 0xc4;
        pchMessageStart[3] = 0xa1;
        nDefaultPort = 9333;
        nPruneAfterHeight = 100000;

        genesis = CreateGenesisBlock(1700000000, 2083236893, 0x1d00ffff);
        consensus.hashGenesisBlock = genesis.GetHash();
        assert(consensus.hashGenesisBlock != uint256());
        assert(genesis.hashMerkleRoot == BlockMerkleRoot(genesis));

        vSeeds.emplace_back("seed.bitnion.org");

        base58Prefixes[PUBKEY_ADDRESS] = std::vector<unsigned char>(1,25);   // B...
        base58Prefixes[SCRIPT_ADDRESS] = std::vector<unsigned char>(1,5);
        base58Prefixes[SECRET_KEY]     = std::vector<unsigned char>(1,153);
        base58Prefixes[EXT_PUBLIC_KEY] = {0x04, 0x88, 0xB2, 0x1E};
        base58Prefixes[EXT_SECRET_KEY] = {0x04, 0x88, 0xAD, 0xE4};

        bech32_hrp = "bno"; // Address format: bno1...

        fDefaultConsistencyChecks = false;
        fRequireStandard = true;

        checkpointData = {
            {
                {0, genesis.GetHash()},
            }
        };

        chainTxData = ChainTxData{
            1700000000, // Genesis timestamp
            0,
            0.0
        };
    }
};

static std::unique_ptr<const CChainParams> globalChainParams;

const CChainParams &Params() {
    assert(globalChainParams);
    return *globalChainParams;
}

std::unique_ptr<const CChainParams> CreateChainParams(const std::string& chain) {
    if (chain == "bitnion")
        return std::unique_ptr<CChainParams>(new CMainParams());
    throw std::runtime_error(strprintf("%s: Unknown chain %s", __func__, chain));
}

void SelectParams(const std::string& network) {
    globalChainParams = CreateChainParams(network);
}
