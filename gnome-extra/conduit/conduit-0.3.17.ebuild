# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

PYTHON_DEPEND="2"

inherit eutils gnome.org python

DESCRIPTION="Synchronization for GNOME"
HOMEPAGE="http://live.gnome.org/Conduit"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64"
#flickr nautilus
IUSE="eog evolution ipod rss totem"

#DEPENDS extracted from http://packages.ubuntu.com/natty/conduit
#http://stuvel.eu/flickrapi
#		flickr? ( dev-python/flickr )
#Makefile bug: plugins are not installed even if enabled
#		nautilus? ( >=dev-python/nautilus-python-0.5.3 )
DEPEND=">=dev-python/pygoocanvas-0.9.0
		>=dev-python/pywebkitgtk-1.1.8
		>=dev-python/vobject-0.4.8
		>=dev-python/pyxml-0.8.4
		>=dev-python/pygtk-2.10.3
		dev-python/gdata
		evolution? ( dev-python/evolution-python )
		ipod? ( >=media-libs/libgpod-0.8.0[python] )
		rss? ( dev-python/feedparser )
		|| ( >=dev-lang/python-2.6 dev-python/simplejson )
		|| ( ( >=dev-lang/python-2.4 >=dev-python/pysqlite-2.3.1 )  >=dev-lang/python-2.5[sqlite] )"
RDEPEND=">=dev-python/pygoocanvas-0.9.0"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-non-ASCII-folder-canvas.patch"
	epatch "${FILESDIR}/${P}-programming-error-unicode.patch"
	epatch "${FILESDIR}/${P}-escaping-caracters.patch"
	epatch "${FILESDIR}/${P}-rhythmbox-new-path.patch"
	epatch "${FILESDIR}/${P}-fix-firefox-libraries.patch"

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

src_configure() {
	local myconf

	myconf=" --disable-scrollkeeper "

	#Makefile bug: plugins are not installed even if enabled
#	if use eog; then
#		myconf="${myconf} --with-eog-plugin-dir=$(pkg-config --variable=pluginsdir eog) "
#	fi
#
#	if use totem; then
#		myconf="${myconf} --with-totem-plugin-dir=/usr/$(get_libdir)/totem/plugins"
#	fi
#
#	if use nautilus; then
#		myconf="${myconf} --with-nautilus-extension-dir=$(pkg-config --variable=pythondir nautilus-python) "
#	fi
#		$(use_enable nautilus nautilus-extension) \
#		$(use_enable eog eog-plugin) \
#		$(use_enable totem totem-plugin) \

	econf \
		${myconf} \
		|| die "configure failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Error installing ${PN}"
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/conduit
	python_mod_optimize /usr/$(get_libdir)/conduit/modules/
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/conduit
	python_mod_cleanup /usr/$(get_libdir)/conduit/modules/
}
