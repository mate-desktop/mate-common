project('mate-common',
  version: '1.28.0',
  meson_version: '>=0.50.0',
  license: 'GPLv3+',
)

prefix = get_option('prefix')
datadir = join_paths([ get_option('prefix'),get_option('datadir') ])
pkgdatadir = join_paths([ get_option('prefix'),get_option('datadir'),'mate-common' ])
bindir = join_paths([ get_option('prefix'), 'bin' ])
aclocaldir = join_paths([ datadir, 'aclocal' ])
mm_mandir = join_paths(prefix, get_option('mandir'))

subdir('macros')
subdir('doc')
subdir('doc-build')
