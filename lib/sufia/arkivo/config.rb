module Sufia
  module Arkivo
    def self.config
      @config ||= YAML.load(ERB.new(IO.read(File.join(Rails.root, 'config', 'zotero.yml'))).result)['zotero']
    end
  end
end
