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
// ⚠️ Bitnion is not a token, not an investment, and not for sale.
// Contact: bitnion@gmail.com
// =============================================================================

#include <validation.h>
#include <consensus/validation.h>
#include <chain.h>
#include <chainparams.h>
#include <pow.h>
#include <primitives/block.h>
#include <logging.h>
#include <util/system.h>

bool ValidateBlock(const CBlock& block, const CChainParams& params, BlockValidationState& state)
{
    // Basic size and format checks
    if (block.vtx.empty()) {
        return state.Invalid(BlockValidationResult::CONSENSUS, "bad-cb-missing", "Block has no transactions");
    }

    if (block.vtx[0]->IsCoinBase() == false) {
        return state.Invalid(BlockValidationResult::CONSENSUS, "bad-cb-missing", "First transaction is not coinbase");
    }

    // Proof-of-Work check
    if (!CheckProofOfWork(block.GetHash(), block.nBits, params.GetConsensus())) {
        return state.Invalid(BlockValidationResult::CONSENSUS, "high-hash", "Proof of work failed");
    }

    // Future timestamp
    if (block.GetBlockTime() > GetTime() + 2 * 60 * 60) {
        return state.Invalid(BlockValidationResult::CONSENSUS, "time-too-new", "Block timestamp too far in the future");
    }

    // Log for Bitnion chain
    LogPrintf("Bitnion: Validated block %s at height unknown\n", block.GetHash().ToString());

    return true;
}
