const mix = require("laravel-mix");
const tailwindcss = require("tailwindcss");

require("@ayctor/laravel-mix-svg-sprite");

if (!mix.inProduction()) {
  mix.webpackConfig({
    devtool: "inline-source-map",
  });
}

mix.setPublicPath("./web/cr-assets");

mix.svgSprite("resources/svg/**/*.svg", {
  output: {
    filename: 'sprite.svg'
  }
})

mix.options({
  autoprefixer: { remove: false }
});

mix
  .sourceMaps()
  .js("resources/js/app.js", "app.js")
  .postCss("resources/css/app.css", "app.css", [
    require("tailwindcss"),
  ])
  // .copyDirectory("resources/favicon", "./web/cr-assets/favicon")
  // .copyDirectory("resources/img", "./web/cr-assets/img")
  .version();

mix.disableSuccessNotifications();
