module.exports = (grunt) ->
  grunt.initConfig

    imagemin :
      default :
        files :
          "build/img/tipstricks.jpg" : "img/tipstricks.jpg"
          "output/img/tipstricks.jpg" : "img/tipstricks.jpg"
          "build/img/proplayers.jpg" : "img/proplayers.jpg"
          "output/img/proplayers.jpg" : "img/proplayers.jpg"



    concat :
      options :
        separator : " "
      layout :
        src : ['markdown/sommaire.md', 'markdown/chapters/**/*.md']
        dest : 'output/build.md'

    markdown :
      layout :
        options :
          #todo : layout
          template : "build/tpl/tpl.html"
        files :
          "build/index.html" : ["output/build.md"]

    html :
      files :
        "output/index.html" : ["output/build.md"]

    readme :
      files :
        "readme.html" : ["README.md"]

    coffee :
      default :
        options :
          bare : true
        files :[
          expand : true
          flatten : true
          src : ["*.coffee"]
          cwd : "script/cs"
          dest :"script/js/"
          ext : ".js"
        ]

    uglify :
      default :
        files :
          "build/js/main.js" : ["script/js/*.js"]





  # loader
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-markdown"
  grunt.loadNpmTasks "grunt-contrib-imagemin"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-uglify"



  # registerer
  grunt.registerTask 'default', 'concat:layout'

  grunt.registerTask 'layout', [
    'concat:layout'
    'imagemin'
    'markdown:layout'
    'coffee:default'
    'uglify'

  ]

  grunt.registerTask 'concatOnly', 'concat:layout'

  grunt.registerTask 'noLayout', [
    'concat:layout'
    'imagemin'
    'markdown:html'
  ]

  grunt.registerTask 'readme', 'markdown:readme'
