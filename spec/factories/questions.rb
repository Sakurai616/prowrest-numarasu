FactoryBot.define do
  factory :question do
    title { "MyString" }
    image { "MyString" }
    url { "MyString" }
    sentence { "MyText" }
    user { nil }
  end
end
