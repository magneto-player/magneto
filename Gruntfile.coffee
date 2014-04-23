module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)

  # var buildPlatforms = parseBuildPlatforms(grunt.option('platforms'));

  grunt.initConfig
    watch:
      src:
        files: ['src/**/*']
        tasks: ['build:src']

    coffee:
      build:
        expand: true
        cwd: 'src'
        src: ['**/*.coffee']
        dest: 'lib'
        ext: '.js'

    copy:
      build:
        files: [
          { expand: true, cwd: 'src', src: ['index.html', 'package.json'], dest: 'lib' }
        ]
      ffmpeg:
        files: [
          {
            src: 'libraries/win/ffmpegsumo.dll',
            dest: 'build/releases/niceplay/win/niceplay/ffmpegsumo.dll',
            flatten: true
          }
          {
            src: 'libraries/win/ffmpegsumo.dll',
            dest: 'build/cache/win/<%= nodewebkit.build.options.version %>/ffmpegsumo.dll',
            flatten: true
          }
          {
            src: 'libraries/mac/ffmpegsumo.so',
            dest: 'build/releases/niceplay/mac/niceplay.app/Contents/Frameworks/node-webkit Framework.framework/Libraries/ffmpegsumo.so',
            flatten: true
          }
          {
            src: 'libraries/mac/ffmpegsumo.so',
            dest: 'build/cache/mac/<%= nodewebkit.build.options.version %>/node-webkit.app/Contents/Frameworks/node-webkit Framework.framework/Libraries/ffmpegsumo.so',
            flatten: true
          }
          # {
          #   src: 'libraries/linux64/libffmpegsumo.so',
          #   dest: 'build/releases/niceplay/linux64/niceplay/libffmpegsumo.so',
          #   flatten: true
          # }
          # {
          #   src: 'libraries/linux64/libffmpegsumo.so',
          #   dest: 'build/cache/linux64/<%= nodewebkit.build.options.version %>/libffmpegsumo.so',
          #   flatten: true
          # }
          # {
          #   src: 'libraries/linux32/libffmpegsumo.so',
          #   dest: 'build/releases/niceplay/linux32/niceplay/libffmpegsumo.so',
          #   flatten: true
          # }
          # {
          #   src: 'libraries/linux32/libffmpegsumo.so',
          #   dest: 'build/cache/linux32/<%= nodewebkit.build.options.version %>/libffmpegsumo.so',
          #   flatten: true
          # }
        ]

    clean:
      build: ['lib']

    concurrent:
      options:
        logConcurrentOutput: true
      dev: ['shell:nodewebkit', 'watch:src']

    shell:
      nodewebkit:
        command: './build/cache/mac/0.9.2/node-webkit.app/Contents/MacOS/node-webkit ./lib'
        options:
          stdout: true
          stderr: true

    nodewebkit:
      build:
        options:
          version: '0.9.2' # node-webkit version
          build_dir: './build' # Where the build version of my node-webkit app is saved
          # mac_icns: './images/popcorntime.icns' # Path to the Mac icon file
          # mac: buildPlatforms.mac
          # win: buildPlatforms.win
          # linux32: buildPlatforms.linux32
          # linux64: buildPlatforms.linux64

        src: [ # Your node-webkit app './**/*'
          './lib/**'
        ]

      dist:
        options:
          version: '0.9.2' # node-webkit version
          build_dir: './build' # Where the build version of my node-webkit app is saved
          embed_nw: false # Don't embed the .nw package in the binary
          keep_nw: true
          # mac_icns: './images/popcorntime.icns' # Path to the Mac icon file
          # mac: buildPlatforms.mac
          # win: buildPlatforms.win
          # linux32: buildPlatforms.linux32
          # linux64: buildPlatforms.linux64

        src: [ # Your node-webkit app './**/*'
          './lib/**'
        ]

  # parseBuildPlatforms = (argumentPlatform) ->

  #   # this will make it build no platform when the platform option is specified
  #   # without a value which makes argumentPlatform into a boolean
  #   inputPlatforms = argumentPlatform or process.platform + ';' + process.arch

  #   # Do some scrubbing to make it easier to match in the regexes bellow
  #   inputPlatforms = inputPlatforms.replace('darwin', 'mac')
  #   inputPlatforms = inputPlatforms.replace(/;ia|;x|;arm/, '')
  #   buildAll = /^all$/.test(inputPlatforms)
  #   buildPlatforms =
  #     mac: /mac/.test(inputPlatforms) or buildAll
  #     win: /win/.test(inputPlatforms) or buildAll
  #     linux32: /linux32/.test(inputPlatforms) or buildAll
  #     linux64: /linux64/.test(inputPlatforms) or buildAll

  #   return buildPlatforms

  grunt.registerTask 'check-node-webkit-build', ->
    if !grunt.file.isDir 'build/cache/mac/0.9.2'
      grunt.task.run ['build']

  grunt.registerTask 'build:src', [
    'coffee:build'
    'copy:build'
  ]

  grunt.registerTask 'build', [
    'clean:build'
    'build:src'
    'nodewebkit:build'
    'copy:ffmpeg'
  ]

  grunt.registerTask 'start', ['check-node-webkit-build', 'build:src', 'concurrent:dev']
  grunt.registerTask 'test', []
  grunt.registerTask 'default', [
    'start'
  ]

  return