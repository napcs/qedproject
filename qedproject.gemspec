# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "qedproject/version"

Gem::Specification.new do |s|
  s.name        = "qedproject"
  s.version     = QEDProject::VERSION
  s.authors     = ["Brian P. Hogan"]
  s.email       = ["brianhogan@napcs.com"]
  s.homepage    = "http://qedserver.naocs.com"
  s.summary     = %q{Quickly build a simple web development project for use with QEDServer}
  s.description = %q{Creates a web development project with support for CoffeeScript and Sass, with support for Backbone, Knockout, and more. }

  s.rubyforge_project = "qedproject"

  s.files         = [
    "bin/qedproject",
    "lib/qedproject.rb",
    "lib/qedproject/version.rb",
    "lib/qedproject/project.rb",
    "lib/qedproject/helpers.rb",
    "lib/qedproject/libraries/base.rb",
    "lib/qedproject/libraries/jquery.rb",
    "lib/qedproject/libraries/jquerymobile.rb",
    "lib/qedproject/libraries/backbone.rb",
    "lib/qedproject/libraries/knockout.rb",
    "lib/qedproject/libraries/jquerytmpl.rb",
    "lib/qedproject/libraries/skeleton.rb",
    "lib/qedproject/plugins.rb",
    "vendor/backbone/VERSION",
    "vendor/backbone/backbone-min.js",
    "vendor/backbone/json2.js",
    "vendor/backbone/underscore-min.js",
    "vendor/jquery/VERSION",
    "vendor/jquery/jquery-1.6.4.min.js",
    "vendor/jquerytmpl/VERSION",
    "vendor/jquerytmpl/jquery.tmpl.min.js",
    "vendor/knockout/VERSION",
    "vendor/knockout/knockout-1.2.1.js",
    "vendor/skeleton/VERSION",
    "vendor/skeleton/tabs.js",
    "vendor/skeleton/apple-touch-icon-114x114.png",
    "vendor/skeleton/apple-touch-icon-72x72.png",
    "vendor/skeleton/apple-touch-icon.png",
    "vendor/skeleton/base.css",
    "vendor/skeleton/templates/index.html",
    "vendor/skeleton/layout.css",
    "vendor/skeleton/favicon.ico",
    "vendor/skeleton/skeleton.css",
    "vendor/jasmine/lib/jasmine-1.0.2/jasmine-html.js",
    "vendor/jasmine/lib/jasmine-1.0.2/jasmine.css",
    "vendor/jasmine/lib/jasmine-1.0.2/jasmine.js",
    "vendor/jquerymobile/jquery.mobile-1.0rc1.css",
    "vendor/jquerymobile/jquery.mobile-1.0rc1.js",
    "vendor/jquerymobile/ajax-loader.png",
    "vendor/jquerymobile/icons-18-black.png",
    "vendor/jquerymobile/icons-18-white.png",
    "vendor/jquerymobile/icons-36-black.png",
    "vendor/jquerymobile/icons-36-white.png",
    "vendor/jquerymobile/templates/index.html",
    "templates/assets.yml",
    "templates/Guardfile",
    "templates/sampleSpec.coffee",
    "templates/sampleSpec.js",
    "templates/suite.html",
    "templates/index.html",
    "templates/Rakefile",
    "templates/compass.rb"
    
  
  ]
  s.executables   = "qedproject"
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_runtime_dependency "coffee-script", ">=2.2.0"
  s.add_runtime_dependency "sass", ">=3.1.8"
  s.add_runtime_dependency "compass", ">=0.11.5"
  s.add_runtime_dependency "guard-compass", ">=0.0.6"
  s.add_runtime_dependency "jammit", ">=0.6.3"
  s.add_runtime_dependency "rake", ">=0.8.7"
  s.add_runtime_dependency "guard", ">=0.8.0"
  s.add_runtime_dependency "guard-jammit", ">=0.2.0"
  s.add_runtime_dependency "guard-coffeescript", ">=0.5.2"
  s.add_runtime_dependency "guard-sass", ">=0.5.0"
  # s.add_runtime_dependency "rest-client"
end
