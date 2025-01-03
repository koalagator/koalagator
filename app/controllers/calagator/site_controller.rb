# frozen_string_literal: true

module Calagator
  class SiteController < Calagator::ApplicationController
    # Raise exception, mostly for confirming that exception_notification works

    nav_section :about, only: :about

    def omfg
      raise ArgumentError, "OMFG"
    end

    # Render something to help benchmark stack without the views
    def hello
      render plain: "hello"
    end

    def embed
      render layout: "calagator/embed"
    end

    def index
      @overview = Event::Overview.new
      respond_to do |format|
        format.html {}
        format.any { redirect_to events_path(format: params[:format]) }
      end
    end

    # Displays the about page.
    def about
    end

    def opensearch
      respond_to do |format|
        format.xml { render content_type: "application/opensearchdescription+xml" }
      end
    end

    def defunct
      @url = params[:url]
      raise ArgumentError if /^javascript:/.match?(@url)
    end

    def closed_registrations
    end
  end
end
