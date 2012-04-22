task :bootstrap => :environment do
  user = User.create(:username => "bootstrap@cloudfuji.com")
  cat = ProjectCategory.create(:name => "bootstrap")
  20.times do |i|
    p = Project.create(:user => user,
                       :user_id => user.id,
                       :approved => true,
                       :project_category => cat,
                       :about => "lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum ",
                       :title => "project#{i}",
                       :short_desc => "lol cool project bro",
                       :homepage_url => "http://cloudfuji.com",
                       :source_url => "https://kevzettler@github.com/Bushido/bushido.git",
                       )
  end

  fp = FeaturedProject.create(:project => Project.first)
end
