# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

MY_PV="${PV/_rc/-RC}"
DESCRIPTION="Ibus Lotus - Vietnamese IME with Ibus"
HOMEPAGE="https://github.com/LotusInputEngine/ibus-lotus"

inherit git-r3
EGIT_REPO_URI="https://github.com/LotusInputEngine/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=app-i18n/ibus-1.5.33"
DEPEND="${RDEPEND}
	x11-libs/libX11
	x11-libs/libXtst"
BDEPEND="dev-build/make
	dev-lang/go"

src_compile() {
  emake build
}

src_install() {
  default
  insinto /usr/share/ibus-bamboo/icons
  doins "${FILESDIR}"/us.svg
  doins "${FILESDIR}"/vi.svg
}
