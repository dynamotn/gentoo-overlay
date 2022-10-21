# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..4} luajit )

inherit git-r3 autotools lua

DESCRIPTION="Lua bindings using PAM"
HOMEPAGE="https://github.com/dynamotn/lua-pam"
EGIT_REPO_URI="https://github.com/dynamotn/lua-pam.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm x86"
REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="sys-libs/pam
		dev-lang/lua
		${LUA_DEPS}"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	lua_copy_sources
}

get_lua_version() {
	if [[ ${ELUA} != luajit ]]; then
		LUA_VERSION="$(ver_cut 1-2 $(lua_get_version))"
	else
		LUA_VERSION="5.1"
	fi
}

lua_src_compile() {
	pushd "${BUILD_DIR}" || die

	get_lua_version
	emake \
		LUA_CPPFLAGS=-I$(lua_get_include_dir) \
		LUA_VERSION=$LUA_VERSION
}

src_compile() {
	lua_foreach_impl lua_src_compile
}

lua_src_install() {
	pushd "${BUILD_DIR}" || die

	get_lua_version
	insinto "${PREFIX}/usr/$(get_libdir)/lua/$LUA_VERSION"
	doins "pam.so"
}

src_install() {
	lua_foreach_impl lua_src_install
}
