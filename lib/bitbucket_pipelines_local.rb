require "bitbucket_pipelines_local/all"

module BitbucketPipelinesLocal
  def self.run(config_file)
    config = Config.get_config config_file

    if config["definitions"]["services"]
      config["definitions"]["services"].each do |service|
        Docker.pull_image(service[1]["image"])
      end
    end

  end

end
