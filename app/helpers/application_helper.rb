module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'プロレスヌマラス'
    
    page_title.empty? ? base_title : page_title
  end
end
