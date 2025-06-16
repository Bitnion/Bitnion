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

#ifndef BITNION_CONSENSUS_PARAMS_H
#define BITNION_CONSENSUS_PARAMS_H

#include <uint256.h>
#include <limits>
#include <string>

namespace Consensus {

    /**
     * Consensus rule configuration shared between all networks (main, testnet, regtest).
     */
    struct Params {
        uint256 hashGenesisBlock;
        int nSubsidyHalvingInterval;
        int BIP34Height;
        uint256 BIP34Hash;
        int BIP65Height;
        int BIP66Height;

        uint32_t nPowTargetSpacing;
        uint32_t nPowTargetTimespan;
        bool fPowAllowMinDifficultyBlocks;
        bool fPowNoRetargeting;

        int nRuleChangeActivationThreshold;
        int nMinerConfirmationWindow;

        uint256 nMinimumChainWork;
        uint256 defaultAssumeValid;

        struct Deployment {
            int bit;
            int64_t nStartTime;
            int64_t nTimeout;
        };

        enum DeploymentPos {
            DEPLOYMENT_TESTDUMMY,
            DEPLOYMENT_TAPROOT,
            MAX_VERSION_BITS_DEPLOYMENTS
        };

        Deployment vDeployments[MAX_VERSION_BITS_DEPLOYMENTS];
    };

    /**
     * Maximum supply: 15,000,000 BNO = 1.5 billion nion (1 BNO = 100,000,000 nion).
     */
    static const CAmount MAX_MONEY = 15000000 * COIN;

    /** The maximum amount of money in circulation (used for sanity checks). */
    inline bool MoneyRange(const CAmount& nValue) {
        return (nValue >= 0 && nValue <= MAX_MONEY);
    }

} // namespace Consensus

#endif // BITNION_CONSENSUS_PARAMS_H
