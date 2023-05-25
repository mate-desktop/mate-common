data_dir = join_paths(pkgdatadir, 'data')

install_data('omf.make',
  install_dir : data_dir
)

install_data('xmldocs.make',
  install_dir : data_dir
)

doc_data = configuration_data()
doc_data.set('PACKAGE', meson.project_name())
doc_data.set('VERSION', meson.project_version())
doc_data.set('prefix', prefix)
doc_data.set('datarootdir', datadir )
doc_data.set('datadir', datadir)
configure_file(
  input : 'mate-doc-common.in',
  output : 'mate-doc-common',
  configuration : doc_data,
  install : true,
  install_mode: ['rwxr-xr-x', 'root', 'root'],
  install_dir : bindir
)
