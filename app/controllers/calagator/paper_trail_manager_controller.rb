module Calagator
  class PaperTrailManagerController < ApplicationController
    authorize_resource :changes
  end
end