// Copyright (c) 2009-2025 The Bitnion Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or https://opensource.org/licenses/MIT

#ifndef BITNION_OPTIONAL_H
#define BITNION_OPTIONAL_H

#include <boost/optional.hpp>

template <typename T>
using Optional = boost::optional<T>;

#endif // BITNION_OPTIONAL_H
