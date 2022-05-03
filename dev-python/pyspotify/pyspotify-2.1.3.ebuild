# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=(python3_7 python3_8 python3_9 python3_10)

inherit distutils-r1

DESCRIPTION="Python bindings for libspotify"
HOMEPAGE="http://pyspotify.mopidy.com https://github.com/mopidy/pyspotify"
SRC_URI="https://github.com/mopidy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

RDEPEND="dev-libs/libspotify
	>=dev-python/cffi-1.0.0[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}] )
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( README.rst )

DISTUTILS_IN_SOURCE_BUILD=1

python_test() {
	cp build/lib/spotify/_spotify.*so spotify || die
	nosetests || die
}
