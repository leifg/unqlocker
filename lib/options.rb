require "fileutils"

Options = Struct.new(:input, :output, :password) do
  def validate!
    validate_input_exists!
    validate_output_not_sub_directory!
  end

  def abs_input
    File.expand_path(input)
  end

  def abs_output
    File.expand_path(output)
  end

  private

  def validate_input_exists!
    raise ArgumentError, "Input path #{input} does not exist" unless File.exist?(abs_input)
  end

  def validate_output_not_sub_directory!
    raise ArgumentError, "Output path cannot be a subdirectory of input path" if abs_output.start_with?(abs_input)
  end
end
