conf = configuration_data()
conf.set('prefix', get_option('prefix'))
conf.set('libdir', get_option ('libdir'))
conf.set('PROJECT_NAME', 'com.github.tudo75.valui')
conf.set('PROJECT_VERSION', '0.0.1')
conf.set('API_VERSION', API_VERSION)

sources = files([
    'meter.vala'
])

libvalui = library(
    'valui-' + API_VERSION,
    sources,
    vala_header: 'valui.h',
    vala_vapi: 'valui-' + API_VERSION + '.vapi',
    vala_gir: 'valui-' + API_VERSION + '.gir',
    dependencies : dependencies,
    vala_args: [
        '--abi-stability'
    ],
    install: true,
    install_dir: [
        true,
        join_paths(get_option('includedir'), 'valui-' + API_VERSION),
        vapidir,
        g_ir_compiler.found()
    ]
)

if g_ir_compiler.found()
    custom_target(
        'libvalui-typelib',
        command: [
            g_ir_compiler,
            '--shared-library', 'libvalui-@0@.so'.format (API_VERSION),
            '--output', '@OUTPUT@',
            meson.current_build_dir() / 'valui-' + API_VERSION + '.gir'
        ],
        output: 'valui-' + API_VERSION + '.typelib',
        depends: libvalui,
        install: true,
        install_dir: join_paths(get_option('libdir'), 'girepository-1.0')
    )
endif

pkgconfig.generate(
    libvalui,
    subdirs: 'valui-' + API_VERSION,
    version: API_VERSION,
    name: 'ValUI',
    filebase: 'valui-' + API_VERSION,
    requires: PKGCONFIG_DEPS,
    description: 'A Vala Gtk3 UI library',
)

if get_option('enable_valadoc')
    valadoc = find_program('valadoc')
    valui_docs = custom_target('valui_apidocs',
        input: sources,
        install: true,
        # FIXME: Installing to tmp, so the target will be built
        #        the problem is we cannot access a subfolder of the
        #        buildtarget via the output parameter.
        #        Find a nicer solution
        install_dir: get_option('datadir') / 'devhelp' / 'books',
        command: [
        valadoc,
        '-o', meson.current_build_dir() / 'valui-' + API_VERSION,
        '--doclet',
        'devhelp',
        '@INPUT@',
        '--pkg=gtk+-3.0',
        '--pkg=glib-2.0',
        '--force'
        ],
        output: 'valui-' + API_VERSION)

    install_subdir(meson.current_build_dir() / 'valui-' + API_VERSION / 'valui-' + API_VERSION,
        install_dir: get_option('datadir') / 'devhelp' / 'books')
endif

# subdir('examples')
