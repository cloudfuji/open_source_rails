Fabricator(:project) do
  title { Forgery::LoremIpsum.title }
  short_desc { Forgery::LoremIpsum.sentence }
  about { Forgery::LoremIpsum.paragraph }
  homepage_url { Forgery::Internet.domain_name }
  source_url { Forgery::Internet.domain_name }
  author
end
