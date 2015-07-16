module.exports = (grunt) ->
  grunt.initConfig
    pkg:
      grunt.file.readJSON 'package.json',

    less:
      app:
        options:
          sourceMap: false,
          bare: true,
          force: true
        expand: yes
        cwd: 'private/styles/'
        src: '**/*.less'
        dest: 'public/styles/'
        ext: '.css'

    coffee:
      app:
        options:
          sourceMap: false,
          bare: true,
          force: true
        expand: yes
        cwd: 'private/scripts/'
        src: '**/*.coffee'
        dest: 'public/scripts/'
        ext: '.js'
      main:
        options:
          sourceMap: false,
          bare: true,
          force: true
        expand: yes
        files:
          'app.js' : 'app/app.coffee'

    jade:
      app:
        options:
          sourceMap: false,
          bare: true,
          force: true
        expand: yes
        cwd: 'private/templates/'
        src: '**/*.jade'
        dest: 'public/templates/'
        ext: '.html'

    watch:
      coffee_app:
        files: ['app/app.coffee']
        tasks: ['coffee:main']	
      less:
        files: ['private/styles/*.less']
        tasks: ['less']
      coffee:
        files: ['private/scripts/*.coffee']
        tasks: ['coffee:app']
      jade:
        files: ['private/templates/*.jade']
        tasks: ['jade']

    grunt.loadNpmTasks 'grunt-contrib-less'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-contrib-watch'

    grunt.registerTask 'default', ['less', 'coffee', 'jade']