require 'tty-command'

module BitbucketPipelinesLocal
  class Docker
    def self.cmd
      TTY::Command.new(printer: :quiet)
    end

    def self.config
      Config.get_config
    end

    def self.pull_image(image)
      if cmd.run!("docker pull #{image}").failure?
        puts "Não foi possivel realizar o pull da imagem #{image}"
      end
    end

    def up_containers

    end

    def stop_containers

    end

    def remove_containers

    end
  end
end
