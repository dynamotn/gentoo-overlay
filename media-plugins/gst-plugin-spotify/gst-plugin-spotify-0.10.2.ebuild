# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=(python3_{8..11})
inherit meson-multilib python-any-r1

DESCRIPTION="GStreamer Spotify Plugin"
HOMEPAGE="https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs"
SRC_URI="https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/archive/${PV}/${PN}-${PV}.tar.gz -> ${P}.tar.gz"
GIT_COMMIT="b64da48508e48ff399b99f66ca110483651e8485"

LICENSE="MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=media-libs/gst-plugins-base-1.20.0
dev-libs/libsodium"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/rust-1.63
>=dev-util/cargo-c-0.9.3
virtual/pkgconfig
$(python_gen_any_dep 'dev-python/tomli[${PYTHON_USEDEP}]')"
RESTRICT="network-sandbox"

S=${WORKDIR}/gst-plugins-rs-${PV}-${GIT_COMMIT}

multilib_src_configure() {
  local emesonargs=(
    -Daudiofx=disabled
    -Dcdg=disabled
    -Dclaxon=disabled
    -Dcsound=disabled
    -Dlewton=disabled
    -Dspotify=enabled

    -Dfile=disabled
    -Dsodium=disabled
    -Dsodium-source=system
    -Dthreadshare=disabled

    -Dflavors=disabled
    -Dfmp4=disabled
    -Dmp4=disabled

    -Daws=disabled
    -Dhlssink3=disabled
    -Dndi=disabled
    -Donvif=disabled
    -Draptorq=disabled
    -Dreqwest=disabled
    -Drtp=disabled
    -Dwebrtc=disabled
    -Dwebrtchttp=disabled

    -Dtextahead=disabled
    -Djson=disabled
    -Dregex=disabled
    -Dtextwrap=disabled

    -Dfallbackswitch=disabled
    -Dlivesync=disabled
    -Dtogglerecord=disabled
    -Dtracers=disabled
    -Duriplaylistbin=disabled

    -Dcdg=disabled
    -Dclosedcaption=disabled
    -Ddav1d=disabled
    -Dffv1=disabled
    -Dgif=disabled
    -Dgtk4=disabled
    -Dhsv=disabled
    -Dpng=disabled
    -Drav1e=disabled
    -Dvideofx=disabled
    -Dwebp=disabled

    -Ddoc=disabled
    -Dexamples=disabled
  )
  meson_src_configure
}

src_prepare() {
  sed \
    -e '/gstreamer-net-1.0/d' \
    -i meson.build
  sed \
    -e '/gstreamer-rtp-1.0/d' \
    -i meson.build
  sed \
    -e '/gstreamer-video-1.0/d' \
    -i meson.build
  sed \
    -e '/gstreamer-sdp-1.0/d' \
    -i meson.build
  sed \
    -e '/gstreamer-webrtc-1.0/d' \
    -i meson.build
  sed \
    -e '/gstreamer-gl-1.0/d' \
    -i meson.build
  sed \
    -e "/'--features', features/d" \
    -i meson.build

  eapply "${FILESDIR}/${PV}-cargo.patch"
  eapply "${FILESDIR}/${PV}-dependency.patch"
  eapply_user
}
