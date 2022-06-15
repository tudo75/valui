
cc = meson.get_compiler('c')
m_dep = cc.find_library('m', required : false)

dependencies_example = [
    dependency('gtk+-3.0', version: '>= 3.20'),
    dependency('glib-2.0'),
    dependency('cairo'),
    dependency('gee-0.8'),
    dependency('valui-' + API_VERSION),
    m_dep,
]

executable(
    'example',
    'example.vala',
    dependencies: dependencies_example,
    install: false,
)


