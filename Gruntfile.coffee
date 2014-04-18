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

    clean:
      build: ['lib']

    concurrent:
      options:
        logConcurrentOutput: true
      dev: ['shell:nodewebkit', 'watch:src']

    shell:
      nodewebkit:
        command: './build/cache/mac/0.9.2/node-webkit.app/Contents/MacOS/node-webkit --debug ./lib'
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

  grunt.registerTask 'build:src', [
    'coffee:build'
    'copy:build'
  ]

  grunt.registerTask 'build', [
    'clean:build'
    'build:src'
    'nodewebkit:build'
  ]

  grunt.registerTask 'server', ['build:src', 'concurrent:dev']
  grunt.registerTask 'test', []
  grunt.registerTask 'default', [
    'server'
  ]

  return