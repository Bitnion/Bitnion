// Copyright (c) 2009-2025
// Distributed under the MIT software license

#include <pow.h>
#include <arith_uint256.h>
#include <chain.h>
#include <primitives/block.h>
#include <uint256.h>
#include <util/system.h>
#include <consensus/params.h>

// Calculate the next required difficulty target for mining
unsigned int GetNextWorkRequired(const CBlockIndex* pindexLast, const CBlockHeader *pblock, const Consensus::Params& params)
{
    if (pindexLast == nullptr)
        return UintToArith256(params.powLimit).GetCompact();

    // No adjustment unless on difficulty interval
    if ((pindexLast->nHeight + 1) % params.DifficultyAdjustmentInterval() != 0) {
        if (params.fPowAllowMinDifficultyBlocks)
            return UintToArith256(params.powLimit).GetCompact();

        return pindexLast->nBits;
    }

    // Go back by interval and get actual timespan
    const CBlockIndex* pindexFirst = pindexLast;
    for (int i = 0; i < params.DifficultyAdjustmentInterval() - 1; i++) {
        if (pindexFirst->pprev == nullptr)
            return UintToArith256(params.powLimit).GetCompact();
        pindexFirst = pindexFirst->pprev;
    }

    return CalculateNextWorkRequired(pindexLast, pindexFirst->GetBlockTime(), params);
}

// Difficulty adjustment calculation
unsigned int CalculateNextWorkRequired(const CBlockIndex* pindexLast, int64_t nFirstBlockTime, const Consensus::Params& params)
{
    if (params.fPowNoRetargeting)
        return pindexLast->nBits;

    int64_t nActualTimespan = pindexLast->GetBlockTime() - nFirstBlockTime;
    const int64_t nTargetTimespan = params.nPowTargetTimespan;

    // Clamp timespan
    if (nActualTimespan < nTargetTimespan / 4)
        nActualTimespan = nTargetTimespan / 4;
    if (nActualTimespan > nTargetTimespan * 4)
        nActualTimespan = nTargetTimespan * 4;

    arith_uint256 bnNew;
    bnNew.SetCompact(pindexLast->nBits);
    bnNew *= nActualTimespan;
    bnNew /= nTargetTimespan;

    if (bnNew > UintToArith256(params.powLimit))
        bnNew = UintToArith256(params.powLimit);

    return bnNew.GetCompact();
}

// Verify that a block hash meets the required difficulty target
bool CheckProofOfWork(const uint256& hash, unsigned int nBits, const Consensus::Params& params)
{
    arith_uint256 bnTarget;
    bnTarget.SetCompact(nBits);

    // Check difficulty bounds
    if (bnTarget.IsNull() || bnTarget > UintToArith256(params.powLimit))
        return false;

    // Compare hash vs target
    return UintToArith256(hash) <= bnTarget;
}
