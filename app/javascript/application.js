// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import "./tinymce_init"
import { UJS } from "@rails/ujs";

UJS.start();