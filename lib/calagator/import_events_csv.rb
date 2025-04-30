require "smarter_csv"

module Calagator
  class ImportEventsCsv
    attr_reader :csv, :events

    def initialize(input)
      @csv = SmarterCSV::Reader.new(input,
        col_sep: ",",
        row_sep: "\n",
        user_provided_headers: %i[title description venue start_date end_date tag_list])
      @events = process_events
    end

    def valid?
      @valid
    end

    def import!(allow_invalid: false)
      events.each do |event|
        if allow_invalid
          event.import
        else
          event.import!
        end
      end
    end

    private def process_events
      event_list = []

      @valid = true
      csv.process do |row|
        event = ImportedEvent.new(row.first)
        @valid = false unless event.valid?
        event_list << event
      end

      event_list
    end

    class InvalidEventError < StandardError
    end

    class ImportedEvent
      attr_reader :data, :errors
      attr_accessor :title, :description, :venue, :start_date, :end_date, :tag_list

      def initialize(data)
        @data = data
        @errors = {}

        set_title(data[:title])
        set_description(data[:description])
        set_venue(data[:venue])
        set_start_date(data[:start_date])
        set_end_date(data[:end_date])
        set_tag_list(data[:tag_list])
      end

      def valid?
        @errors.empty?
      end

      def import
        return false if !valid?

        Calagator::Event.create(title: title, description: description, venue: venue, start_date: start_date, end_date: end_date, tag_list: tag_list)
      end

      def import!
        result = import
        raise InvalidEventError unless result

        result
      end

      private

      def set_title(value)
        return errors[:title] = "is empty" unless value.present?

        @title = value.to_s
      end

      def set_description(value)
        @description = value.to_s
      end

      def set_venue(value)
        return errors[:venue] = "is empty" unless value.present?

        value_s = value.to_s
        value_i = value_s.to_i
        target_venue = if value_s.match?(/^\s*\d+\s*$/) && value_i > 0
          Calagator::Venue.find_by(id: value_i)
        else
          Calagator::Venue.search(value_s, limit: 1).first
        end

        return errors[:venue] = "cannot be found" unless target_venue.present?

        @venue = target_venue
      end

      def set_start_date(value)
        @start_date = Time.iso8601(value)
      rescue
        errors[:start_date] = "is not in ISO 8601 time format"
      end

      def set_end_date(value)
        @end_date = Time.iso8601(value)
      rescue
        errors[:end_date] = "is not in ISO 8601 time format"
      end

      def set_tag_list(value)
        @tag_list = value
      end
    end
  end
end
