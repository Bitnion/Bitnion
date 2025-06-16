// Copyright (c) 2009-2025 The Bitnion Core developers
// Distributed under the MIT software license

#ifndef BITNION_WALLET_WALLET_H
#define BITNION_WALLET_WALLET_H

#include <primitives/transaction.h>
#include <sync.h>
#include <util/system.h>

// Bitnion Wallet API – Secure. Stable. Transparent.

class BitnionWallet
{
public:
    BitnionWallet();
    ~BitnionWallet();
    bool LoadWallet();
    bool BackupWallet(const std::string& destination);
};

#endif // BITNION_WALLET_WALLET_H
