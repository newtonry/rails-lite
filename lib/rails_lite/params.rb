require 'uri'

class Params
  def initialize(req, route_params)
    # @req = req
    
    @params = {}
    parse_body(req.body) unless req.body.nil?
    parse_www_encoded_form(req.query_string) unless req.query_string.nil?
  #  @paramse parse_www_encoded_form(req.query_string)
  end

  def [](key)
  end

  def to_s
    @params.to_json.to_s
  end

  private
  def parse_www_encoded_form(www_encoded_form)
    # URI.decode_www_form
    decoded =URI.decode_www_form(www_encoded_form)
    
    decoded.each do |pair|
      @params[pair.first] = pair.last
    end
  end

  def parse_body body
    #should make this a loop to look at deeper keys
   URI.decode_www_form(body).each do |full_key, value|
     vals = full_key.split(/\]\[|\[|\]/)     
     @params[vals[0]] ||= {}
     @params[vals[0]][vals[1]] ||= {}
     @params[vals[0]][vals[1]] = value

   end
#       
#      # @params[parse_key(first_layer.first)] =      
# 
#   #    
#   # @params=URI.decode_www_form(body)

    
      
  end

  # def parse_key(key)
  #   
  #   # chain_of_keys = key.split(/\]\[|\[|\]/)
  #   # {chain_of_keys.first => { chain_of_keys.last => nil} }  
  # end
end
