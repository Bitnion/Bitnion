// Copyright (c) 2009-2025 The Bitnion Core developers
// Distributed under the MIT software license

#include <wallet/walletutil.h>
#include <util/system.h>
#include <fs.h>
#include <logging.h>

// Bitnion Wallet Utility – Supporting wallet file and directory operations

bool IsBitnionWalletDir(const fs::path& path)
{
    LogPrintf("Checking Bitnion wallet directory: %s\\n", path.string());
    return fs::exists(path) && fs::is_directory(path);
}
