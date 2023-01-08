
const path = require('path');

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
		extensions: ['.ts', '.tsx', '.js', '.jsx', '.json']
	},
	
	stats: {
		colors: true,
		reasons: true,
		chunks: false
	},

	devServer: {
		static: path.resolve(__dirname, './static'),
	},

};
