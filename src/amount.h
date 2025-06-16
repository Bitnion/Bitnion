// =============================================================================
// Bitnion (BNO) – A Fair and Foundational Cryptocurrency
//
// ▪ Symbol:       BNO
// ▪ Smallest Unit: nion (1 BNO = 100,000,000 nion)
// ▪ Max Supply:   15,000,000 BNO (1.5 billion nion)
// ▪ Premine:      1,000,000 BNO in genesis block
// ▪ Network:      bitnion
//
// ⚠️ Bitnion is not an investment or token offering.
// Contact: bitnion@gmail.com
// =============================================================================

#ifndef BITNION_AMOUNT_H
#define BITNION_AMOUNT_H

#include <stdint.h>
#include <string>

/** Amount in nion (base unit).
 * 1 BNO = 100,000,000 nion
 */
typedef int64_t CAmount;
static const CAmount NION = 1;
static const CAmount COIN = 100000000 * NION;

/** Maximum Bitnion supply: 15 million BNO = 1.5 billion nion */
static const CAmount MAX_MONEY = 15000000 * COIN;

/** Check if amount is within valid range */
inline bool MoneyRange(const CAmount& nValue)
{
    return (nValue >= 0 && nValue <= MAX_MONEY);
}

#endif // BITNION_AMOUNT_H
