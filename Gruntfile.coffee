module.exports = (grunt) ->
    # Project config
    grunt.initConfig {
        pkg: grunt.file.readJSON('package.json'),
        
        coffee: {
            compile: {
                files: {
                    'static/js/init.coffee.js': ['static/js/init.coffee']
                }
            }
        },
        
        concat: {
            options: {
                separator: ';'
            },
            dist: {
                src: ['static/js/yepnope.js', 'static/js/init.coffee.js'],
                dest: 'static/js/build/ellumia.js'
            }
        },
        
        uglify: {
            options: {
                banner: '/*! Ellumia <%= grunt.template.today("yyyy-mm-dd") %> */\n'
            },
            
            build: {
                src: 'static/js/build/ellumia.js',
                dest: 'static/js/build/ellumia.min.js'
            }
        },
        
        watch: {
            files: ['static/js/*.coffee', 'static/js/*.js', '!static/js/*.coffee.js'],
            tasks: ['build']
        }
    }
    
    # Load plugins
    grunt.loadNpmTasks('grunt-contrib-coffee')
    grunt.loadNpmTasks('grunt-contrib-uglify')
    grunt.loadNpmTasks('grunt-contrib-concat')
    grunt.loadNpmTasks('grunt-contrib-watch')
    
    # Default tasks
    grunt.registerTask('build', ['coffee', 'concat', 'uglify'])
