// Bitnion validation.cpp
// MIT License

#include <validation.h>
#include <consensus/params.h>
#include <primitives/block.h>
#include <amount.h>
#include <stdint.h>

// Block subsidy (reward) logic
CAmount GetBlockSubsidy(int nHeight, const Consensus::Params& params)
{
    // Initial reward: 33.333333 BNO = 33333333 satoshis
    CAmount nSubsidy = 33333333;

    // Halve every 210,000 blocks (16 halvings max to reach ~14M BNO)
    int halvings = nHeight / params.nSubsidyHalvingInterval;

    if (halvings >= 16)
        return 0;

    // Bit shift subsidy: divide by 2^halvings
    return nSubsidy >> halvings;
}

// Stub for block validation (simplified)
bool ValidateBlock(const CBlock& block, const Consensus::Params& params)
{
    // Example: check timestamp and proof-of-work
    if (block.nTime > GetAdjustedTime() + 2 * 60 * 60)
        return false;

    if (!CheckProofOfWork(block.GetHash(), block.nBits, params))
        return false;

    return true;
}
