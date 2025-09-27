# Set up gems from vendor_bundle.tgz without Bundler
require 'tmpdir'

vendor_bundle_path = File.expand_path("../vendor_bundle.tgz", __dir__)

if File.exist?(vendor_bundle_path)
  # Create temporary directory for extracting the bundle
  temp_dir = Dir.mktmpdir("vendor_bundle_")

  # Extract vendor_bundle.tgz to temporary directory
  system("tar -xzf #{vendor_bundle_path} -C #{temp_dir}")

  # Set up gem paths from extracted bundle
  gem_path = File.join(temp_dir, "vendor/bundle/ruby/3.4.0/gems")
  if File.directory?(gem_path)
    Dir.glob("#{gem_path}/*").sort.each do |gem_dir|
      lib_path = "#{gem_dir}/lib"
      $LOAD_PATH.unshift(lib_path) if File.directory?(lib_path)
    end
  end

  # Register cleanup to remove temporary directory at exit
  at_exit { FileUtils.rm_rf(temp_dir) if Dir.exist?(temp_dir) }
else
  # Fallback to vendor/bundle directory if tgz doesn't exist
  gem_path = File.expand_path("../vendor/bundle/ruby/3.4.0/gems", __dir__)
  if File.directory?(gem_path)
    Dir.glob("#{gem_path}/*").sort.each do |gem_dir|
      lib_path = "#{gem_dir}/lib"
      $LOAD_PATH.unshift(lib_path) if File.directory?(lib_path)
    end
  end
end
