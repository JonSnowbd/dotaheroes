var gulp = require('gulp')
var less = require('gulp-less')

gulp.task('css', function(){
    return gulp.src('./*.less')
        .pipe(less())
        .pipe(gulp.dest('../css/'));
});

gulp.task('watch', ['css'], function(){
    gulp.watch(['./*.less', './partials/*.less'], ['css']);
});
