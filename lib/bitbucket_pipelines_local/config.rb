module BitbucketPipelinesLocal

  class Config

    def self.get_config(config_file = nil)
      config_file = File.join(Dir.pwd(),'bitbucket-pipelines.yml') unless config_file
      begin
        config = YAML::load(File.open(config_file))

      rescue Exception => e
        puts "Invalid yml file"
        exit
      end
    end

  end

end
