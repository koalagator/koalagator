module Calagator
  class BulkImport
    def initialize(csv_data)
      @csv_data = csv_data
      @csv_errors = []
    end

    attr_reader :csv_errors

    def process_csv_file(csv_data)
      csv_data.map {|row| process_row(row, 1)}.map {|event| event.save; puts "event saved"}
    # rescue 
    #   Rails.logger.info "rescue called within .process_csv_file"
    #   return false
    end

    def process_row(row, index)
      # tag_list: row['event_tag_list']

      event = Calagator::Event.new(
        title: row["title"],
        venue_id: set_venue(row["venue"])&.id,
        url: row["url"],
        start_time: set_event_at(row["event_start_at"]),
        end_time: set_event_at(row["event_end_at"]),
        description: row["description"],
        venue_details: row["venue_details"],
        tag_list: row["event_tag_list"]
      )

      if event.valid?
        Rails.logger.info "Event Saved"
        return event
      else
        Rails.logger.info "Event Error"
        Rails.logger.info "event errors: #{event.errors.full_messages}"
        @csv_errors << "Row #{index}: #{event.errors.full_messages}"
        Rails.logger.info "rescue called within .process_csv_file"
        raise "Invalid Event"
      end
    end

    def set_event_at(value)
      Time.strptime value, "%d/%m/%Y %H:%M:%S"
    end

    def set_venue(value)
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
