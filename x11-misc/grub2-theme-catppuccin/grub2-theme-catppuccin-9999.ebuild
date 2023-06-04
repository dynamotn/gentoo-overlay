# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Catppuccin theme for Grub"
HOMEPAGE="https://github.com/catppuccin/grub"

inherit git-r3
EGIT_REPO_URI="https://github.com/catppuccin/grub.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="sys-boot/grub"

src_install() {
	insinto /usr/share/grub/themes
	doins -r src/catppuccin-macchiato-grub-theme
}
