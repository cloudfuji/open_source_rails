Fabricator(:user) do
  email Forgery::Internet.email_address
  password Forgery::Basic.password
  after_build do |user|
    user.password_confirmation = user.password
  end
end
