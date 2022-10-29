# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PV="${PV/_rc/-RC}"
DESCRIPTION="Vietnamese Bamboo engine for IBus"
HOMEPAGE="https://github.com/BambooEngine/ibus-bamboo"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/BambooEngine/${PN}.git"
else
	SRC_URI="https://github.com/BambooEngine/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="app-i18n/ibus"
DEPEND="${RDEPEND}
	x11-libs/libX11
	x11-libs/libXtst"
BDEPEND="sys-devel/make
	dev-lang/go"

src_install() {
	emake DESTDIR="${D}" install
	cp ${FILESDIR}/us.svg ${D}/usr/share/ibus-bamboo/icons/us.svg
	cp ${FILESDIR}/vi.svg ${D}/usr/share/ibus-bamboo/icons/vi.svg
}
