#! ruby -Ku

require 'lib/urlfetch'
require 'lib/bumble'
require 'yaml'

	$blogID = '2736766923155041598'
	$userID = '13145006659291541295'
	$label_url = "http://www.blogger.com/feeds/#{$userID}/blogs/#{$blogID}?alt=json-in-script&callback=listLabels"

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
	
	def debug
		if LabelData.find(:blog_element_labels => 'ruby').nil?
			"nil"
		else
			"some"
		end
	end
	
	def debug1
		if LabelData.find(:blog_element_labels => 'ill').nil?
			"nil"
		else
			"some"
		end
	end
	
end