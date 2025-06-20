// Bitnion miner.cpp
// MIT License

#include <miner.h>
#include <validation.h>
#include <chainparams.h>
#include <pow.h>
#include <primitives/block.h>
#include <consensus/validation.h>
#include <crypto/sha256.h>
#include <arith_uint256.h>
#include <util/system.h>
#include <txmempool.h>
#include <wallet/wallet.h>

static std::unique_ptr<CBlock> CreateNewBlock(const CScript& scriptPubKey)
{
    const CChainParams& chainparams = Params();
    CBlockIndex* pindexPrev = chainActive.Tip();

    auto pblock = std::make_unique<CBlock>();
    pblock->nVersion = 1;
    pblock->nTime = GetTime();
    pblock->nBits = GetNextWorkRequired(pindexPrev, pblock.get(), chainparams.GetConsensus());
    pblock->nNonce = 0;

    // Coinbase tx
    CMutableTransaction coinbaseTx;
    coinbaseTx.vin.resize(1);
    coinbaseTx.vin[0].scriptSig = CScript() << (pindexPrev->nHeight + 1);
    coinbaseTx.vout.resize(1);
    coinbaseTx.vout[0].nValue = GetBlockSubsidy(pindexPrev->nHeight + 1, chainparams.GetConsensus());
    coinbaseTx.vout[0].scriptPubKey = scriptPubKey;

    pblock->vtx.push_back(MakeTransactionRef(std::move(coinbaseTx)));
    pblock->hashPrevBlock = pindexPrev->GetBlockHash();
    pblock->hashMerkleRoot = BlockMerkleRoot(*pblock);

    return pblock;
}

void MineBitnion(const CScript& scriptPubKey)
{
    const CChainParams& chainparams = Params();
    while (true) {
        std::unique_ptr<CBlock> pblock = CreateNewBlock(scriptPubKey);
        uint256 hashTarget;
        arith_uint256 bnTarget;
        bnTarget.SetCompact(pblock->nBits);
        hashTarget = ArithToUint256(bnTarget);

        while (true) {
            pblock->nNonce++;
            uint256 hash = pblock->GetHash();

            if (UintToArith256(hash) <= bnTarget) {
                LogPrintf("Bitnion block found!\n");
                LogPrintf("Hash: %s\n", hash.ToString());
                LogPrintf("Nonce: %u\n", pblock->nNonce);

                CValidationState state;
                if (!ProcessNewBlock(chainparams, std::move(pblock), true, nullptr)) {
                    LogPrintf("Bitnion block rejected\n");
                }
                break;
            }

            if (ShutdownRequested())
                return;

            // Optional sleep to limit CPU usage
        }
    }
}
