'use strict'

gulp = require('gulp')
$ = require('gulp-load-plugins')(lazy: false)

paths =
  lint: [
    './gulpfile.coffee'
    './src/**/*.coffee'
  ]
  watch: [
    './gulpfile.coffee'
    './src/**/*.coffee'
    './test/**/*.coffee'
    '!test/{temp,temp/**}'
  ]
  tests: [
    './test/**/*.coffee'
    '!test/{temp,temp/**}'
  ]

gulp.task 'lint', ->
  gulp.src paths.lint
    .pipe $.coffeelint('./coffeelint.json')
    .pipe $.coffeelint.reporter()

gulp.task 'test', ['lint'], ->
  gulp.src paths.tests
    .pipe $.mocha()

gulp.task 'watch', ['test'], ->
  gulp.watch paths.watch, ['test']

gulp.task 'default', ['test']
