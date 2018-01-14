require 'auth/models'

ActiveSupport.on_load(:active_record) do
  extend Auth::Models
end
