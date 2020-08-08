FactoryBot.define do
  factory :user, aliases: [:owner] do
    first_name {"Aaron"}
    last_name {"Sumner"}
    sequence(:email) { |n| "tester#{n}@example.com"}
    password {"dottle-nouveau-pavilion-tights-furze"}

    # プロジェクト付きのユーザー
    trait :with_projects do
      after(:create) { |owner| create_list(:project, 5, owner: owner)}
    end
  end
end
