namespace :slugs do

  namespace :generate do 
  
    desc "generate slugs for all projects without slugs"
    task :all => :environment do
      @projects_without_slugs = Project.where(:slug=>nil)
      @projects_without_slugs.each do |p|
        p.update_attribute(:slug, p.title.parameterize)
      end
    end
    
    desc "generate slugs for approved projects without slugs"
    task :approved => :environment do
      @projects_without_slugs = Project.where(:slug=>nil,:approved=>true)
       @projects_without_slugs.each do |p|
        p.update_attribute(:slug, p.title.parameterize)        
      end
    end
  end

end

