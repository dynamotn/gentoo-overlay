# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{13..15})

inherit cmake git-r3 python-single-r1

DESCRIPTION="A simple, high-performance Vietnamese input method for Fcitx5"
HOMEPAGE="https://lotusinputmethod.github.io/"

EGIT_REPO_URI="https://github.com/LotusInputMethod/fcitx5-lotus.git"
EGIT_SUBMODULES=('*')

LICENSE="GPL-3+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="openrc +systemd"
RESTRICT="mirror"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	|| ( openrc systemd )
"

RDEPEND="
	${PYTHON_DEPS}
	>=app-i18n/fcitx-5.1.20:5
	x11-libs/libX11
	dev-libs/libinput
	virtual/libudev
	sys-apps/acl
	acct-user/uinput-proxy
	$(python_gen_cond_dep '
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-python/qtpy[${PYTHON_USEDEP}]
	')
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
  sed -i "s#uinput_proxy#uinput-proxy#g" misc/CMakeLists.txt
  cmake_src_configure
}

src_install() {
  cmake_src_install

  if ! use systemd; then
    rm -rf "${ED}"/usr/lib/systemd || die
  fi
}

pkg_postinst() {
  xdg_pkg_postinst
  udev_reload

  elog "fcitx5-lotus-server needs access to /dev/uinput for the smooth"
  elog "(uinput) typing mode. This is granted via a udev rule to the"
  elog "'uinput-proxy' system user, created by acct-user/uinput-proxy."
  elog ""
  if use systemd; then
    elog "Enable the per-user server with:"
    elog "  systemctl enable --now fcitx5-lotus-server@\$(whoami).service"
  fi
  if use openrc; then
    elog "For OpenRC, enable the corresponding init script instead:"
    elog "  ln -s /etc/init.d/fcitx5-lotus /etc/init.d/fcitx5-lotus.\$(whoami)"
    elog "  rc-update add fcitx5-lotus.\$(whoami) default"
    elog "  rc-service fcitx5-lotus.\$(whoami) restart"
  fi
  elog ""
  elog "For actual text input inside Qt/GTK applications, also install"
  elog "app-i18n/fcitx-qt and/or app-i18n/fcitx-gtk (the corresponding"
  elog "toolkit input method modules), and app-i18n/fcitx-configtool for a"
  elog "graphical Fcitx5 configuration tool. Then add 'Lotus' as an input"
  elog "method in the Fcitx5 configuration."
}

pkg_postrm() {
  xdg_pkg_postrm
  udev_reload
}
