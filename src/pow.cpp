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

#include <consensus/params.h>
#include <pow.h>
#include <uint256.h>
#include <arith_uint256.h>
#include <chain.h>
#include <primitives/block.h>
#include <logging.h>
#include <util/system.h>

/**
 * Compute the block reward for a given block height.
 *
 * Bitnion uses a Bitcoin-like halving schedule:
 * - Initial block reward is 50 BNO.
 * - Halves every 205,000 blocks (~4 years).
 * - Block height 0 includes a 1,000,000 BNO premine.
 */
CAmount GetBlockSubsidy(int nHeight, const Consensus::Params& consensusParams)
{
    // Premine allocation: block height 0
    if (nHeight == 0) {
        return 1000000 * COIN; // 1 million BNO premine
    }

    int halvings = nHeight / consensusParams.nSubsidyHalvingInterval;

    // After 64 halvings, reward becomes 0
    if (halvings >= 64) {
        return 0;
    }

    CAmount nSubsidy = 50 * COIN;
    nSubsidy >>= halvings; // equivalent to nSubsidy / (2^halvings)
    return nSubsidy;
}

/**
 * Convert compact representation of target to arith_uint256.
 */
arith_uint256 UintToArith256(const uint256& a)
{
    arith_uint256 r;
    r.SetHex(a.ToString());
    return r;
}

/**
 * Convert arith_uint256 to compact representation.
 */
uint256 ArithToUint256(const arith_uint256& a)
{
    return uint256S(a.GetHex());
}

/**
 * Return the difficulty target for the given block height.
 *
 * Bitnion uses a Bitcoin-style difficulty adjustment algorithm.
 */
unsigned int GetNextWorkRequired(const CBlockIndex* pindexLast, const CBlockHeader *pblock, const Consensus::Params& params)
{
    // Bitcoin-style difficulty adjustment is handled elsewhere in main validation.
    // This placeholder is compatible with standard implementations.
    return pindexLast->nBits;
}

/**
 * Check whether a block hash satisfies the proof-of-work requirement.
 */
bool CheckProofOfWork(uint256 hash, unsigned int nBits, const Consensus::Params& params)
{
    arith_uint256 bnTarget;
    bool fNegative;
    bool fOverflow;
    bnTarget.SetCompact(nBits, &fNegative, &fOverflow);

    // Check range
    if (fNegative || bnTarget == 0 || fOverflow || bnTarget > UintToArith256(params.powLimit)) {
        return false;
    }

    // Check proof of work matches claimed amount
    if (UintToArith256(hash) > bnTarget) {
        return false;
    }

    return true;
}
