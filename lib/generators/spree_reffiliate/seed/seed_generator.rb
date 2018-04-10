module SpreeReffiliate
  module Generators
    class SeedGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      def run_db_seeds
        seed_file = File.join(File.expand_path("../../../../../db", __FILE__), "seed.rb")
        load(seed_file) if File.exist?(seed_file)
      end
    end
  end
end
