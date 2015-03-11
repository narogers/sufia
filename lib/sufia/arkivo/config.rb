module Sufia
  module Arkivo
    def self.config
      @config ||= YAML.load(File.read(File.join(Rails.root, 'config', 'zotero.yml')))['zotero']
    end
  end
end
