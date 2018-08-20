# frozen_string_literal: true

require_relative "arguments_parser"
require_relative "customizer"

module Panacea
  module Rails
    module Runner
      extend ArgumentsParser

      class << self
        def call(app_name, rails_args)
          panacea_template = __dir__ + "/template.rb"
          parsed_arguments = parse_arguments(rails_args)
          parsed_arguments << " --template=#{panacea_template}"

          Customizer.start

          puts ">>> Generating Boosted Rails app"
          puts `rails new #{app_name} #{parsed_arguments}`
        end
      end
    end
  end
end
