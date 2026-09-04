# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit cmake git-r3 python-single-r1

DESCRIPTION="A simple, high-performance Vietnamese input method for Fcitx5"
HOMEPAGE="https://lotusinputmethod.github.io/ https://github.com/LotusInputMethod/fcitx5-lotus"

EGIT_REPO_URI="https://github.com/LotusInputMethod/${PN}.git"
EGIT_SUBMODULES=( '*' )

LICENSE="GPL-3+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="openrc +systemd"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	|| ( openrc systemd )
"

RDEPEND="
	${PYTHON_DEPS}
	>=app-i18n/fcitx-5.1.20:5
	dev-libs/libinput
	sys-apps/acl
	virtual/libudev
	x11-libs/libX11
	x11-themes/hicolor-icon-theme
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/qtpy[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-lang/go
	gnome-base/librsvg
	kde-frameworks/extra-cmake-modules
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DINSTALL_OPENRC=$(usex openrc)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	if ! use systemd; then
		rm -rf "${ED}"/usr/lib/systemd || die
	fi
}

pkg_postinst() {
	elog "fcitx5-lotus installs a udev rule and a sysusers.d entry that grant"
	elog "the 'lotus_uinput_proxy' system user rw access to /dev/uinput, used"
	elog "by the fcitx5-lotus-server helper. Make sure sys-apps/sysusers or an"
	elog "equivalent tool has processed lib/sysusers.d/lotus.conf, and re-plug"
	elog "any affected input devices (or reboot) so the udev rule applies."
	elog ""
	if use systemd; then
		elog "Enable the per-user server with:"
		elog "  systemctl enable --now fcitx5-lotus-server@\$(whoami).service"
	fi
	elog ""
	elog "For actual text input inside Qt/GTK applications, also install"
	elog "app-i18n/fcitx-qt and/or app-i18n/fcitx-gtk (the corresponding"
	elog "toolkit input method modules), and app-i18n/fcitx-configtool for a"
	elog "graphical Fcitx5 configuration tool. Then add 'Lotus' as an input"
	elog "method in the Fcitx5 configuration."
}
