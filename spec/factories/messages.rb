FactoryBot.define do
  factory :message do
    body { "MyText" }
    image { "MyString" }
    user { nil }
    chat_group { nil }
  end
end
