class SearchQuestionsForm
  include ActiveModel::Model
  include ActiveModel::Attributes
    
  attribute :title_or_sentence, :string
    
  def search
    scope = Question.distinct
    scope = scope.title_contain(title_or_sentence).or(scope.sentence_contain(title_or_sentence)) if title_or_sentence.present?
    scope
  end
end