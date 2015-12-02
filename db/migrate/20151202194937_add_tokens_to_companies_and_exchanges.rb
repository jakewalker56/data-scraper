class AddTokensToCompaniesAndExchanges < ActiveRecord::Migration
  def change
  	add_column :companies, :primary_api_url, :string
    add_column :companies, :secondary_api_url, :string
    add_column :companies, :authentication_url, :string

    add_column :companies, :primary_token, :string
    add_column :job_exchanges, :primary_token, :string
    add_column :companies, :secondary_token, :string
    add_column :job_exchanges, :secondary_token, :string
  end
end
