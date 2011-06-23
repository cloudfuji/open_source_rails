Fabricator(:user) do
  username Forgery::Internet.user_name
end
