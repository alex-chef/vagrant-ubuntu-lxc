require 'yaml'

class MyVagrantGem < Vagrant.plugin("2")
  name "MyVagrantGem Plugin"
  @current_dir = nil
  @required_plugins = []

    def initialize(current_dir, required_plugins = %w( vagrant-omnibus vagrant-berkshelf vagrant-lxc ))
      # @required_plugins = %w( vagrant-omnibus vagrant-berkshelf vagrant-lxc )
      raise "Missing current_dir" if current_dir.nil? or current_dir.empty?
      raise "Error current_dir is not a directory" if !File.directory?(current_dir)
      @current_dir = current_dir
      raise "Missing required_plugins list" if required_plugins.nil? or required_plugins.empty?
      @required_plugins = required_plugins
    end 

    def check_plugins
        return
        @required_plugins.each do |plugin|
          if Vagrant.has_plugin? plugin
            puts "vagrant plugin #{plugin} already present"
          else
            system "vagrant plugin install #{plugin}"
          end
        end
    end

    def get_provider(default_config)
        provider = nil
        if !default_config.nil? and !default_config.empty?
          raise "Missing default config file #{default_config} " if !File.exist?(default_config)
          config = YAML.load_file default_config
          provider = config['provisioner']
          puts "Found #{provider}"
          if provider.nil? or provider.empty?
            provider = nil
          else
            provider = provider.to_sym
          end
        end
        if provider.nil?
          if ARGV[1] and \
             (ARGV[1].split('=')[0] == "--provider" or ARGV[2])
            provider = (ARGV[1].split('=')[1] || ARGV[2]).to_sym
          else
            provider = (ENV['VAGRANT_DEFAULT_PROVIDER'] || :virtualbox).to_sym
            puts "provider not found defaulting to #{provider}"
          end
        end
        return provider
    end
end
