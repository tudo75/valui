
dependencies_example = [
    dependency('gtk+-3.0', version: '>= 3.20'),
    dependency('glib-2.0'),
    dependency('cairo'),
    dependency('valui-' + API_VERSION),
]

sources = files('example.vala')

executable(
    'example',
    sources,
    dependencies: dependencies_example,
    install: false,
)
