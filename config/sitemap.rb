# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://prowrest-numarasu.com"

SitemapGenerator::Sitemap.create do

  add questions_path, :priority => 0.7, :changefreq => 'daily'

  Question.find_each do |question|
    add question_path(question), :lastmod => question.updated_at
  end
end
