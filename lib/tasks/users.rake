namespace :iom do

  namespace :users do

    desc 'Updates name and role in existing users'
    task :update_name_and_role => :environment do
      User.where('organization_id IS NOT NULL').find_each do |user|
        user.name = "Manager from #{user.organization.name}"
        user.role = 'Manager'
        user.save!
      end
    end
  end

end
