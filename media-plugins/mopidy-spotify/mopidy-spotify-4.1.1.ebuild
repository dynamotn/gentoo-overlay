# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=(python3_{8..11})

inherit distutils-r1

DESCRIPTION="Mopidy extension for playing music from Spotify"
HOMEPAGE="http://mopidy.com https://github.com/mopidy/mopidy-spotify"
SRC_URI="https://github.com/kingosticks/${PN}/archive/refs/heads/gstspotifysrc-hack.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=media-sound/mopidy-3.0.0
	>=dev-python/requests-2.20.0
	>=dev-python/pykka-2.0.1
	>=media-plugins/gst-plugin-spotify-0.9.2
"

DEPEND="
	test? ( ${RDEPEND}
	dev-python/pytest
	dev-python/responses
	dev-python/setuptools )
"
S=${WORKDIR}/mopidy-spotify-gstspotifysrc-hack

DOCS=(README.rst)

distutils_enable_tests pytest
