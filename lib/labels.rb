#! ruby -Ku

require 'lib/urlfetch'
require 'lib/bumble'
require 'lib/id'
require 'yaml'

class Labels
	class LabelData
		include Bumble
		ds :blog_element_labels
	end
	
	def update
		response = URLFetch.get($label_url)
		result = response.to_s
		result_headless = result.gsub("listLabels(",'')
		pure_result = result_headless.gsub(");",'')
		json_to_yaml = YAML::load(pure_result)['entry']['category']

			json_to_yaml.each do |label|
			@label = LabelData.find(:blog_element_labels => label['term'])
			@label = LabelData.create(:blog_element_labels => label['term']) if @label.nil?
			end
	end
	
end