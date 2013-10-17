require 'erb'
require_relative 'params'
require_relative 'session'
require 'active_support/inflector'
#require 'json'

class ControllerBase
  attr_reader :params

  def initialize(req, res, route_params=nil)
    @req = req
    @res = res
    @params = Params.new(req, route_params)
    
    # @already_built_response
  end

  def session
    @session ||= Session.new(@req)
  end

  def already_rendered?
  end

  def redirect_to(url)
    @res.set_redirect(WEBrick::HTTPStatus::TemporaryRedirect, url)
    
    session.store_session(@res)
    # @already_built_response << 
  end

  def render_content(body, type)
    @res.body = body
    @res.content_type = type
    

    # @already_built_response ||= []
    # @already_built_response << [body, type]

    session.store_session(@res)

  end

  def render(template_name)
    controller_name = self.class.to_s.underscore#'my_controller'
    template = ERB.new(File.read("views/#{controller_name}/#{template_name}.html.erb"))
        
    render_content(template.result(binding), 'text/html')
  end

  def invoke_action(name)
    
    
  end
end
