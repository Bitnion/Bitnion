// =============================================================================
// Bitnion (BNO) – A Fair and Foundational Cryptocurrency
//
// ▪ Smallest Unit: nion (1 BNO = 100,000,000 nion)
// ▪ Max Supply:   15,000,000 BNO = 1.5 billion nion
// ▪ Project Type: Open-source, non-commercial
// ▪ Developer:    Bitnion Core Team (anonymous)
// ▪ License:      MIT
//
// ⚠️ Bitnion is not a token, investment, or security.
// Contact: bitnion@gmail.com
// =============================================================================

#include <util/moneystr.h>
#include <amount.h>
#include <util/strencodings.h>

#include <string>
#include <sstream>
#include <iomanip>
#include <cassert>

/** Convert integer amount (in nion) to human-readable string in BNO */
std::string FormatMoney(const CAmount& n)
{
    int64_t n_abs = (n > 0 ? n : -n);
    int64_t quotient = n_abs / COIN;
    int64_t remainder = n_abs % COIN;

    std::ostringstream oss;
    if (n < 0) oss << "-";
    oss << quotient;

    if (remainder != 0) {
        oss << "." << std::setfill('0') << std::setw(8) << remainder;
        std::string s = oss.str();
        // Trim trailing zeroes
        s.erase(s.find_last_not_of('0') + 1, std::string::npos);
        if (s.back() == '.') s.pop_back();
        return s;
    }

    return oss.str();
}

/** Add optional label: 123.00000000 BNO */
std::string FormatMoney(const CAmount& n, bool fPlus)
{
    std::string str = FormatMoney(n);
    if (fPlus && n > 0) str = "+" + str;
    return str + " BNO";
}

/** Parse string like "1.23456789" into nion units */
bool ParseMoney(const std::string& str, CAmount& nRet)
{
    std::string strTrimmed = TrimString(str);
    if (strTrimmed.empty()) return false;

    size_t dot = strTrimmed.find('.');
    std::string whole = dot == std::string::npos ? strTrimmed : strTrimmed.substr(0, dot);
    std::string decimal = dot == std::string::npos ? "" : strTrimmed.substr(dot + 1);

    if (decimal.length() > 8) return false;

    while (decimal.length() < 8) decimal += '0';

    std::string combined = whole + decimal;

    if (!IsDigit(combined)) return false;

    try {
        nRet = CAmount(std::stoll(combined));
        return true;
    } catch (...) {
        return false;
    }
}
