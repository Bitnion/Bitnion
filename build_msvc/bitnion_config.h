#ifndef BITNION_CONFIG_H
#define BITNION_CONFIG_H

// Version info
#define PACKAGE_NAME "Bitnion Core"
#define PACKAGE_VERSION "0.1.0"
#define CLIENT_VERSION_MAJOR 0
#define CLIENT_VERSION_MINOR 1
#define CLIENT_VERSION_REVISION 0
#define CLIENT_VERSION_BUILD 0
#define CLIENT_VERSION_IS_RELEASE true
#define COPYRIGHT_YEAR 2025

// Platform/compiler
#define HAVE_STDINT_H 1
#define HAVE_INTTYPES_H 1
#define HAVE_STRERROR_R 1
#define HAVE_DECL_STRERROR_R 1
#define HAVE_SYS_SELECT_H 1
#define HAVE_SYS_TYPES_H 1
#define HAVE_SYS_STAT_H 1

// Windows-specific
#ifdef _WIN32
  #define WIN32_LEAN_AND_MEAN 1
  #define NOMINMAX 1
  #define HAVE_WIN32 1
#endif

// Feature flags
#define ENABLE_ZMQ 0
#define ENABLE_WALLET 1
#define ENABLE_BENCH 1
#define ENABLE_TESTS 1
#define ENABLE_QT 0

// Optional crypto
#define USE_SECP256K1 1
#define USE_RFC6979 1

// Include dir fallback
#define BITNION_HAVE_CONFIG_H 1

#endif // BITNION_CONFIG_H
