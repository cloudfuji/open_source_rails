Fabricator(:author) do
  name Forgery::LoremIpsum.words(2)
  url "http://"+Forgery::Internet.domain_name
  project { Fabricate(:project).id }
end
