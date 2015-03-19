require 'oauth'

module API
  class ZoteroController < ApplicationController
    before_filter :validate_token, only: :callback

    def initiate
      client = ::OAuth::Consumer.new(Sufia::Arkivo.config['client_key'], Sufia::Arkivo.config['client_secret'], options)
      request_token = client.get_request_token(oauth_callback: callback_url)
      session[:request_token] = request_token
      current_user.zotero_token = request_token
      current_user.save
      redirect_to request_token.authorize_url({ identity: '1', oauth_callback: callback_url })
    end

    def callback
      request_token = @user.zotero_token
      access_token = request_token.get_access_token
      # parse userID and API key out of token and store in user instance
      @user.zotero_userid = access_token.params[:userID]
      @user.request_token = nil
      @user.save
    end

    private

      def validate_token
        provided_token = params[:oauth_token]
        return render plain: "oauth_token param not provided", status: :bad_request if provided_token.blank?
        @user = User.find_by_zotero_token(provided_token)
        return render plain: "no matching token found for #{provided_token}", status: :not_found if @user.blank?
      end

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
