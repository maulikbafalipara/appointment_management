ActiveAdmin.register Doctor do
  actions :index, :show

  index do
    column :id
    column :email
    column :speciality
    column :full_name
    column :clinic_name
    column :phone
    column :start_time
    column :end_time
    actions
  end
end
