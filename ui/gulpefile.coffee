gulp = require 'gulp' 
clean = require 'gulp-clean' 
concat = require 'gulp-concat' 
sass = require 'gulp-sass' 
minifyCSS = require 'gulp-minify-css' 
coffee = require 'gulp-coffee' 
gutil = require 'gulp-util' 
uglify = require 'gulp-uglify' 
changed = require 'gulp-changed' 
cached = require 'gulp-cached' 
remember = require 'gulp-remember'

paths =
  coffee : ['./assets/coffee/*']
  scss : ['./assets/scss/*']
  dist : './public/'


gulp.task 'clean', ->
  gulp.src 'build', {read: false}
    .pipe clean();

gulp.task 'css', ->
  gulp.src paths.scss
    .pipe cached('css')
    .pipe sass()
    .pipe minifyCSS({keepBreaks:true})
    .pipe remember('css')
    .pipe concat("scanly.min.css")
    .pipe gulp.dest(paths.dist)

gulp.task 'js', ->
  gulp src paths.coffee
    .pipe cached('js')
    .pipe coffee().on('error', gutil.log)
    .pipe uglify()
    .pipe remember('js')
    .pipe concat("scanly.min.js")
    .pipe gulp.dest(paths.dist)

gulp.task 'vendor', ->
  gulp src 'vendor/*.js'
    .pipe concat('vendor.js')
    .pipe gulp.dest(paths.dist+'vendor.js')


gulp.task 'watch', ->
  jsWatcher = gulp.watch(paths.coffee, ['js']);
  cssWatcher = gulp.watch(paths.scss, ['css']);

  watchCache = (watcher,cacheRef) ->
    watcher.on 'change', (event) ->
      if event.type is 'deleted'
        delete cache.caches[cacheRef][event.path];
        remember.forget cacheRef, event.path;
  watchCache jsWatcher,"js";
  watchCache cssWatcher,"css";



gulp.task('default', ['watch','clean','js','css']);