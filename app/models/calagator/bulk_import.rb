require 'Date'

module Calagator
  class BulkImport

    def initialize(csv_data)
      @csv_data = csv_data
      @csv_errors = []
      @count_saved_successfully 
      @count_not_saved
    end 

    def csv_errors
      @csv_errors
    end
    
    def process_csv_file(csv_data)
      # Rails.logger.info csv_data
      csv_data.each {|row| process_row(row, 1)}
    end

    def process_row(row, index)

      # date_start: row['date_start'],		
      #   date_end: row['date_end'],		
      #   time_start: row['time_start'],		
      #   time_end: row['time_end'],		

      # tag_list: row['event_tag_list']
      Rails.logger.info "Title: #{row['title']}"

      # event = Calagator::Event.new(
      #   title: row['title'],
      #   venue_id: 1,	
      #   url: row['url'],		
      #   start_time: DateTime.now,
      #   description: row['description'],		
      #   venue_details: row['venue_details']
      # )

    event = Calagator::Event.new(
        title: row['title'],
        venue_id: 1,	
        url: row['url'],		
        start_time: DateTime.now,
        description: row['description'],		
        venue_details: row['venue_details']
    )

      # return @csv_errors << "Row #{index}: Field 'title' is missing. Title is required." unless event.title.present?
      # return @csv_errors << "Row #{index}: Field 'date_start' is missing. Start Date is required." unless event.start_date.present?

      Rails.logger.info event

      if event.save
        Rails.logger.info "Event Saved"
        true
      else
        Rails.logger.info "Event Error"
        Rails.logger.info "event errors: #{event.errors.full_messages}"
        @csv_errors << "Row #{index}: #{event.errors.full_messages}"
        false
      end
    end
  end
end