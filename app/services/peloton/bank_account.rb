module Peloton
  class BankAccount

    def add_bank_account(options = {})
      request :add_bank_account, options
    end

    private
    def request(method, options = {})
      # Camelize the hash keys for the request.
      options = options.inject({}) do |opts, (k,v)|
        opts[k.to_s.camelize] = v
        opts
      end

      # Invoke the method; include a request wrapper.
      response = client.call(method,
                             message: { "#{method.to_s.camelize(:lower)}Request" => options })
      response
    rescue Savon::SOAPFault, Savon::HTTPError => error
      Rails.logger.error error.to_s
      raise error
    end

    def client
      @client ||= Savon.client do
        wsdl(Peloton.wsdl)
      end
    end
  end
end
