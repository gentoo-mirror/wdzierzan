# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="A virtual lighttable and darkroom for photographers"
HOMEPAGE="http://darktable.sourceforge.net/index.shtml"
SRC_URI="http://downloads.sourceforge.net/project/darktable/darktable/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+lensfun openmp gnome-keyring static-libs nls watermark doc"

RDEPEND="dev-db/sqlite:3
	doc? ( dev-java/fop )
	dev-libs/dbus-glib
	gnome-base/gconf
	gnome-keyring? ( gnome-base/gnome-keyring )
	media-gfx/exiv2
	media-libs/jpeg
	media-libs/lcms
	lensfun? ( >=media-libs/lensfun-0.2.3 )
	media-libs/libpng
	media-libs/openexr
	media-libs/tiff
	net-misc/curl
	x11-libs/cairo
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_configure() {
	econf \
		$(use_enable static-libs static ) \
		$(use_enable gnome-keyring gkeyring ) \
		$(use_enable openmp ) \
		$(use_enable lensfun ) \
		$(use_enable nls ) \
		$(use_enable watermark ) \
		$(use_enable doc docs) \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS
}
