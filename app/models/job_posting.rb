class JobPosting < ActiveRecord::Base
	belongs_to :company

	def self.xlsx_export(wb)
		wb.add_worksheet(name: "data") do |ws|
      		ws.add_row ["woot 1", "woot 2"]
      	end
      	return wb
    end   
end
