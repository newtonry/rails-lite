require 'json'
require 'webrick'

class Session
  def initialize(req)
    @cookie = req.cookies.select do |cookie|
      cookie.name == '_rails_lite_app'
    end.first
    
    if @cookie.nil?
      @cookie_values = {}
    else
      @cookie_values = JSON.parse(@cookie.value)
    end
  end

  def [](key)
    @cookie_values[key]
  end

  def []=(key, val)
    @cookie_values[key] = val
  end

  def store_session(res)
    res.cookies << WEBrick::Cookie.new('_rails_lite_app', @cookie_values.to_json)
  end
end
