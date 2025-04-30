# frozen_string_literal: true

require "csv"
require "calagator/import_events_csv"

module Calagator
  module Admin
    class BulkImportsController < Calagator::ApplicationController
      require_admin

      def new
      end

      def create
        # example code via: https://guides.rubyonrails.org/form_helpers.html#uploading-files

        @uploaded_file = params[:csv_file]

        if @uploaded_file.present?
          Rails.logger.info "upload_file present"
          csv_data = CSV.parse(@uploaded_file.read, headers: true)
          @bulk_import = Calagator::BulkImport.new(csv_data)
          @bulk_import.process_csv_file(csv_data)
        else
          Rails.logger.info "upload_file not present"
        end

        respond_to do |format|
          if @bulk_import&.errors&.empty?
            Rails.logger.info "errors is empty"
            format.html { redirect_to events_path(order: "created_at"), notice: "Successfully imported all records." }
          else
            Rails.logger.info "csv_errors is not empty"
            Rails.logger.info "#{@bulk_import&.errors}"
            # @bulk_import.count_saved_successfully = 0
            # @bulk_import.count_not_saved = 0
            format.html { render :new, status: :unprocessable_entity }
          end
        end
      end
    end
  end
end
