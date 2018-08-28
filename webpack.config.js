module.exports = {
  devtool: "source-map",
  entry: ["./index.js"],
  output: {
    path: __dirname + "/dist",
    filename: "index_bundle.js",
    sourceMapFilename: "index_bundle.js.map"
  },
  module: {
    rules: [
    ]
  }
};
