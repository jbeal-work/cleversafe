module Cleversafe
  class HttpClient
    DEFAULTS = { :timeout => nil, :open_timeout => nil }

    attr_reader :url

    def initialize(url, options = {})
      @url = url
      @defaults = DEFAULTS.merge(options)
    end

    def url_for(*path)
      File.join(url, *path)
    end

    def head(path, options = {})
      request :head, path, options
    end

    def get(path, options = {})
      request :get, path, options
    end

    def post(path, payload, options = {})
      request :post, path, options.merge(:payload => payload)
    end

    def put(path, payload, options = {})
      request :put, path, options.merge(:payload => payload)
    end

    def delete(path, options = {})
      request :delete, path, options
    end

    private
      def request(method, path, options = {})
        options = @defaults.merge(options).merge(:method => method, :url => url_for(path))
        RestClient::Request.execute(options)
      end
  end
end
