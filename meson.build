project('com.github.tudo75.valui', ['vala', 'c'], version: '0.0.2')

cc = meson.get_compiler('c')
m_dep = cc.find_library('m', required : false)

dependencies = [
	dependency('gtk+-3.0', version: '>= 3.20'),
	dependency('glib-2.0'),
    dependency('cairo'),
    dependency('gee-0.8'),
    m_dep,
]

pkgconfig = import('pkgconfig')

PKGCONFIG_DEPS = [
    'gtk+-3.0',
    'glib-2.0', 
    'cairo',
    'gee-0.8'
]

API_VERSION = '0.0.2'

vapidir = get_option('datadir') / 'vala' / 'vapi'

add_project_arguments(['--enable-experimental'], language: 'vala')

vapi_dir = join_paths(meson.source_root(), 'build', 'src')

g_ir_compiler = find_program('g-ir-compiler', required: false)

subdir('src')
