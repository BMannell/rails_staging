require "rails/generators"
require "rails/generators/active_record"
module RailsStaging
  class InstallGenerator < Rails::Generators::Base

    include ::Rails::Generators::Migration

    source_root File.expand_path("../", __FILE__)

    def create_migration_file
      migration_dir = File.expand_path("db/migrate")
      if self.class.migration_exists?(migration_dir, "create_rails_stages")
        ::Kernel.warn "Migration already exists: create_rails_stages"
      else
        migration_template "create_rails_stages.rb", "db/migrate/create_rails_stages.rb"
      end
    end

    def self.next_migration_number(dirname)
      ::ActiveRecord::Generators::Base.next_migration_number(dirname)
    end

  end
end
