require 'yaml'
module BitbucketPipelinesLocal

  class Config

    def get(config_file = nil)
      config_file = File.join(Dir.pwd(),'bitbucket-pipelines.yml') unless config_file
      begin
        config = YAML::load(File.open(config_file))

      rescue Exception => e
         return e
      end
    end

  end

end
