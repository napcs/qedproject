# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "qedproject/version"

Gem::Specification.new do |s|
  s.name        = "qedproject"
  s.version     = QEDProject::VERSION
  s.authors     = ["Brian P. Hogan"]
  s.email       = ["brianhogan@napcs.com"]
  s.homepage    = "http://napcs.github.io/qedproject/"
  s.summary     = %q{Quickly build a simple web development project for use with QEDServer}
  s.description = %q{Creates a web development project with support for CoffeeScript and Sass, with support for Backbone, Knockout, and more. }

  s.rubyforge_project = "qedproject"

  s.required_ruby_version = ">=1.9.3"
  s.files         = [
    "bin/qedproject",
    "lib/qedproject.rb",
    "lib/qedproject/version.rb",
    "lib/qedproject/project.rb",
    "lib/qedproject/helpers.rb",
    "lib/qedproject/libraries/base.rb",
    "lib/qedproject/libraries/angular.rb",
    "lib/qedproject/libraries/jquery.rb",
    "lib/qedproject/libraries/jquerymobile.rb",
    "lib/qedproject/libraries/backbone.rb",
    "lib/qedproject/libraries/knockout.rb",
    "lib/qedproject/libraries/skeleton.rb",
    "lib/qedproject/libraries/mustache.rb",
    "lib/qedproject/libraries/ember.rb",
    "lib/qedproject/plugins.rb",
    "vendor/backbone/VERSION",
    "vendor/backbone/backbone.js",
    "vendor/backbone/json2.js",
    "vendor/backbone/underscore.js",
    "vendor/jquery/VERSION",
    "vendor/jquery/jquery-1.10.1.min.js",
    "vendor/knockout/VERSION",
    "vendor/knockout/knockout-2.2.1.js",
    "vendor/skeleton/VERSION",
    "vendor/skeleton/apple-touch-icon-114x114.png",
    "vendor/skeleton/apple-touch-icon-72x72.png",
    "vendor/skeleton/apple-touch-icon.png",
    "vendor/skeleton/base.css",
    "vendor/skeleton/templates/index.html",
    "vendor/skeleton/layout.css",
    "vendor/skeleton/favicon.ico",
    "vendor/skeleton/skeleton.css",
    "vendor/jasmine-jquery/jasmine-jquery.js",
    "vendor/jasmine-jquery/VERSION",
    "vendor/jasmine/lib/jasmine-1.3.1/jasmine-html.js",
    "vendor/jasmine/lib/jasmine-1.3.1/jasmine.css",
    "vendor/jasmine/lib/jasmine-1.3.1/jasmine.js",
    "vendor/jquerymobile/jquery.mobile-1.3.0.css",
    "vendor/jquerymobile/jquery.mobile-1.3.0.js",
    "vendor/jquerymobile/ajax-loader.gif",
    "vendor/jquerymobile/icons-18-black.png",
    "vendor/jquerymobile/icons-18-white.png",
    "vendor/jquerymobile/icons-36-black.png",
    "vendor/jquerymobile/icons-36-white.png",
    "vendor/jquerymobile/templates/index.html",
    "vendor/mustache/mustache.js",
    "vendor/mustache/VERSION",
    "vendor/angular/VERSION",
    "vendor/angular/angular-1.1.5.js",
    "vendor/angular/angular-resource.js",
    "vendor/ember/ember-1.0.0-rc.1.js",
    "vendor/ember/handlebars-1.0.0-rc.3.js",
    "vendor/ember/VERSION",
    "templates/assets.yml",
    "templates/Guardfile",
    "templates/sampleSpec.coffee",
    "templates/sampleSpec.js",
    "templates/suite.html",
    "templates/index.html",
    "templates/Rakefile",
    "templates/Gemfile",
    "vendor/jasmine-jquery/jasmine-jquery.js"
    
  
  ]
  s.executables   = "qedproject"
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_runtime_dependency "net-ssh"
  s.add_runtime_dependency "net-sftp"
  s.add_runtime_dependency "net-scp"
  s.add_runtime_dependency "coffee-script", "~>2.2.0"
  s.add_runtime_dependency "sass", "~>3.2.0"
  s.add_runtime_dependency "jammit", "~>0.6.5"
  s.add_runtime_dependency "uglifier", "~>1.3.0"
  s.add_runtime_dependency "rake", "~>10.1"
  s.add_runtime_dependency "guard", "~>1.6.0"
  s.add_runtime_dependency "guard-jammit", "~>1.0.1"
  s.add_runtime_dependency "guard-coffeescript", "~>1.2.0"
  s.add_runtime_dependency "guard-sass", "~>1.0.0"
  s.add_runtime_dependency "guard-livereload", "~>1.1.0"
  s.add_development_dependency "guard-test"
  s.add_development_dependency "rdoc"
  s.add_development_dependency "mocha", ">=0.13.0"
  
end
