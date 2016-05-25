var path = require('path');
var webpack = require('webpack');
var glob = require('glob')

var config = module.exports = {
  context: __dirname,
  entry: glob.sync('./app/frontend/javascripts/**/*.js'),
};
config.output = {
  path: path.join(__dirname, 'app', 'assets', 'javascripts', 'bundle'),
  filename: 'bundle.js',
  publicPath: '/assets',
};
config.resolve = {
  extensions: ['', '.js','jsx'],
  modulesDirectories: [ 'node_modules' ],
};
config.module = {
  loaders: [
    { test: /\.js$/,
      exclude: /node_modules/,
     loader: 'babel-loader'
    },
    { test: /\.css$/,
     loader: 'style!css'
    },
  ],
};
