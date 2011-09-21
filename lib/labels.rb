#! ruby -Ku

require 'lib/urlfetch'
#require 'lib/bumble'
require 'curl'
require 'lib/id'
require 'yaml'

class Labels
	class LabelData
		ds :blog_element_labels
	end
	
	def update
#		response = Curl::Easy.perform($label_url).body_str
		result = Curl::Easy.perform($label_url).body_str
#		result = response.to_s
		result_headless = result.gsub("listLabels(",'')
		pure_result = result_headless.gsub(");",'')
		json_to_yaml = YAML::load(pure_result)['entry']['category']

			json_to_yaml.each do |label|
			@label = LabelData.find(:blog_element_labels => label['term'])
			@label = LabelData.create(:blog_element_labels => label['term']) if @label.nil?
			end
	end
	
end
