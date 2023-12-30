# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="Service to keep secrets of applications"
HOMEPAGE="https://github.com/yousefvand/secret-service"
SRC_URI="https://github.com/yousefvand/secret-service/archive/v${PV}.tar.gz -> secret-service-${PV}.tar.gz"
SRC_URI+=" https://github.com/dynamotn/gentoo-dependencies/releases/download/secret-service-${PV}/secret-service-${PV}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE=""

BDEPEND=">=dev-lang/go-1.20"

S="${WORKDIR}/secret-service-${PV}"

src_configure() {
	export CGO_ENABLED=1
	export CGO_CFLAGS="${CFLAGS}"
	export CGO_CPPFLAGS="${CPPFLAGS}"
	export CGO_CXXFLAGS="${CXXFLAGS}"
	export CGO_LDFLAGS="${LDFLAGS}"

	default
}

src_compile() {
	ego build -o secretserviced cmd/app/secretserviced/main.go || die
	ego build -o secretservice cmd/app/secretservice/main.go || die
}

src_install() {
	dobin secretserviced
	dobin secretservice
}
