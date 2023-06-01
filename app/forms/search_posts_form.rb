class SearchPostsForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  
  attribute :title_or_body, :string
  
  def search
    scope = Post.distinct
    scope = scope.title_contain(title_or_body).or(scope.body_contain(title_or_body)) if title_or_body.present?
    scope
  end
end
