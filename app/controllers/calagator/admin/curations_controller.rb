# frozen_string_literal: true

module Calagator
  module Admin
    class CurationsController < Calagator::ApplicationController
      require_admin
      before_action :set_curation, only: %i[edit update destroy]

      def index
        @curations = Curation.order_by_priority
      end

      def new
        @curation = Curation.new
      end

      def create
        @curation = Curation.new(curation_params)

        respond_to do |format|
          if @curation.save
            format.html { redirect_to admin_curations_path, notice: "Successfully created curation." }
          else
            format.html { render :new, status: :unprocessable_entity }
          end
        end
      end

      def edit
      end

      def update
        respond_to do |format|
          if @curation.update(curation_params)
            format.html { redirect_to admin_curations_path, notice: "Successfully updated curation." }
          else
            format.html { render :edit, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @curation.destroy
        respond_to do |format|
          format.html { redirect_to admin_curations_path, notice: "Successfully destroyed curation." }
        end
      end

      private

      def curation_params
        params.require(:curation).permit(:name, :display_name, :description, :priority, :unlisted, :block_list, :require_list, :deny_list, :allow_list)
      end

      def set_curation
        @curation = Curation.find(params[:id])

      rescue ActiveRecord::RecordNotFound
        redirect_to admin_curations_path
      end
    end
  end
end
