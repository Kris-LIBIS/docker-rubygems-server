require 'graphlient'

module Auth
  # Module for using GitHub authorization.
  module GitHub

    URL = 'https://api.github.com/graphql'
    Cache = {}

    def self.github(access_token)
      Graphlient::Client.new(URL, headers: {'Authorization' => "Bearer #{access_token}"})
    end

    Query = <<~GQL
    query { 
      viewer { 
        organizations(first: 100) {
          nodes {
            name
          }
        }
      }
    }
    GQL
    
    def self.organizations(access_token)
      github(access_token).query(Query).data.viewer.organizations.nodes.map(&:name)
    end

    def self.in_organization?(access_token)
      organizations(access_token).any?(ENV['GITHUB_ORGANIZATION'])
    end

    def self.authorized?(access_token)
      in_organization?(access_token).tap do |allowed|
        Auth::Cache.add access_token if allowed
      end
    rescue Graphlient::Errors::Error
      false
    end
  end
end
