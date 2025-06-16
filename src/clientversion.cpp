// =============================================================================
// Bitnion (BNO) – Core Version Metadata
//
// ▪ Version:       Bitnion Core 1.0.0
// ▪ Release Date:  June 2025
// ▪ Project Type:  Open-source, MIT Licensed
// ▪ Developer:     Bitnion Core Team (anonymous)
// ▪ Note:          This file defines version information used in CLI and logs.
//
// ⚠️ Bitnion is not a token, investment, or ICO.
// Contact: bitnion@gmail.com
// =============================================================================

#include <clientversion.h>
#include <tinyformat.h>
#include <util/system.h>
#include <string>

const std::string CLIENT_NAME("Bitnion Core");
const std::string CLIENT_BUILD("v1.0.0 (June 2025)");
const std::string CLIENT_DATE(__DATE__ " " __TIME__);

std::string FormatFullVersion()
{
    return CLIENT_BUILD;
}

std::string FormatSubVersion(const std::string& name, int nClientVersion, const std::vector<std::string>& comments)
{
    std::ostringstream ss;
    ss << "/" << name << ":" << FormatVersion(nClientVersion);
    if (!comments.empty()) {
        ss << "(";
        for (size_t i = 0; i < comments.size(); i++) {
            if (i != 0) ss << "; ";
            ss << comments[i];
        }
        ss << ")";
    }
    ss << "/";
    return ss.str();
}
