module Sufia
  class ZoteroConstraint
    def self.matches?(request)
      # Add your own logic here to authorize connections from the edit profile page
      return false
    end
  end
end
