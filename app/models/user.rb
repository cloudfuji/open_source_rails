class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :bushido_authenticatable,
         :rememberable, :trackable

  has_many :bookmarks
  has_many :projects

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :ido_id, :password, :password_confirmation, :remember_me

  def bushido_extra_attributes(extra_attributes)
    extra_attributes.each do |name, value|
      case name.to_sym
      when :email
        self.username = value
        # when :first_name
        #   self.first_name = value
        # when :locale
        #   self.locale = value
      end
    end
  end

end
