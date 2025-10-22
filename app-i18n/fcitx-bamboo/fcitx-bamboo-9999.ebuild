# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Vietnamese Bamboo engine for Fcitx"
HOMEPAGE="https://github.com/fcitx/fcitx5-bamboo"

inherit git-r3 cmake
EGIT_REPO_URI="https://github.com/fcitx/fcitx5-bamboo.git -> ${P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=app-i18n/fcitx-5.0.0"
DEPEND="${RDEPEND}"
BDEPEND="dev-build/cmake
	dev-lang/go"
