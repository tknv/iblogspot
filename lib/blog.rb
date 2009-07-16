#! ruby -Ku

require 'lib/urlfetch'
require 'lib/id'
require 'rubygems'
require 'xmlsimple'
#require 'net/http'  # for denug

class Blog

  def contents
   feed = URLFetch.get("http://www.blogger.com/feeds/#{$blogID}/posts/default?max-results=5",:header => { 'Content-Type' => 'application/x-www-form-urlencoded'})
   XmlSimple.xml_in(feed.to_s)
  end

  def title
    contents['title'][0]['content']
  end
  
  def subtitle
    contents['subtitle'][0]['content']
  end
  
  def titles(i)
    contents['entry'][i]['title'][0]['content']
  end
  
  def content(i)
    contents['entry'][i]['content']['content']
  end
end
