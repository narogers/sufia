module Sufia
  class ArkivoConstraint
    def self.matches?(request)
      # Add your own logic here to authorize trusted connections to the API
      return false
    end
  end
end
