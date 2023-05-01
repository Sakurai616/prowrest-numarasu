// Entry point for the build script in your package.json
import "cocoon-js-vanilla";
import "@hotwired/turbo-rails"
import "./controllers"
import jquery from "jquery";
window.$ = window.jQuery = jquery;
import "@rails/actioncable"
import "./channels"