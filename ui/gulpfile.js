var gulp = require('gulp');
var clean = require('gulp-clean');
var concat = require('gulp-concat');
var sass = require('gulp-sass');


gulp.task('clean', function () {
    return gulp.src('build', {read: false})
        .pipe(clean());
});


gulp.task('vendor', function() {
    return gulp.src('vendor/*.js')
        .pipe(concat('vendor.js'))
        .pipe(gulp.dest('build/vendor.js'))
});


gulp.task('default', function() {
    // place code for your default task here
});