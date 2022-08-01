# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..4} )

inherit git-r3 autotools lua

DESCRIPTION="Lua bindings using PAM"
HOMEPAGE="https://github.com/devurandom/lua-pam"
EGIT_REPO_URI="https://github.com/devurandom/lua-pam.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm x86"
REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="sys-libs/pam
		dev-lang/lua
		${LUA_DEPS}"
DEPEND="${RDEPEND}"

lua_src_compile() {
	emake \
		LUA_CPPFLAGS=-I$(lua_get_include_dir) \
		LUA_VERSION=$(ver_cut 1-2 $(lua_get_version))
}

src_compile() {
	lua_foreach_impl lua_src_compile
}

lua_src_install() {
	insinto "${PREFIX}/usr/$(get_libdir)/lua/$(ver_cut 1-2 $(lua_get_version))"
	doins "pam.so"
}

src_install() {
	lua_foreach_impl lua_src_install
}
