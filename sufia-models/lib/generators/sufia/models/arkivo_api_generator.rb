require_relative 'abstract_migration_generator'

class Sufia::Models::ArkivoApiGenerator < Sufia::Models::AbstractMigrationGenerator
  source_root File.expand_path('../templates', __FILE__)

  desc """
This generator sets up Arkivo API integration for your application:
       """

  def banner
    say_status("info", "ADDING ARKIVO API INTEGRATION", :blue)
  end

  # Copy over the default routing constraint for overriding
  def copy_routing_constraint
    copy_file 'config/arkivo_constraint.rb', 'config/initializers/arkivo_constraint.rb'
  end

  # Setup the database migration
  def copy_migration
    better_migration_template 'add_arkivo_token_to_users.rb'
  end
end
