class SearchPostsForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  
  attribute :title_or_body, :string
  attribute :tag_name, :string
  
  def search
    scope = Post.distinct
    scope = scope.title_contain(title_or_body).or(scope.body_contain(title_or_body)) if title_or_body.present?
    scope = scope.tag_name(tag_name) if tag_name.present?
    scope
  end
end