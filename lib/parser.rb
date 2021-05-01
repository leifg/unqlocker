require "optparse"
require_relative "options"

class Parser
  def self.parse(options)
    args = Options.new

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: unqlocker.rb [options]"

      opts.on("-iINPUT", "--input=INPUT", "Input Directory where encrypted files are") do |input|
        args.input = input
      end

      opts.on("-oOUTPUT", "--output=OUTPUT", "Output Directory where decrypted files will be copied to") do |output|
        args.output = output
      end

      opts.on("-pPASSWORD", "--password=PASSWIRD", "Password to decrypt files") do |password|
        args.password = password
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    opt_parser.parse!(options)

    return args
  end
end
