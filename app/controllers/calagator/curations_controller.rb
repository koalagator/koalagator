# frozen_string_literal: true

module Calagator
  class CurationsController < Calagator::ApplicationController
    before_action :set_curation, only: %i[show]

    def show
      @browse = Event::Browse.new(params, @curation.events)
      @events = @browse.events
      @browse.errors.each { |error| append_flash :failure, error }
      render_events @events
    end

    private

    def set_curation
      @curation = Curation.find_by_name(params[:id])
      redirect_to root_path unless @curation.present?
    end

    def render_events(events)
      respond_to do |format|
        format.html # *.html.erb
        format.kml  # *.kml.erb
        format.ics { render ics: events || Event.future.non_duplicates }
        format.atom { render template: "calagator/events/index" }
        format.xml { render xml: events.to_xml(root: "events", include: :venue) }
        format.json { render json: events.to_json(include: :venue) }
      end
    end
  end
end
