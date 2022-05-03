# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=(python3_7 python3_8 python3_9 python3_10)

inherit distutils-r1

DESCRIPTION="Mopidy extension for playing music from Spotify"
HOMEPAGE="http://mopidy.com https://github.com/mopidy/mopidy-spotify"
SRC_URI="https://github.com/mopidy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

RDEPEND="
	>=dev-libs/libspotify-12.1.51
	>=dev-python/pyspotify-2.0.5[${PYTHON_USEDEP}]
	>=media-sound/mopidy-3.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.0[${PYTHON_USEDEP}]
"

DEPEND="
	test? ( ${RDEPEND}
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/responses[${PYTHON_USEDEP}] )
	dev-python/setuptools[${PYTHON_USEDEP}]
"

DOCS=( README.rst )

python_test() {
	py.test || die
}
