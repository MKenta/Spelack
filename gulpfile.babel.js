import gulp from 'gulp'
import webpack from 'gulp-webpack'
import webpackConfig from './webpack.config.js';
import browserSync from 'browser-sync'
import notify from 'gulp-notify'
gulp.task('webpack', () => {
  gulp.src('app/assets/javascripts/**/*.js')
    .pipe(webpack(webpackConfig))
    .pipe(gulp.dest(webpackConfig.output.path))
    .pipe(browserSync.reload({stream: true}))
    .pipe(notify('finish webpack'));
});

gulp.task('browser-sync', function() {
  browserSync({
    proxy: {
      target: 'http://localhost:3000/messages'
    },
    port: 3000
  });
});

gulp.task('watch', function () {
    gulp.watch("./app/frontend/javascripts/**/**.js*",  ['webpack']);
    gulp.watch("./app/frontend/stylesheets/**.css*", ['webpack']);
    gulp.watch("./app/views/**/*.html*",   ['webpack']);
});

gulp.task('default', ['webpack', 'watch', 'browser-sync']);
