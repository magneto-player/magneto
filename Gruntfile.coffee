module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)
  _ = require 'lodash'

  buildPlatforms = parseBuildPlatforms grunt.option('platforms')

  pkg = require('./package.json')

  config =
    build: 'build'
    libraries: 'libraries'
    src: 'src'
    lib: 'lib'
    test: 'test'
    testLib: 'test_lib'
    assets: 'src/assets'
    assetsLib: 'lib/assets/'
    styles: 'src/assets/styles'
    stylesLib: 'lib/assets/styles'

    nodewebkit:
      options:
        app_name: 'Niceplay'
        version: '0.9.2'
        build_dir: './build' # Where the build version of my node-webkit app is saved
        mac: buildPlatforms.mac
        win: false # buildPlatforms.win
        # linux32: buildPlatforms.linux32
        # linux64: buildPlatforms.linux64

        # Mac only
        # mac_icns: './images/popcorntime.icns' # Path to the Mac icon file
        credits: './credits.html'
      src: [
        './<%= config.lib %>/**'
      ].concat(
        _.keys(pkg.dependencies).map((k) -> './node_modules/' + k + '/**/*')
      )

  grunt.initConfig
    config: config

    # WATCH
    watch:
      src:
        files: [config.src + '/**/*']
        tasks: ['build:src']
      css:
        files: [config.styles + '/**/*']
        tasks: ['sass:dev']

    # BUILD
    coffee:
      build:
        expand: true
        cwd: config.src
        src: ['**/*.coffee']
        dest: config.lib
        ext: '.js'

    sass:
      dist:
        files:
          '<%= config.stylesLib %>/main.css': config.styles + '/main.scss'
        options:
          outputStyle: 'compressed'
          includePaths: [config.styles + '/imports.css']
      dev:
        files:
          '<%= config.stylesLib %>/main.css': config.styles + '/main.scss'
        options:
          outputStyle: 'nested'
          includePaths: [config.styles + '/imports.css']

    symlink:
      'node-modules':
        src: 'node_modules'
        dest: 'lib/node_modules'

    transfo:
      build:
        files: [
          { expand: true, cwd: 'src', src: ['index.html', 'package.json'], dest: config.lib }
        ]
      ffmpeg:
        files: [
          # {
          #   src: '<%= config.libraries %>/win/ffmpegsumo.dll'
          #   dest: 'build/releases/niceplay/win/niceplay/ffmpegsumo.dll'
          #   flatten: true
          # }
          # {
          #   src: '<%= config.libraries %>/win/ffmpegsumo.dll'
          #   dest: 'build/cache/win/<%= nodewebkit.build.options.version %>/ffmpegsumo.dll'
          #   flatten: true
          # }
          {
            src: '<%= config.libraries %>/mac/ffmpegsumo.so'
            dest: 'build/releases/niceplay/mac/niceplay.app/Contents/Frameworks/node-webkit Framework.framework/Libraries/ffmpegsumo.so'
            flatten: true
          }
          {
            src: '<%= config.libraries %>/mac/ffmpegsumo.so'
            dest: 'build/cache/mac/<%= nodewebkit.build.options.version %>/node-webkit.app/Contents/Frameworks/node-webkit Framework.framework/Libraries/ffmpegsumo.so'
            flatten: true
          }
          # {
          #   src: config.librairies + '/linux64/libffmpegsumo.so',
          #   dest: 'build/releases/niceplay/linux64/niceplay/libffmpegsumo.so',
          #   flatten: true
          # }
          # {
          #   src: config.librairies + '/linux64/libffmpegsumo.so',
          #   dest: 'build/cache/linux64/<%= nodewebkit.build.options.version %>/libffmpegsumo.so',
          #   flatten: true
          # }
          # {
          #   src: config.librairies + '/linux32/libffmpegsumo.so',
          #   dest: 'build/releases/niceplay/linux32/niceplay/libffmpegsumo.so',
          #   flatten: true
          # }
          # {
          #   src: config.librairies + '/linux32/libffmpegsumo.so',
          #   dest: 'build/cache/linux32/<%= nodewebkit.build.options.version %>/libffmpegsumo.so',
          #   flatten: true
          # }
        ]

    clean:
      build: [config.lib]

    concurrent:
      options:
        logConcurrentOutput: true
      dev: ['shell:nodewebkit', 'watch:src']

    shell:
      nodewebkit:
        command: './build/cache/mac/<%= nodewebkit.build.options.version %>/node-webkit.app/Contents/MacOS/node-webkit ./lib'
        options:
          stdout: true
          stderr: true

    nodewebkit:
      build:
        options: config.nodewebkit.options
        src: config.nodewebkit.src
      dist:
        options: _.extend( {}, config.nodewebkit.options,
          embed_nw: false # Don't embed the .nw package in the binary
          keep_nw: true
        )
        src: config.nodewebkit.src

  grunt.registerTask 'check-node-webkit-build', ->
    if !grunt.file.isDir('build/cache/mac/' + grunt.config.get('nodewebkit.build.options.version'))
      grunt.task.run ['build']

  grunt.registerTask 'build:src', [
    'coffee:build'
    'sass:dev'
    'transfo:build'
  ]

  grunt.registerTask 'build', [
    # 'clean:build'
    'build:src'
    'nodewebkit:build'
    'transfo:ffmpeg'
  ]

  grunt.registerTask 'start', ['check-node-webkit-build', 'build:src', 'concurrent:dev']
  grunt.registerTask 'test', []
  grunt.registerTask 'default', [
    'start'
  ]

  return

parseBuildPlatforms = (argumentPlatform) ->
  # this will make it build no platform when the platform option is specified
  # without a value which makes argumentPlatform into a boolean
  inputPlatforms = argumentPlatform or process.platform + ';' + process.arch

  # Do some scrubbing to make it easier to match in the regexes bellow
  inputPlatforms = inputPlatforms.replace('darwin', 'mac')
  inputPlatforms = inputPlatforms.replace(/;ia|;x|;arm/, '')
  buildAll = /^all$/.test(inputPlatforms)
  buildPlatforms =
    mac: /mac/.test(inputPlatforms) or buildAll
    win: /win/.test(inputPlatforms) or buildAll
    linux32: /linux32/.test(inputPlatforms) or buildAll
    linux64: /linux64/.test(inputPlatforms) or buildAll

  return buildPlatforms
