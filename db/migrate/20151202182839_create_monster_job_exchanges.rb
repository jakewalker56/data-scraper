class CreateMonsterJobExchanges < ActiveRecord::Migration
  def change
  	add_column :job_exchanges, :type, :string
    add_column :job_exchanges, :primary_api_url, :string
    add_column :job_exchanges, :secondary_api_url, :string
    add_column :job_exchanges, :authentication_url, :string
  end
end
