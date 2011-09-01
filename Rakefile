require 'rake'
require 'rake/testtask' 
require 'rake/rdoctask' 
require 'lib/qedproject/version'

gemspec = Dir.glob("*.gemspec").first
gemname = gemspec.gsub(".gemspec", "")

desc "Build the gem"
task :build do
  puts "Building the gem"
  `gem build #{gemspec}`
end                     

desc "Install the gem"
task :install => :build do
  puts "installing #{gemname}"
  `gem install #{gemname}-#{QEDProject::VERSION}`
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task :fetch_skeleton do
  skeleton = "vendor/skeleton"
  FileUtils.rm_rf skeleton
  FileUtils.mkdir skeleton
  Dir.chdir skeleton do
    `wget --no-check-certificate https://github.com/dhgamache/Skeleton/zipball/master -O skeleton.zip`
    `unzip -j skeleton.zip`
    f = File.read("index.html")
  end

end
task :fetch_jasmine do
  jasmine = "vendor/jasmine"
  FileUtils.rm_rf jasmine
  FileUtils.mkdir jasmine
  Dir.chdir jasmine do
    `wget http://pivotal.github.com/jasmine/downloads/jasmine-standalone-1.0.2.zip`
    `unzip jasmine-standalone-1.0.2.zip`
  end

end

task :fetch_js do
  Rake::Task[:fetch_knockout].invoke
  Rake::Task[:fetch_jquerytmpl].invoke
  Rake::Task[:fetch_backbone].invoke
  Rake::Task[:fetch_jquery].invoke

end
task :fetch_knockout do
  FileUtils.rm_rf("vendor/knockout")
  FileUtils.mkdir("vendor/knockout")
  Dir.chdir("vendor/knockout") do
    `wget --no-check-certificate https://github.com/downloads/SteveSanderson/knockout/knockout-1.2.1.js`
  end
end

task :fetch_jquerytmpl do
  tmpldir = "vendor/jquery.tmpl"
  FileUtils.rm_rf tmpldir
  FileUtils.mkdir tmpldir
  Dir.chdir tmpldir do
    `wget --no-check-certificate https://raw.github.com/jquery/jquery-tmpl/master/jquery.tmpl.min.js`
  end
end

task :fetch_jquery do
  FileUtils.rm_rf("vendor/jquery")
  FileUtils.mkdir("vendor/jquery")
  Dir.chdir("vendor/jquery") do
    `wget http://code.jquery.com/jquery-1.6.2.min.js`
  end
end


task :fetch_backbone do
  FileUtils.rm_rf("vendor/backbone")
  FileUtils.mkdir_p("vendor/backbone")
  Dir.chdir("vendor/backbone") do
    `wget http://documentcloud.github.com/underscore/underscore-min.js`
    `wget http://documentcloud.github.com/backbone/backbone-min.js`
    `wget --no-check-certificate https://raw.github.com/douglascrockford/JSON-js/master/json2.js`


  end

  
end
