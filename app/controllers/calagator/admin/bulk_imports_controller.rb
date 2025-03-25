# frozen_string_literal: true

require "calagator/import_events_csv"

module Calagator
  module Admin
    class BulkImportsController < Calagator::ApplicationController
      require_admin

      def new
      end

      def create
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
