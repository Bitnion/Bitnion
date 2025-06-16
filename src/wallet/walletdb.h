// Copyright (c) 2009-2025 The Bitnion Core developers
// Distributed under the MIT software license

#ifndef BITNION_WALLET_WALLETDB_H
#define BITNION_WALLET_WALLETDB_H

#include <string>
#include <vector>
#include <primitives/transaction.h>

// Bitnion WalletDB interface – Used for secure database interaction

class BitnionWalletDB
{
public:
    BitnionWalletDB();
    ~BitnionWalletDB();
    bool WriteKey(const std::string& key, const std::string& value);
    bool EraseKey(const std::string& key);
};

#endif // BITNION_WALLET_WALLETDB_H
