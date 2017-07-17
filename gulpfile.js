// Gulpy gulp
const gulp          = require('gulp');
const browserify    = require('browserify');
const source        = require('vinyl-source-stream');
const gutil         = require('gulp-util');
const babelify      = require('babelify');
const del           = require('del');

// Paths
const paths = {
  js_src:  `${__dirname}/app/assets/js-raw`,
  js_dest: `${__dirname}/app/assets/js`
};

const dependencies = [
	'react',
  'react-dom'
];

let scriptsCount = 0;

// Empty temp folders
function clean() {
  return del([`${paths.js_dest}`]);
}

gulp.task('scripts', function () {
    bundleApp(false);
});

gulp.task('deploy', function () {
    clean();
    bundleApp(true);
});

gulp.task('watch', function () {
	gulp.watch([`${paths.js_src}/**/*.js`], ['scripts']);
});

gulp.task('default', ['scripts','watch']);

function bundleApp(isProduction) {
  scriptsCount++;
  
	// Browserify will bundle all our js files together in to one and will let
	// us use modules in the front end.
	var appBundler = browserify({
    entries: `${paths.js_src}/app.js`,
    debug: true
  });
 
	// If it's not for production, a separate vendors.js file will be created
	// the first time gulp is run so that we don't have to rebundle things like
	// react everytime there's a change in the js file
  	if (!isProduction && scriptsCount === 1) {
  		// create vendors.js for dev environment.
  		browserify({
        require: dependencies,
        debug: true
      })
			.bundle()
			.on('error', gutil.log)
			.pipe(source('vendors.js'))
			.pipe(gulp.dest(paths.js_dest));
    }
    
  	if (!isProduction) {
      // make the dependencies external so they dont get bundled by the 
      // app bundler. Dependencies are already bundled in vendor.js for
      // development environments.
  		dependencies.forEach(function(dep) {
  			appBundler.external(dep);
  		});
  	}
 
  	appBundler
  		// transform ES6 and JSX to ES5 with babelify
	  	.transform("babelify", {presets: ["es2015", "react"]})
	    .bundle()
	    .on('error', gutil.log)
	    .pipe(source('bundle.js'))
	    .pipe(gulp.dest(paths.js_dest));
}
