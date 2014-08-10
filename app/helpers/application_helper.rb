module ApplicationHelper
	def page_title page_title
		content_for :title, page_title.to_s
	end
end
