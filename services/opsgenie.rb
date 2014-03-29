# encoding: utf-8

# Initial implementation by Mike Heffner:

class Service::OpsGenie < Service

  def receive_logs
    raise_config_error 'Missing OpsGenie api key' if settings[:api_key].to_s.empty?
    
    api_key = settings[:api_key].
    

    resp = http_post "https://api.opsgenie.com/v1/json/papertrail?apiKey=#{api_key}", payload.to_json
      unless resp.success?
        error_body = Yajl::Parser.parse(resp.body) rescue nil
        
        if error_body
          raise_config_error("Unable to send: #{error_body['errors'].join(", ")}")
        else
          puts "opsgenie: #{payload[:saved_search][:id]}: #{resp.status}: #{resp.body}"
        end
      end
    end
  end
end
