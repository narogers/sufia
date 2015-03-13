module Sufia
  class ZoteroCallbackConstraint
    def self.matches?(request)
      # Add your own logic here to authorize connections from Zotero OAuth
      return false
    end
  end
end
