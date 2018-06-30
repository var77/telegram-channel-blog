const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const Dotenv = require('dotenv-webpack');

module.exports = {
    entry: './src/index.js',
    output: {
        filename: 'bundle.js',
        path: path.resolve(__dirname, 'dist')
    },
    module: {
        rules: [
            {
                test: /\.css$/,
                loader: "style-loader!css-loader"
            },{
                test: /\.(ttf|eot|ttf|woff|woff2|svg)$/,
                loader: 'file-loader?name=/assets/fonts/[name].[ext]'
            }, {
                test: /\.(png|jpe?g)$/,
                loader: 'url-loader?limit=1&name=/assets/img/[name].[ext]'
            },{
                test: /\.(mp3|ogg)$/i,
                loader: 'file-loader?name=/assets/sounds/[name].[ext]'
            },{
                test: /\.html$/,
                loader: 'html-loader'
            },
            { test: /\.js$/, loader: 'babel-loader', exclude: /node_modules/ },
            { test: /\.jsx$/, loader: 'babel-loader', exclude: /node_modules/ }
        ]
    },

    devServer: { 
        host: 'localhost',
        port: 3000,
        inline: true
     },
    plugins: [
        new HtmlWebpackPlugin({
            template: './src/index.html'
        }),
        new Dotenv({
            path: './.env.' + process.env.NODE_ENV,
        })
    ]
};