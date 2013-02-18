require 'rake'
require 'rake/testtask' 
require 'rdoc/task' 
require 'qedproject/version'

# require 'rcov/rcovtask'

# Rcov::RcovTask.new do |t|
#   t.libs << "test"
#   t.test_files = FileList['test/*_test.rb']
#   t.verbose = true
# end

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

task :fetch_ember do
  
  dir = "vendor/ember"
  FileUtils.rm_rf dir
  FileUtils.mkdir_p File.join dir, "templates"
  FileUtils.cp "vendor/templates/ember_index.html", File.join(dir, "templates", "index.html")
  Dir.chdir dir do
    `wget --no-check-certificate https://github.com/downloads/emberjs/starter-kit/starter-kit.0.9.zip -O ember.zip`
    `unzip -j ember.zip`
    `echo 0.9 >> VERSION`
  end
end

task :fetch_skeleton do
  skeleton = "vendor/skeleton"
  FileUtils.rm_rf skeleton
  FileUtils.mkdir_p skeleton
  Dir.chdir skeleton do
    `wget --no-check-certificate https://github.com/dhgamache/Skeleton/zipball/master -O skeleton.zip`
    `unzip -j skeleton.zip`
    `echo 1.2.0 >> VERSION`
  end

  FileUtils.mkdir_p File.join(skeleton, "templates")
  FileUtils.cp "vendor/templates/skeleton_index.html", File.join(skeleton, "templates", "index.html")
  
end

task :fetch_jasmine do
  jasmine = "vendor/jasmine"
  FileUtils.rm_rf jasmine
  FileUtils.mkdir jasmine
  Dir.chdir jasmine do
    `wget https://github.com/downloads/pivotal/jasmine/jasmine-standalone-1.2.0.zip`
    `unzip jasmine-standalone-1.2.0.zip`
    `echo 1.2.0 >> VERSION`
  end

end

task :fetch_js do
  Rake::Task[:fetch_knockout].invoke
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
    `wget --no-check-certificate http://cloud.github.com/downloads/SteveSanderson/knockout/knockout-2.0.0.js`
    `echo 2.0.0 >> VERSION`
  end
end

task :fetch_jquery do
  FileUtils.rm_rf("vendor/jquery")
  FileUtils.mkdir("vendor/jquery")
  Dir.chdir("vendor/jquery") do
    `wget http://code.jquery.com/jquery-1.9.1.min.js`
    `echo 1.9.1 >> VERSION`
  end
end


task :fetch_jqm do
  src = "http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.zip"
  dir = "vendor/jquerymobile"
  FileUtils.rm_rf dir
  FileUtils.mkdir_p dir
  FileUtils.mkdir_p File.join(dir, "templates")
  Dir.chdir dir do
    `wget #{src} -O jqm.zip`
    `unzip -j jqm.zip`
    `echo 1.2 >> VERSION`
  end
  FileUtils.cp "vendor/templates/jquerymobile_index.html", File.join(dir, "templates", "index.html")
  

end

task :fetch_backbone do
  FileUtils.rm_rf("vendor/backbone")
  FileUtils.mkdir_p("vendor/backbone")
  Dir.chdir("vendor/backbone") do
    `wget http://documentcloud.github.com/underscore/underscore-min.js`
    `wget http://documentcloud.github.com/backbone/backbone-min.js`
    `wget --no-check-certificate https://raw.github.com/douglascrockford/JSON-js/master/json2.js`
    `echo 0.9.2 >> VERSION`

  end

  
end
