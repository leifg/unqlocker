require "fileutils"
require "seven_zip_ruby"

class Decryptor
  attr_reader :abs_input, :abs_output, :password

  IGNORED_FILES = [
    "!!!READ_ME.txt"
  ]

  ENC_EXTENSION = "7z"

  def initialize(abs_input, abs_output, password)
    @abs_input = abs_input
    @abs_output = abs_output
    @password = password
  end

  def run
    Dir["#{@abs_input}/**/*"].each{dispatch(_1)}
  end

  def dispatch(file)
    output_file = input_to_output(file)

    if IGNORED_FILES.include?(File.basename(file))
      puts("Ignoring #{file}")
    elsif File.directory?(file)
      puts "Creating Directory #{output_file}"
      FileUtils.mkdir_p(output_file)
    elsif File.extname(file) != ".#{ENC_EXTENSION}"
      safe_copy(file, output_file)
    elsif
      safe_decrypt(file, output_file)
    end
  end

  private

  def input_to_output(file)
    file.gsub(abs_input, abs_output)
  end

  def safe_copy(src, dest)
    if File.exist?(dest)
      puts "Destination file #{dest.inspect} already exists"
    else
      FileUtils.cp(src, dest)
    end
  end

  def safe_decrypt(src, dest)
    output_file_basename = File.basename(dest, ".7z")
    output_path = File.dirname(dest)
    output_file_name = output_path + "/" + output_file_basename

    if File.exist?(output_file_name)
      puts "Destination file #{output_file_name.inspect} already exists"
    else
      puts "Decrypting #{src.inspect} to #{output_file_name}"

      archive_filename = inner_file_name(src)
      filename_changed = archive_filename != output_file_basename

      res = File.open(src) do |f|
        res = SevenZipRuby::Reader.extract_all(f, output_path, password: password)
      end

      # filename encoding might be corrupted during encryption
      if filename_changed
        FileUtils.mv("#{output_path}/#{archive_filename}", "#{output_path}/#{output_file_basename}")
      end
    end
  end

  def inner_file_name(archive)
    content = nil

    File.open(archive) do |f|
      SevenZipRuby::Reader.open(f, password: "nsk2axwSRlPtzjFWxjNlBgh48PCDYh1q"){|l| content = l.entries.first}
    end

    File.basename(content.path)
  end
end
