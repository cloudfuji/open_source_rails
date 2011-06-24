Fabricator(:project) do
  title { Forgery::LoremIpsum.title }
  short_desc { Forgery::LoremIpsum.sentence }
  about { Forgery::LoremIpsum.paragraph }
  homepage_url { Forgery::Internet.domain_name }
  source_url { "https://#{Forgery::Internet.domain_name}/somerepo.git" }
  authors!(:count=>2)
end

