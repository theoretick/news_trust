module Helpers
  module Request

    JSON_MIME_TYPE = "application/json; charset=UTF-8".freeze

    module_function

    def reply_with(mime_type, payload, opts = {})
      res.status = opts.fetch(:status, 200)

      case mime_type
      when :json
        res.headers["Content-Type"] = JSON_MIME_TYPE
        res.write JSON.dump(payload)
      else
        res.write(payload)
      end

      halt res.finish
    end

    def require_params(payload, *params)
      params.each do |param|
        next if payload[param]

        reply_with(
          :json,
          { message: "Missing required parameter: #{param}" },
          status: 422
        )
      end
    end
  end
end
