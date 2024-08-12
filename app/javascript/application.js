// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import "./tinymce_init"
import { UJS } from "@rails/ujs";
//= require ace-rails-ap
//= require ace/theme-tomorrow
//= require ace/mode-markdown
//= require ace/ext-language_tools
//= require bootstrap-markdown-editor

UJS.start();