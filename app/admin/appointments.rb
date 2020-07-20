ActiveAdmin.register Appointment do
  actions :index, :show

  index do
    column :id
    column :doctor
    column :patient
    column :speciality
    column :title
    column :start_time
    column :end_time
    column :status
    actions
  end
end
