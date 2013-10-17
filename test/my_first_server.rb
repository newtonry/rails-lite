require 'webrick'
require_relative '../lib/rails_lite/controller_base.rb'

server = WEBrick::HTTPServer.new :Port => 8080, :ContentType => 'text/text'


server.mount_proc '/' do |req, res|
  res.body = req.request_method
#  res.body = ControllerBase.new(req, res).session(box: 'test')
  
  #.redirect_to('http://www.google.com')
  
end

trap('INT') { server.shutdown }
server.start