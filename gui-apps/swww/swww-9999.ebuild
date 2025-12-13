# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3 rust-toolchain

DESCRIPTION="Efficient animated wallpaper daemon for wayland, controlled at runtime"
HOMEPAGE="https://github.com/Horus645/swww"
EGIT_REPO_URI="${HOMEPAGE}"

RUST_MIN_VERSION=1.70.0

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD ISC MIT Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
IUSE="+man"
KEYWORDS="~amd64"

DEPEND="app-arch/lz4
        x11-libs/libxkbcommon[wayland]"
RDEPEND="${DEPEND}"
BDEPEND="
        man? ( app-text/scdoc )
"

QA_FLAGS_IGNORED="
	usr/bin/${PN}
	usr/bin/swww-daemon
"

src_unpack() {
  git-r3_src_unpack
  cargo_live_src_unpack
}

src_compile() {
  cargo_src_compile
  use man && "${S}"/doc/gen.sh
}

src_install() {
  dodoc README.md CHANGELOG.md
  dobashcomp "${WORKDIR}/swww-${PV}/completions/swww.bash"
  dofishcomp "${WORKDIR}/swww-${PV}/completions/swww.fish"

  if use man; then
    doman doc/generated/*
  fi

  if use debug; then
    cd target/debug || die
  else
    cd target/release || die
  fi

  dobin swww{,-daemon}
}
