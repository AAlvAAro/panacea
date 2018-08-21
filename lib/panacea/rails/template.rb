# frozen_string_literal: true

require "yaml"

ROOT_DIR = File.expand_path("../../../", __dir__)

# Add lib/panacea/rails dir to the source paths so
# Thor can access our templates files.
source_paths.unshift(ROOT_DIR)

# Read .panacea configurations file
configurations_file = File.join(ROOT_DIR, ".panacea")
@panacea = YAML.safe_load(File.read(configurations_file))

# Starting Thor commands:

# Copy Gemfile
template "templates/Gemfile.tt", "Gemfile", force: true

# Create Test Support dir
empty_directory "test/support"

# Configure simplecov
template "templates/simplecov.tt", "test/support/simplecov.rb"

# Overwrite Test Helper
template "templates/test_helper.tt", "test/test_helper.rb", force: true

# Run all initializers
after_bundle do
  run "spring stop"

  # Add money-rails initiliazer if needed
  rails_command "generate money_rails:initializer" if @panacea.dig("money_rails")
end
