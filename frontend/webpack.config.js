
const path = require('path');
const webpack = require('webpack');


module.exports = {

	mode: 'development',

	entry: {  dataset: path.resolve(__dirname, './src/dataset/Dataset.tsx')},

	output: {
		filename: '[name].min.js',
		path: path.resolve(__dirname, './public/js'),
	},

	module: {
		rules: [
			{
				enforce: "pre",
				test: /\.jsx$/,
				loader: 'babel-loader',
				exclude: /node_modiles/
			},
			{ test: /\.tsx?$/, loader: "ts-loader"},
			{ test: /\.ts?$/, loader: "ts-loader"}
		]
	},

	resolve: {
		extensions: ['.ts', '.tsx', '.js', '.jsx', '.json'],
		alias: {
			"@hooks"   : path.resolve(__dirname, "./src/hooks"),
			"@assets"  : path.resolve(__dirname, "./src/assets"),
			"@commons" : path.resolve(__dirname, './src/commons'),
		}
	},
	
	plugins: [
		new webpack.DefinePlugin({
			'process.env.REACT_APP_API_BASE_URL': JSON.stringify(process.env.REACT_APP_API_BASE_URL)
		})	
	],
	
	stats: {
		colors: true,
		reasons: true,
		chunks: false
	},
};
