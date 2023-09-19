# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo git-r3

DESCRIPTION="Efficient animated wallpaper daemon for wayland, controlled at runtime"
HOMEPAGE="https://github.com/Horus645/swww"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD Boost-1.0 ISC MIT Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="app-arch/lz4"
RDEPEND="${DEPEND}"
BDEPEND=""

QA_FLAGS_IGNORED="
	usr/bin/${PN}
	usr/bin/swww-daemon
"

src_prepare() {
	default

	cp "${FILESDIR}"/build.rs \
	   "${WORKDIR}"/swww-${PV}/build.rs || die
}

src_install() {
	cargo_src_install

	dobin target/release/swww
	dobin target/release/swww-daemon
}

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}
