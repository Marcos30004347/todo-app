require 'logger'
require 'todo-string'

class Logger
  def initialize(sync = true)
    fd = IO.sysopen("/proc/1/fd/1", "w")
    @@logger = IO.new(fd, "w")
    @@logger.sync = sync
  end

  def self.puts(message)
    @@logger.puts ("[#{Time.now.utc.iso8601}]: #{message}")
  end

  def self.debug(message)
    @@logger.puts ("DEBUG [#{Time.now.utc.iso8601}]: #{message}").green
  end

  def self.warn(message)
    @@logger.puts ("WARNING [#{Time.now.utc.iso8601}]: #{message}").yellow
  end

  def self.error(message)
    @@logger.puts ("ERROR [#{Time.now.utc.iso8601}]: #{message}").red
  end
end
