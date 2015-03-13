require_relative 'abstract_migration_generator'

class Sufia::Models::ArkivoApiGenerator < Sufia::Models::AbstractMigrationGenerator
  source_root File.expand_path('../templates', __FILE__)

  desc """
This generator sets up Zotero/Arkivo API integration for your application:
       """

  def banner
    say_status("info", "ADDING ZOTERO/ARKIVO API INTEGRATION", :blue)
  end

  # Copy the default routing constraint for overriding
  def copy_routing_constraints
    copy_file 'config/arkivo_constraint.rb', 'config/initializers/arkivo_constraint.rb'
    copy_file 'config/zotero_constraint.rb', 'config/initializers/zotero_constraint.rb'
    copy_file 'config/zotero_callback_constraint.rb', 'config/initializers/zotero_callback_constraint.rb'
  end

  # Copy the database migration
  def copy_migration
    better_migration_template 'add_arkivo_to_users.rb'
  end

  # Copy the config file for Zotero client keys
  def copy_config_file
    copy_file 'config/zotero.yml', 'config/zotero.yml'
  end
end
