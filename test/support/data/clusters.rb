module Iom
  module Data

    def create_cluster(attributes = {})
      Cluster.create! attributes
    end

  end
end