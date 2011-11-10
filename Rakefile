require 'rake'
require 'rake/testtask' 
require 'rake/rdoctask' 
require 'lib/qedproject/version'

require 'rcov/rcovtask'

Rcov::RcovTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

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
  FileUtils.mkdir_p skeleton
  Dir.chdir skeleton do
    `wget --no-check-certificate https://github.com/dhgamache/Skeleton/zipball/master -O skeleton.zip`
    `unzip -j skeleton.zip`
    `echo 1.1.0 >> VERSION`
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
    `echo 1.0.2 >> VERSION`
  end

end

task :fetch_js do
  Rake::Task[:fetch_knockout].invoke
  Rake::Task[:fetch_jquerytmpl].invoke
  Rake::Task[:fetch_backbone].invoke
  Rake::Task[:fetch_jquery].invoke
  Rake::Task[:fetch_skeleton].invoke
  Rake::Task[:fetch_jqm].invoke
  Rake::Task[:fetch_jqueryui].invoke
  Rake::Task[:fetch_mustache].invoke
  

end



task :fetch_mustache do
  FileUtils.rm_rf("vendor/mustache")
  FileUtils.mkdir("vendor/mustache")
  Dir.chdir("vendor/mustache") do
    `wget --no-check-certificate https://raw.github.com/janl/mustache.js/0.3.0/mustache.js`
    `echo 0.3.0 >> VERSION`
  end
end

task :fetch_knockout do
  FileUtils.rm_rf("vendor/knockout")
  FileUtils.mkdir("vendor/knockout")
  Dir.chdir("vendor/knockout") do
    `wget --no-check-certificate https://github.com/downloads/SteveSanderson/knockout/knockout-1.2.1.js`
    `echo 1.2.1 >> VERSION`
  end
end

task :fetch_jquerytmpl do
  tmpldir = "vendor/jquery.tmpl"
  FileUtils.rm_rf tmpldir
  FileUtils.mkdir tmpldir
  Dir.chdir tmpldir do
    `wget --no-check-certificate https://raw.github.com/jquery/jquery-tmpl/master/jquery.tmpl.min.js`
    `echo 1.0.0pre >> VERSION`
  end
end

task :fetch_jquery do
  FileUtils.rm_rf("vendor/jquery")
  FileUtils.mkdir("vendor/jquery")
  Dir.chdir("vendor/jquery") do
    `wget http://code.jquery.com/jquery.min.js -O jquery-1.7.0.min.js`
    `echo 1.7.0 >> VERSION`
  end
end


task :fetch_jqm do
  jqm = "vendor/jquerymobile"
  FileUtils.rm_rf jqm
  FileUtils.mkdir_p jqm
  Dir.chdir jqm do
    `wget http://code.jquery.com/mobile/1.0rc2/jquery.mobile-1.0rc2.zip`
    `unzip -j jquery.mobile-1.0rc2.zip`
    `echo 1.0rc2 >> VERSION`
  end

end

task :fetch_backbone do
  FileUtils.rm_rf("vendor/backbone")
  FileUtils.mkdir_p("vendor/backbone")
  Dir.chdir("vendor/backbone") do
    `wget http://documentcloud.github.com/underscore/underscore-min.js`
    `wget http://documentcloud.github.com/backbone/backbone-min.js`
    `wget --no-check-certificate https://raw.github.com/douglascrockford/JSON-js/master/json2.js`
    `echo 1.5.3 >> VERSION`

  end

  
end
