namespace :assets do
  # Prepend the assets:precompile_prepare task to assets:precompile.
  task :precompile => :precompile_prepare

  # This task will be called before assets:precompile to optimize the
  # compilation, i.e. to prevent any DB calls.
  task 'precompile_prepare' do
    # Without this assets:precompile will call itself again with this var set.
    # This basically speeds things up.
    ENV['RAILS_GROUPS'] = 'assets'

    # Devise uses this flag to prevent connecting to the db.
    ENV['RAILS_ASSETS_PRECOMPILE'] = 'true'

    # Prevent loading observers which will load the models which in turn may hit
    # the DB.
    module ActiveModel::Observing::ClassMethods
      def instantiate_observers; end
    end

    # Prevent route drawing because certain gems might get called which will hit
    # the DB.
    class ActionDispatch::Routing::RouteSet
      def draw; end
    end
  end
end
