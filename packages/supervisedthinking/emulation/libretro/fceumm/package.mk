# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="fceumm"
PKG_VERSION="c17439b4f4a1a900b40a0c402aa52767fc04e5fb"
PKG_SHA256="cfc038fd7b50801fccb02050e9da0041e071bdb81a6dc8066302f85a21608a27"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/libretro-fceumm"
PKG_URL="https://github.com/libretro/libretro-fceumm/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Libretro port of the NES/Faimcom emulator FCE Ultra mappers mod project."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto"

PKG_LIBNAME="fceumm_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="GIT_VERSION=${PKG_VERSION:0:7}"

pre_configure_target() {
  if [ "${ARCH}" = "arm" ]; then
    if [ "${PROJECT}" = "RPi" ]; then
      case ${DEVICE} in
        RPi)
          PKG_MAKE_OPTS_TARGET+=" platform=rpi1"
        ;;
        RPi2)
          PKG_MAKE_OPTS_TARGET+=" platform=rpi2"
        ;;
      esac
    else
      PKG_MAKE_OPTS_TARGET+=" platform=armv-${TARGET_FLOAT}float-${TARGET_CPU}"
    fi
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
