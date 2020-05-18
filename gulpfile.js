var gulp = require('gulp'),
	concat = require('gulp-concat'),
	uglify = require('gulp-uglify'),
	riot = require('gulp-riot');
	clean = require('gulp-clean');
	merge = require('merge-stream');
	webserver = require('gulp-webserver'),
	inject = require('gulp-inject-string'),
	gutil = require('gulp-util'),
	rename = require('gulp-rename'),
	replace = require('gulp-replace'),
	intercept = require('gulp-intercept'),
	shell = require('gulp-shell'),
	sort = require('gulp-sort'),
	cleanCSS = require('gulp-clean-css'),
	git = require('gulp-git'),
	runSequence = require('run-sequence'),
	debug = require('gulp-debug');

var resources = 'src/main/resources/'
var www = resources + 'www/';
	
var bases = {
	build: resources + 'public/',
	tags: www + 'tags/',
	js: www + 'js/',
	gufjs: www + 'js/guf',
	libjs: www + 'js/lib',
	appjs: www + 'js/app',
	css: www + 'css/',
	gufcss: www + 'css/guf',
	libcss: www + 'css/lib',
	appcss: www + 'css/app',
	i18n: www + 'i18n/',
	img: www + 'img/',
	images: www + 'images/',
	fonts: www + 'fonts/'
};

var files = {
	jsouttmp: '__tmp_guf-tags.js',
	jsout: 'guf-tags.js',
	gufjsout: 'guf.js',
	libjsout: 'lib.js',
	appjsout: 'app.js',
	i18nout: 'i18n.js',
	gufcssout: 'guf.css',
	libcssout: 'lib.css',
	appcssout: 'app.css',
	htmlmin: 'index-min.html'
};

function updateFiles(gitRevision) {
	files.jsout = 'guf-tags-' + gitRevision + '.js';
	files.gufjsout = 'guf-' + gitRevision + '.js';
	files.libjsout = 'lib-' + gitRevision + '.js';
	files.appjsout = 'app-' + gitRevision + '.js';
	files.gufcssout = 'guf-' + gitRevision + '.css';
	files.libcssout = 'lib-' + gitRevision + '.css';
	files.appcssout = 'app-' + gitRevision + '.css';
	files.i18nout = 'i18n-' + gitRevision + '.js';
}

var jsFirstFiles = [
	"js/lib/moment.js",
	"js/guf/guf-core.js",
	"js/app/app.js",
	"js/guf/guf-selection-model.js"
];
var jsLastFiles = [
	"js/guf/guf-core-end.js"
];

var dcss = {};
var tagFiles = [];
var gufJsFiles = [];
var libJsFiles = [];
var appJsFiles = [];
var gufCssFiles = [];
var libCssFiles = [];
var appCssFiles = [];
var i18nFiles = [];
var gitRevision = "Development";

var jsComparator = function(file1, file2){
	var filename1 = file1.path.replace(/\\/g,'/');
	var lastSeparator1 = filename1.search('\\/js\\/[a-zA-Z0-9]+\\/');
	if (lastSeparator1 != -1) {
		filename1 = filename1.substring(lastSeparator1 + 1);
	}
	var filename2 = file2.path.replace(/\\/g,'/');
	var lastSeparator2 = filename2.search('\\/js\\/[a-zA-Z0-9]+\\/');
	if (lastSeparator2 != -1) {
		filename2 = filename2.substring(lastSeparator2 + 1);
	}

	for (var i = 0; i < jsFirstFiles.length; i++) {
		if (filename1 === jsFirstFiles[i]) {
			return -1;
		} else if (filename2 === jsFirstFiles[i]) {
			return 1;
		}
	}

	for (var i = 0; i < jsLastFiles.length; i++) {
		if (filename1 === jsLastFiles[i]) {
			return 1;
		} else if (filename2 === jsLastFiles[i]) {
			return -11;
		}
	}

	if (filename1 > filename2) {
		return 1;
	} else if (filename1 < filename2) {
		return -1;
	} else {
		return 0;
	}
};
var cssComparator = function(file1, file2){
	var filename1 = file1.path.replace(/\\/g,'/');
	var lastSeparator1 = filename1.search('\\/css\\/[a-zA-Z0-9]+\\/');
	if (lastSeparator1 != -1) {
		filename1 = filename1.substring(lastSeparator1 + 1);
	}
	var filename2 = file2.path.replace(/\\/g,'/');
	var lastSeparator2 = filename2.search('\\/css\\/[a-zA-Z0-9]+\\/');
	if (lastSeparator2 != -1) {
		filename2 = filename2.substring(lastSeparator2 + 1);
	}
	if (filename1 > filename2) {
		return 1;
	} else if (filename1 < filename2) {
		return -1;
	} else {
		return 0;
	}
};

gulp.task('get-revision', function(callback) {
	git.revParse({args:'--short HEAD'}, function (err, hash) {
		console.log('Releasing GIT revision: ' + hash);
		gitRevision = hash;
		updateFiles(hash);
		callback();
	});
});

gulp.task('clean', function() {
	return merge(gulp.src(bases.build)
			.pipe(clean()));
});

gulp.task('clean-dev-src', function() {
	return merge(gulp.src(bases.build + 'index.html')
			.pipe(clean()),
		gulp.src(bases.build + 'css/app')
			.pipe(clean()),
		gulp.src(bases.build + 'css/guf')
			.pipe(clean()),
		gulp.src(bases.build + 'css/lib')
			.pipe(clean()),
		gulp.src(bases.build + 'js/app')
			.pipe(clean()),
		gulp.src(bases.build + 'js/guf')
			.pipe(clean()),
		gulp.src(bases.build + 'js/lib')
			.pipe(clean()),
		gulp.src(bases.build + 'tags')
			.pipe(clean()),
		gulp.src(bases.build + 'i18n')
			.pipe(clean())
		);
});

gulp.task('rename-index', function() {
	return gulp.src(bases.build + files.htmlmin)
		.pipe(clean())
		.pipe(rename('index.html'))
		.pipe(gulp.dest(bases.build));
});

gulp.task('-internal-build-pre', ['copy'], function() {
	dcss = {};
	
	return merge(
		gulp.src(bases.tags + '**/*.tag')
			.pipe(sort())
			.pipe(riot({
				compact: true,
				style: 'dcss',
				parsers: {
					'css' : {
						'dcss' : function(tag,css) {
							dcss[tag] = {
								unparsed: css,
								parsed: new Array(),
								last: 0
							};
							return "";
						}
					} 
				}
			}))
			.pipe(concat(files.jsouttmp))
			.pipe(uglify({ie8:true, output:{ascii_only:true}}))
			.on('error', function(error) {
				console.error("Error: " + error.message + "  Line number: " + error.lineNumber);
				throw error;
			})
			.pipe(gulp.dest(bases.build + 'js/')),
		gulp.src(bases.gufjs + '**/*.js')
			.pipe(sort({comparator : jsComparator}))
			.pipe(concat(files.gufjsout, {newLine: ';'}))
			.pipe(uglify({ie8:true, output:{ascii_only:true}}))
			.on('error', function(error) {
				console.error("Error: " + error.message + "  Line number: " + error.lineNumber);
				throw error;
			})
			.pipe(gulp.dest(bases.build + 'js/')),
		gulp.src(bases.libjs + '**/*.js')
			.pipe(sort({comparator : jsComparator}))
			.pipe(concat(files.libjsout, {newLine: ';'}))
			.pipe(uglify({ie8:true, output:{ascii_only:true}}))
			.on('error', function(error) {
				console.error("Error: " + error.message + "  Line number: " + error.lineNumber);
				throw error;
			})
			.pipe(gulp.dest(bases.build + 'js/')),
		gulp.src(bases.appjs + '**/*.js')
			.pipe(sort({comparator : jsComparator}))
			.pipe(concat(files.appjsout, {newLine: ';'}))
			.pipe(uglify({ie8:true, output:{ascii_only:true}}))
			.on('error', function(error) {
				console.error("Error: " + error.message + "  Line number: " + error.lineNumber);
				throw error;
			})
			.pipe(gulp.dest(bases.build + 'js/')),
		gulp.src(bases.gufcss + '**/*.css')
			.pipe(sort({comparator : cssComparator}))
			.pipe(concat(files.gufcssout))
			.pipe(cleanCSS())
			.pipe(gulp.dest(bases.build + 'css/')),
		gulp.src(bases.libcss + '**/*.css')
			.pipe(sort({comparator : cssComparator}))
			.pipe(concat(files.libcssout))
			.pipe(cleanCSS())
			.pipe(gulp.dest(bases.build + 'css/')),
		gulp.src(bases.appcss + '**/*.css')
			.pipe(sort({comparator : cssComparator}))
			.pipe(concat(files.appcssout))
			.pipe(cleanCSS())
			.pipe(gulp.dest(bases.build + 'css/')),
		gulp.src(bases.i18n + '**/*.js')
			.pipe(sort({comparator : jsComparator}))
			.pipe(concat(files.i18nout, {newLine: ';'}))
			.pipe(uglify({ie8:true, output:{ascii_only:true}}))
			.on('error', function(error) {
				console.error("Error: " + error.message + "  Line number: " + error.lineNumber);
				throw error;
			})
			.pipe(gulp.dest(bases.build + 'js/')));
});

gulp.task('-get-tags', function() {
	tagFiles = new Array();
	return gulp.src(bases.tags + '**/*.tag')
		.pipe(sort())
		.pipe(intercept(function(file){
			var filename = file.path.replace(/\\/g,'/');
			var lastSeparator = filename.indexOf('/tags/');
			if (lastSeparator != -1) {
				filename = filename.substring(lastSeparator + 1);
			}
			tagFiles.push(filename);
		}));
});

gulp.task('-get-guf-js', function() {
	gufJsFiles = new Array();
	return gulp.src(bases.gufjs + '**/*.js')
		.pipe(sort({comparator : jsComparator}))
		.pipe(intercept(function(file){
			var filename = file.path.replace(/\\/g,'/');
			var lastSeparator = filename.indexOf('/js\/guf/');
			if (lastSeparator != -1) {
				filename = filename.substring(lastSeparator + 1);
			}
			gufJsFiles.push(filename);
		}));
});

gulp.task('-get-lib-js', function() {
	libJsFiles = new Array();
	return gulp.src(bases.libjs + '**/*.js')
		.pipe(sort({comparator : jsComparator}))
		.pipe(intercept(function(file){
			var filename = file.path.replace(/\\/g,'/');
			var lastSeparator = filename.indexOf('/js\/lib/');
			if (lastSeparator != -1) {
				filename = filename.substring(lastSeparator + 1);
			}
			libJsFiles.push(filename);
		}));
});

gulp.task('-get-app-js', function() {
	appJsFiles = new Array();
	return gulp.src(bases.appjs + '**/*.js')
		.pipe(sort({comparator : jsComparator}))
		.pipe(intercept(function(file){
			var filename = file.path.replace(/\\/g,'/');
			var lastSeparator = filename.indexOf('/js\/app/');
			if (lastSeparator != -1) {
				filename = filename.substring(lastSeparator + 1);
			}
			appJsFiles.push(filename);
		}));
});

gulp.task('-get-guf-css', function() {
	gufCssFiles = new Array();
	return gulp.src(bases.gufcss + '**/*.css')
		.pipe(sort({comparator : cssComparator}))
		.pipe(intercept(function(file){
			var filename = file.path.replace(/\\/g,'/');
			var lastSeparator = filename.indexOf('/css\/guf/');
			if (lastSeparator != -1) {
				filename = filename.substring(lastSeparator + 1);
			}
			gufCssFiles.push(filename);
		}));
});

gulp.task('-get-lib-css', function() {
	libCssFiles = new Array();
	return gulp.src(bases.libcss + '**/*.css')
		.pipe(sort({comparator : cssComparator}))
		.pipe(intercept(function(file){
			var filename = file.path.replace(/\\/g,'/');
			var lastSeparator = filename.indexOf('/css\/lib/');
			if (lastSeparator != -1) {
				filename = filename.substring(lastSeparator + 1);
			}
			libCssFiles.push(filename);
		}));
});

gulp.task('-get-app-css', function() {
	appCssFiles = new Array();
	return gulp.src(bases.appcss + '**/*.css')
		.pipe(sort({comparator : cssComparator}))
		.pipe(intercept(function(file){
			var filename = file.path.replace(/\\/g,'/');
			var lastSeparator = filename.indexOf('/css\/app/');
			if (lastSeparator != -1) {
				filename = filename.substring(lastSeparator + 1);
			}
			appCssFiles.push(filename);
		}));
});

gulp.task('-get-i18n', function() {
	i18nFiles = new Array();
	return gulp.src(bases.i18n + '**/*.js')
		.pipe(sort({comparator : jsComparator}))
		.pipe(intercept(function(file){
			var filename = file.path.replace(/\\/g,'/');
			var lastSeparator = filename.indexOf('/i18n/');
			if (lastSeparator != -1) {
				filename = filename.substring(lastSeparator + 1);
			}
			i18nFiles.push(filename);
		}));
});

gulp.task('copy', ['-get-tags',
		'-get-guf-js', '-get-lib-js', '-get-app-js',
		'-get-guf-css', '-get-lib-css', '-get-app-css',
		'-get-i18n'], function() {
	var tagsImport = '';
	var gufJsImport = '';
	var libJsImport = '';
	var appJsImport = '';
	var gufCssImport = '';
	var libCssImport = '';
	var appCssImport = '';
	var i18nImport = '';
	var totalImports = 2;
	var minTotalImports = 2;
	totalImports += tagFiles.length + gufJsFiles.length + libJsFiles.length + appJsFiles.length +
		gufCssFiles.length + libCssFiles.length + appCssFiles.length + i18nFiles.length;
	for (var i = 0; i < tagFiles.length; i++) {
		if (tagsImport != '') {
			tagsImport += '\n\t\t';
		}
		tagsImport += '<script src="' + tagFiles[i] + '" type="riot/tag"></script>';
		tagsImport += '<script>window.importDone();</script>';
	}
	for (var i = 0; i < gufJsFiles.length; i++) {
		if (gufJsImport != '') {
			gufJsImport += '\n\t\t';
		}
		gufJsImport += '<script src="' + gufJsFiles[i] + '" type="text/javascript"></script>';
		gufJsImport += '<script>window.importDone();</script>';
	}
	for (var i = 0; i < libJsFiles.length; i++) {
		if (libJsImport != '') {
			libJsImport += '\n\t\t';
		}
		libJsImport += '<script src="' + libJsFiles[i] + '" type="text/javascript"></script>';
		libJsImport += '<script>window.importDone();</script>';
	}
	for (var i = 0; i < appJsFiles.length; i++) {
		if (appJsImport != '') {
			appJsImport += '\n\t\t';
		}
		appJsImport += '<script src="' + appJsFiles[i] + '" type="text/javascript"></script>';
		appJsImport += '<script>window.importDone();</script>';
	}
	for (var i = 0; i < gufCssFiles.length; i++) {
		if (gufCssImport != '') {
			gufCssImport += '\n\t\t';
		}
		gufCssImport += '<link rel="stylesheet" href="' + gufCssFiles[i] + '"/>';
		gufCssImport += '<script>window.importDone();</script>';
	}
	for (var i = 0; i < libCssFiles.length; i++) {
		if (libCssImport != '') {
			libCssImport += '\n\t\t';
		}
		libCssImport += '<link rel="stylesheet" href="' + libCssFiles[i] + '"/>';
		libCssImport += '<script>window.importDone();</script>';
	}
	for (var i = 0; i < appCssFiles.length; i++) {
		if (appCssImport != '') {
			appCssImport += '\n\t\t';
		}
		appCssImport += '<link rel="stylesheet" href="' + appCssFiles[i] + '"/>';
		appCssImport += '<script>window.importDone();</script>';
	}
	for (var i = 0; i < i18nFiles.length; i++) {
		if (i18nImport != '') {
			i18nImport += '\n\t\t';
		}
		i18nImport += '<script src="' + i18nFiles[i] + '" type="text/javascript"></script>';
		i18nImport += '<script>window.importDone();</script>';
	}
	minTotalImports += 8;
	return merge(
		gulp.src([
			bases.tags + '**/*.tag',
			bases.css + '**/*.css',
			bases.img + '**/*',
			bases.images + '**/*',
			bases.js + '**/*.js',
			bases.i18n + '**/*.js',
			bases.fonts + '**/*'], {base: www})
			.pipe(gulp.dest(bases.build)),
		gulp.src(www + 'index.html', {base: www})
			.pipe(replace('\<\?tags\?\>',tagsImport))
			.pipe(replace('\<\?gufjs\?\>',gufJsImport))
			.pipe(replace('\<\?libjs\?\>',libJsImport))
			.pipe(replace('\<\?appjs\?\>',appJsImport))
			.pipe(replace('\<\?gufcss\?\>',gufCssImport))
			.pipe(replace('\<\?libcss\?\>',libCssImport))
			.pipe(replace('\<\?appcss\?\>',appCssImport))
			.pipe(replace('\?revision\?',gitRevision))
			.pipe(replace('\<\?i18n\?\>',i18nImport))
			.pipe(replace('\<\?totalImports\?\>',totalImports))
			.pipe(gulp.dest(bases.build)),
		gulp.src(www + 'index.html', {base: www})
			.pipe(replace('\<\?tags\?\>','<script src="js/' + files.jsout + '" type="text/javascript"></script><script>window.importDone();</script>'))
			.pipe(replace('\<\?gufjs\?\>','<script src="js/' + files.gufjsout  + '" type="text/javascript"></script><script>window.importDone();</script>'))
			.pipe(replace('\<\?libjs\?\>','<script src="js/' + files.libjsout + '" type="text/javascript"></script><script>window.importDone();</script>'))
			.pipe(replace('\<\?appjs\?\>','<script src="js/' + files.appjsout  +'" type="text/javascript"></script><script>window.importDone();</script>'))
			.pipe(replace('\<\?gufcss\?\>','<link rel="stylesheet" href="css/' + files.gufcssout + '"/><script>window.importDone();</script>'))
			.pipe(replace('\<\?libcss\?\>','<link rel="stylesheet" href="css/' + files.libcssout + '"/><script>window.importDone();</script>'))
			.pipe(replace('\<\?appcss\?\>','<link rel="stylesheet" href="css/' + files.appcssout + '"/><script>window.importDone();</script>'))
			.pipe(replace('\?revision\?',gitRevision))
			.pipe(replace('\<\?i18n\?\>','<script src="js/' + files.i18nout  +'" type="text/javascript"></script><script>window.importDone();</script>'))
			.pipe(replace('\<\?totalImports\?\>',minTotalImports))
			.pipe(rename(files.htmlmin))
			.pipe(gulp.dest(bases.build)));
});

gulp.task('-internal-build', ['-internal-build-pre'], function() {
	var dcssHeader = "if(!guf)guf={};if(!guf.dcss)guf.dcss={};guf.dcss.tags=";
	return gulp.src(bases.build + 'js/' + files.jsouttmp)
		.pipe(clean())
		.pipe(inject.append(dcssHeader + JSON.stringify(dcss) + ";"))
		.pipe(uglify({ie8:true, output:{ascii_only:true}}))
		.pipe(rename(files.jsout))
		.pipe(gulp.dest(bases.build + 'js/'));
});

gulp.task('build', [], function(callback) {
	runSequence('clean',
		'-internal-build',
		callback);
});

gulp.task('release', ['get-revision'], function(callback) {
	runSequence('clean',
		'-internal-build',
		'clean-dev-src',
		'rename-index',
		callback);
});

gulp.task("run-browser", ['build'], function () {
	gulp.src(bases.build)
		.pipe(webserver({
			port: 8001,
			livereload: {
				enable: true,
				port: 35730
			},
			host: '0.0.0.0',
			directoryListing: false,
			open: 'http://localhost:8001'
		}));
	return gulp.watch([
		bases.tags + '**/*.tag',
		bases.js + '**/*.js',
		bases.img + '**/*',
		bases.images + '**/*',
		bases.css + '**/*.css',
		bases.i18n + '**/*.js',
		bases.fonts + '**/*',
		www + 'index*.html'], ['copy']);
});
