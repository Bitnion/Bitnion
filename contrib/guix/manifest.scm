;; manifest.scm — Guix package list for building Bitnion deterministically
(use-modules (guix packages)
             (guix profiles)
             (gnu packages base)
             (gnu packages gcc)
             (gnu packages autotools)
             (gnu packages pkg-config)
             (gnu packages python)
             (gnu packages guile)
             (gnu packages openssl)
             (gnu packages crypto)
             (gnu packages version-control)
             (gnu packages compression))

(packages->manifest
 (list
  coreutils
  gcc
  gnu-make
  bash
  grep
  sed
  automake
  autoconf
  libtool
  pkg-config
  python
  git
  gzip
  bzip2
  xz
  unzip
  openssl
  which))
