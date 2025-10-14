FactoryBot.define do
  factory :task do
    title { "MyString" }
    description { "MyText" }
    status { 1 }
    priority { 1 }
    due_date { "2025-10-14" }
    campaign { nil }
  end
end
