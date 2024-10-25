class Tail
  def initialize(arguments)
    @arguments = arguments
    @options = { size: 10 }
    setup
  end

  def setup
    if File.exist?(@arguments[-1])
      @options[:file] = @arguments[-1]
    else
      raise "#{@arguments[-1]}: No such file or directory"
    end

    parse_arguments
  rescue => e
    puts "tail: #{e}"
    exit 1
  end

  def run
    output = File.read(@options[:file]).lines.last(@options[:size]).join
    puts output

    output = run_with_follow(output) if @options[:follow]
    output
  end

  private


  def parse_arguments
    index = 0

    @arguments.each_with_index do |arg, index|
      parse_size_argument(index)
      parse_follow_argument(index)
    end
  end

  def parse_size_argument(index)
    return if @arguments[index] != '-n'

    unless @arguments[index + 1] && @arguments[index + 1] =~ /^\d+$/
      raise "illegal offset -- #{@arguments[index + 1]}: Invalid argument"
    end

    @options[:size] = @arguments[index + 1].to_i
    index += 1
  end

  def parse_follow_argument(index)
    return if @arguments[index] != '-f'

    @options[:follow] = true
  end

  def run_with_follow(output)
    trap('INT') do
      return output
    end

    File.open(@options[:file]) do |file|
      file.seek(0, IO::SEEK_END)

      loop do
        if line = file.gets
          output += line
          puts line
        else
          sleep 0.1
          file.seek(0, IO::SEEK_CUR)
        end
      end
    end
  end
end

if __FILE__ == $0
  Tail.new(ARGV).run && nil
end
