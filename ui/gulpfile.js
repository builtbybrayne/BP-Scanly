var gulp = require('gulp'),
    clean = require('gulp-clean'),
    concat = require('gulp-concat'),
    sass = require('gulp-sass'),
    minifyCSS = require('gulp-minify-css'),
    coffee = require('gulp-coffee'),
    gutil = require('gulp-util'),
    uglify = require('gulp-uglify'),
    changed = require('gulp-changed'),
    cached = require('gulp-cached'),
    remember = require('gulp-remember')
;

var paths = {
    coffee : ['./assets/coffee/*'],
    scss : ['./assets/scss/*'],
    dist : './public/'
}


gulp.task('clean', function () {
    return gulp.src('build', {read: false})
        .pipe(clean());
});

gulp.task('css', function () {
    gulp.src(paths.scss)
        .pipe(cached('css'))
        .pipe(sass())
        .pipe(minifyCSS({keepBreaks:true}))
        .pipe(remember('css'))
        .pipe(concat("scanly.min.css"))
        .pipe(gulp.dest(paths.dist))
});

gulp.task('js',function(){
    gulp.src(paths.coffee)
        .pipe(cached('js'))
        .pipe(coffee().on('error', gutil.log))
        .pipe(uglify())
        .pipe(remember('js'))
        .pipe(concat("scanly.min.js"))
        .pipe(gulp.dest(paths.dist))
})

gulp.task('vendor', function() {
    return gulp.src('vendor/*.js')
        .pipe(concat('vendor.js'))
        .pipe(gulp.dest(paths.dist+'vendor.js'))
});


gulp.task('watch', function() {
    var jsWatcher = gulp.watch(paths.coffee, ['js']);
    var cssWatcher = gulp.watch(paths.scss, ['css']);

    var watchCache = function(watcher,cacheRef) {
        watcher.on('change', function (event) {
            if (event.type === 'deleted') { // if a file is deleted, forget about it
                delete cache.caches[cacheRef][event.path]; // gulp-cached remove api
                remember.forget(cacheRef, event.path); // gulp-remember remove api
            }
        });
    }
    watchCache(jsWatcher,"js");
    watchCache(cssWatcher,"css");
});



gulp.task('default', ['watch','clean','js','css']);