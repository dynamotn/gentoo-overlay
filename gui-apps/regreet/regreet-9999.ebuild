# Copyright 2017-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""

inherit cargo

DESCRIPTION="Regreet greeter for greetd login manager"
HOMEPAGE="https://github.com/rharish101/ReGreet"

inherit git-r3
EGIT_REPO_URI="${HOMEPAGE}"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

QA_FLAGS_IGNORED="usr/bin/regreet"

LICENSE="Apache-2.0 Boost-1.0 GPL-3 MIT"
SLOT="0"

RDEPEND="acct-group/greetd
	acct-user/greetd
	gui-libs/greetd"
DEPEND="${RDEPEND}"

src_install() {
	dodir /var/cache/${PN}
	fowners greetd:greetd /var/cache/${PN}
	keepdir /var/cache/${PN}

	cargo_src_install
}
