project('com.github.tudo75.valui', ['vala', 'c'], version: '0.0.1')

dependencies = [
	dependency('gtk+-3.0', version: '>= 3.20'),
	dependency('glib-2.0'),
    dependency('cairo'),
]

pkgconfig = import('pkgconfig')

PKGCONFIG_DEPS = [
    'gtk+-3.0',
    'glib-2.0', 
    'cairo',
]

API_VERSION = '0.0.1'

vapidir = get_option('datadir') / 'vala' / 'vapi'

add_project_arguments(['--enable-experimental'], language: 'vala')

vapi_dir = join_paths(meson.source_root(), 'build', 'src')

g_ir_compiler = find_program('g-ir-compiler', required: false)

subdir('src')
