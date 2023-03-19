class RegisterQuizForm
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations
  
    attribute :question_sentence, :string
    attribute :correct_choice, :string
    attribute :incorrect_choice_1, :string
    attribute :incorrect_choice_2, :string
    attribute :incorrect_choice_3, :string
  
    validates :question_sentence, presence: true, length: { maximum: 255 }
    validates :correct_choice, presence: true, length: { maximum: 255 }
    validates :incorrect_choice_1, presence: true, length: { maximum: 255 }
    validates :incorrect_choice_2, length: { maximum: 255 }
    validates :incorrect_choice_3, length: { maximum: 255 }
  
    def save
      return false unless valid?
      question = Question.new(sentence: question_sentence)
      question.save # 問題文の登録
  
      choice = question.choices.build(body: correct_choice, answer: true)
      choice.save # 正解選択肢の保存
  
      question.choices.create(body: incorrect_choice_1, answer: false)
      question.choices.create(body: incorrect_choice_2, answer: false)
      question.choices.create(body: incorrect_choice_3, answer: false)
      # 不正解選択肢の登録
    end
end