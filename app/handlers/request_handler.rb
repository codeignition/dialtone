require 'reel'
class RequestHandler
  public
  def initialize(host,port)
    Reel::Server.supervise(host,port) do |connection|
      connection.each_request do |request|
        params_hash={}
        parameters  = CGI.unescape request.query_string.to_s
        params_hash = parameters.split('&').inject({}) do |h, q|
          k, v = q.split('=')
          h.merge({ k.to_sym => v })
        end
        conference = Conference.new params_hash[:participants]
        conference.start!

        request.respond :ok, "200 OK"
      end
    end
  end
end
