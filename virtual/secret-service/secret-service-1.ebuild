# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Virtual for a freedesktop.org Secret Service API provider"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~ia64 ~loong ~mips ppc ppc64 ~riscv sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"

RDEPEND="|| (
	gnome-base/gnome-keyring
	app-admin/keepassxc
	app-admin/secret-service
	>=kde-frameworks/kwallet-runtime-6.18.0[keyring]
)"
