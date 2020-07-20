ActiveAdmin.register Patient do
  actions :index, :show

  index do
    column :id
    column :email
    column :username
    column :full_name
    column :sex
    column :dob
    actions
  end
end
