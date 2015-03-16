require 'oauth'

module API
  class ZoteroController < ApplicationController

    def initiate
      client = ::OAuth::Consumer.new(Sufia::Arkivo.config['client_key'], Sufia::Arkivo.config['client_secret'], options)
      request_token = client.get_request_token(oauth_callback: callback_url)
      session[:request_token] = request_token
      current_user.zotero_request_token = request_token
      current_user.save
      redirect_to request_token.authorize_url(oauth_callback: callback_url)
    end

    def callback
      request_token = current_user.zotero_request_token
      # TODO: check that given token matches what's stored
      #params['oauth_token'] == request_token
      access_token = request_token.get_access_token
      # parse userID and API key out of token and store in user instance
      current_user.zotero_userid = access_token['userID']
      current_user.zotero_access_token = access_token['oauth_token_secret']
    end

    private

      def callback_url
        if Rails.env.production?
          # Zotero should hit the callback URL with the access token
          "#{request.base_url}/api/zotero/callback"
        else
          # Zotero can't hit the callback URL, so continue manually
          'oob'
        end
      end

      def options
        {
          site: 'https://www.zotero.org',
          scheme: :query_string,
          http_method: :get,
          request_token_path: '/oauth/request',
          access_token_path: '/oauth/access',
          authorize_path: '/oauth/authorize'
        }
      end
  end
end
