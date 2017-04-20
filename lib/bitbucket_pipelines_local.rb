require "bitbucket_pipelines_local/all"
require 'git'

module BitbucketPipelinesLocal
  def self.run(config_file, dotenv, verbose)

    configuration = Config.new
    docker = Docker.new

    config = configuration.get

    branch = "master"
    git = Git.open(Dir.pwd())
    git.branches.each do | b |
      branch = b.name if b.current
    end

    docker.image = config["image"]
    docker.inspect = true
    docker.verbose = verbose

    docker.pull_image

    dotenv = File.join(Dir.pwd(),"test.env") unless dotenv

    docker.dotenv = dotenv

    docker.up
    sleep 5
    pipeline = "default"
    config['pipelines']['branches'].each do |reg|
      result = Globber.new(reg[0]) =~ branch
      pipeline = reg[0] if result
    end

    config['pipelines']['branches'][pipeline][0]['step']['script'].each do | script |
      docker.exec "#{script}", "#{script}"
    end

  end

end
