# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="Service to keep secrets of applications"
HOMEPAGE="https://github.com/yousefvand/secret-service"
SRC_URI="https://github.com/yousefvand/secret-service/archive/v${PV}.tar.gz -> secret-service-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE=""

BDEPEND=">=dev-lang/go-1.20"

S="${WORKDIR}/secret-service-${PV}"

src_compile() {
	go build -race -o secretserviced cmd/app/secretserviced/main.go
	go build -race -o secretservice cmd/app/secretservice/main.go
}

src_install() {
	dobin secretserviced
	dobin secretservice
}
