# Set up gems from vendor/bundle without Bundler
gem_path = File.expand_path("../vendor/bundle/ruby/3.4.0/gems", __dir__)
Dir.glob("#{gem_path}/*").sort.each do |gem_dir|
  lib_path = "#{gem_dir}/lib"
  $LOAD_PATH.unshift(lib_path) if File.directory?(lib_path)
end
