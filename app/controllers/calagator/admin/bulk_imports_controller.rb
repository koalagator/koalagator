# frozen_string_literal: true

require "calagator/import_events_csv"

module Calagator
  module Admin
    class BulkImportsController < Calagator::ApplicationController
      require_admin

      def new
      end

      def create
        # example code via: https://guides.rubyonrails.org/form_helpers.html#uploading-files
      
        uploaded_file = params[:csv_file]
        if uploaded_file.present?
          csv_data = CSV.parse(uploaded_file.read, headers: true)
          csv_data.each do |row|
            # Process each row of the CSV file
            # SomeInvoiceModel.create(amount: row['Amount'], status: row['Status'])
            Rails.logger.info row.inspect
            #<CSV::Row "id":"po_1KE3FRDSYPMwkcNz9SFKuaYd" "Amount":"96.22" "Created (UTC)":"2022-01-04 02:59" "Arrival Date (UTC)":"2022-01-05 00:00" "Status":"paid">
          end
        end
        # ...

        # see /lib/import_events_csv.rb for the rest of the code.
        # Suggest move move /lib/import_events_csv.rb into models that are not connected to active record eg PORO.

        # @curation = Curation.new(curation_params)

        # respond_to do |format|
        #   if @curation.save
        #     format.html { redirect_to admin_curations_path, notice: "Successfully created curation." }
        #   else
        #     format.html { render :new, status: :unprocessable_entity }
        #   end
        # end
      end
    end
  end
end
