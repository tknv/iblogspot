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
  
  def button_link_to(name, options, html_options = nil)
    html_options[:class] = "button"
    link_to(name, options, html_options)
  end
    
  def iui_toolbar(initial_caption, search_url = nil)
    back_button = button_link_to("", "#", :id => "backButton")
    header = content_tag(:h1, initial_caption, :id => "pageTile")
    search_link = if search_url 
                  then button_link_to("Search", search_url, :id => "searchButton")
                  else ""
                  end 
    content = [back_button, header, search_link].join("\n")
    content_tag(:div, content, :class => "toolbar")
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
	load 'lib/labels'
end

#Error handling
not_found do
    '404 This is nowhere to be found'
end