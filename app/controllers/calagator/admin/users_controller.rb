# frozen_string_literal: true

module Calagator
  module Admin
    class UsersController < Calagator::ApplicationController
      require_admin
      before_action :set_user, only: %i[invite show edit update destroy]

      def index
        @users = User.order(created_at: :desc).paginate(page: params[:page])
      end

      def new
        @user = User.new
      end

      def show
      end

      def create
        @user = User.new(user_params)
        temp_pass = SecureRandom.base36
        @user.password = temp_pass
        @user.password_confirmation = temp_pass

        respond_to do |format|
          if @user.save
            token = @user.send_reset_password_instructions
            format.html {
              redirect_to admin_user_invite_path(@user, token: token), notice: "Successfully created user."
            }
          else
            format.html { render :new, status: :unprocessable_entity }
          end
        end
      end

      def edit
      end

      def update
        respond_to do |format|
          if @user.update(user_params)
            format.html { redirect_to admin_users_path, notice: "Successfully updated user." }
          else
            format.html { render :edit, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        respond_to do |format|
          if @user.admin? || @user == current_user
            format.html { redirect_to admin_users_path, notice: "Cannot delete an admin." }
          else
            @user.destroy
            format.html { redirect_to admin_users_path, notice: "Successfully destroyed user." }
          end
        end
      end

      def invite
        redirect_to admin_users_path unless params[:token].present?
      end

      private

      def user_params
        params.require(:user).permit(:email, :name, :display_name, :admin)
      end

      def set_user
        @user = User.find(params[:user_id] || params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to admin_users_path
      end
    end
  end
end
