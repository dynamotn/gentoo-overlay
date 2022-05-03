# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=(python3_7 python3_8 python3_9 python3_10)

inherit eutils systemd distutils-r1

DESCRIPTION="An extensible music server that plays music from local disk and more"
HOMEPAGE="http://mopidy.com https://github.com/mopidy/mopidy-mpd"
SRC_URI="mirror://pypi/M/Mopidy-MPD/Mopidy-MPD-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="dev-python/pykka[${PYTHON_USEDEP}]
	media-sound/mopidy[${PYTHON_USEDEP}]
"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S=${WORKDIR}/Mopidy-MPD-${PV}

src_install() {
	distutils-r1_src_install
}
