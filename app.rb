#! ruby -Ku

require 'rubygems'
require 'sinatra'
require 'lib/blog'
require 'lib/labels'

  
error do
	e = request.env['sinatra.error']
	puts e.to_s
	puts e.backtrace.join("\n")
	"Application error"
end

helpers do
  
  def is_iphone_request?
    request.user_agent =~ /(Mobile\/.+Safari)/
  end
  
end

before do
    if is_iphone_request?
      then @request_from = "iphone"
      else @request_from = "other"
    end
end

get '/' do
  @iblog = Blog.new
  if @request_from == "iphone"
    then haml :iphone
    else haml :other
  end
end

get '/cron/collect_label' do
	@labels = Labels.new
	@labels.update
	"Labels Updated"
end

#Error handling
not_found do
    '404 This is nowhere to be found'
end