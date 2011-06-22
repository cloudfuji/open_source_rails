require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

User.blueprint do
  email { Forgery::Internet.email_address }
  password { Forgery::Basic.password }
  password_confirmation { "#{object.password}" }
end

Project.blueprint do
  title { "Project #{sn} "+ Forgery::LoremIpsum.title }
  short_desc { Forgery::LoremIpsum.sentence }
  about { Forgery::LoremIpsum.sentences(3) }
  license { Forgery::LoremIpsum.sentence }
  homepage_url { "http://" + Forgery::Internet.domain_name }
  source_url { "#{object.homepage_url}" }
  authors(2)
end

Author.blueprint do 
  name { Forgery::Internet.user_name }
  url { "http://" + Forgery::Internet.domain_name }
  project
end
