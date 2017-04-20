require 'bitbucket_pipelines_local/all'

module BitbucketPipelinesLocal
  class Docker
    attr_accessor :image
    attr_accessor :inspect
    attr_accessor :verbose
    attr_accessor :dotenv
    def cmd
      unless verbose
        TTY::Command.new(printer: :null)
      else
        TTY::Command.new(printer: :pretty)
      end
    end

    def config
      Config.get_config
    end

    def pull_image
      spinner = TTY::Spinner.new("[:spinner] Check if #{image} exists")
      spinner.auto_spin
      version = image.split(":")[1]
      img     = image.split(":")[0]

      command = "docker images | grep #{img}"
      command += "| grep #{version}" if version
      result = cmd.run!(command)


      if result.out == ""
        spinner.error("(Image #{image} not exists.)")
        run_command "Pulling image #{image}", "docker pull #{image}"
      else
        spinner.success("(Image #{image} already exists, skipping pull)")
      end

    end


    def up
      spinner = TTY::Spinner.new("[:spinner] Starting containers")
      spinner.auto_spin
      pid = spawn("docker run -i --rm -v #{Dir.pwd()}:/app -w /app --entrypoint=/bin/bash --env-file=#{dotenv} --name=bpl_test #{image}")
      spinner.success('(Finished)')
    end

    def run_command(message, command)
      spinner = TTY::Spinner.new("[:spinner] #{message}")
      spinner.auto_spin
      result  = cmd.run!(command)
      if result.failure?
        spinner.error("(#{result})")
        return false
      else
        spinner.success('(Finished)')
        return true
      end
    end

    def exec(message, command)
      command = "docker exec -i bpl_test #{command}"

      spinner = TTY::Spinner.new("[:spinner] #{message}")
      spinner.auto_spin
      result  = cmd.run(command)
      if result.failure?
        spinner.error("(#{result})")
        return false
      else
        spinner.success('(Finished)')
        return true
      end
    end

  end
end
