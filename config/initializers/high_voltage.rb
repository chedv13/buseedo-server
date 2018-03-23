HighVoltage.configure do |config|
  config.content_path = 'docs/'
end

HighVoltage::StaticPage.module_eval do
  def current_page
    page = page_finder.find
    return page if template_exists? page
    "#{page}/index"
  end
end