module RequestHelpers
    def response_json
      JSON.parse(response.body)
    end
    def response_html
        response.body
      end
  end
  