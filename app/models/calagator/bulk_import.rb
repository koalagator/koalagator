module Calagator
  class BulkImport
    def initialize(csv_data)
      @csv_data = csv_data
      @errors = []
    end

    attr_reader :errors

    def process_csv_file(csv_data)
      @errors = []
      processed_events = csv_data.each.with_index(2).map { |row, index| process_row(row, index) }
      return false if @errors.any?
      processed_events.map { |event| event.save }
    end

    def process_row(row, index)
      venue = set_venue(row["venue"])
      event = Calagator::Event.new(
        title: row["title"],
        venue_id: venue&.id,
        url: row["url"],
        start_time: set_event_at(row["event_start_at"]),
        end_time: set_event_at(row["event_end_at"]),
        description: row["description"],
        venue_details: row["venue_details"],
        tag_list: row["event_tag_list"]
      )

      if Calagator::Event.find_duplicate(event.title, event.start_time, event.end_time, venue).any?
        return @errors << "Row #{index}: 'Duplicate of an existing event.'"
      end

      if event.valid?
        event
      else
        @errors << "Row #{index}: #{event.errors.full_messages}"
      end
    end

    def set_event_at(value)
      return "" unless value.present?
      Time.strptime value, "%d/%m/%Y %H:%M:%S"
    end

    def set_venue(value)
      return "" unless value.present?
      value_s = value.to_s
      value_i = value_s.to_i
      target_venue = if value_s.match?(/^\s*\d+\s*$/) && value_i > 0
        Calagator::Venue.find_by(id: value_i)
      else
        Calagator::Venue.search(value_s, limit: 1).first
      end
      Rails.logger.info "set_venue.target_venue #{target_venue}"
      target_venue
    end
  end
end
