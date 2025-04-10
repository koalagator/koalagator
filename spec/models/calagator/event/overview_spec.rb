# frozen_string_literal: true

require "spec_helper"

module Calagator
  describe Event::Overview, type: :model do
    describe "#times_to_events" do
      before do
        @today_midnight = today
        @yesterday = @today_midnight.yesterday
        @tomorrow = @today_midnight.tomorrow
        @day_after_tomorrow = @tomorrow.tomorrow
      end

      describe "#today" do
        it "includes events that started before today and end after today" do
          event = create(:event, start_time: @yesterday, end_time: @tomorrow)
          expect(subject.today).to include event
        end

        it "includes events that started earlier today" do
          event = create(:event, start_time: @today_midnight)
          expect(subject.today).to include event
        end

        it "does not include events that ended before today" do
          event = create(:event, start_time: @yesterday, end_time: @yesterday.end_of_day)
          expect(subject.today).not_to include event
        end

        it "does not include events that start tomorrow" do
          event = create(:event, start_time: @tomorrow)
          expect(subject.today).not_to include event
        end

        it "does not include events that ended at midnight today" do
          event = create(:event, start_time: @yesterday, end_time: @today_midnight)
          expect(subject.today).not_to include event
        end
      end

      describe "#tomorrow" do
        it "includes events that start tomorrow" do
          event = create(:event, start_time: @tomorrow)
          expect(subject.tomorrow).to include event
        end

        it "does not include events that start after tomorrow" do
          event = create(:event, start_time: @day_after_tomorrow)
          expect(subject.tomorrow).not_to include event
        end
      end

      describe "#later" do
        it "includes events that start after tomorrow" do
          event = create(:event, start_time: @day_after_tomorrow)
          expect(subject.later).to include event
        end

        it "does not include events that start after two weeks" do
          event = create(:event, start_time: 2.weeks.from_now.to_datetime)
          expect(subject.later).not_to include event
        end
      end

      describe "#more" do
        it "provides an event if there are events past the future cutoff" do
          event = create(:event, start_time: 2.weeks.from_now.to_datetime)
          expect(subject.more).to eq(event)
        end

        it "is nil if there are no events past the future cutoff" do
          create(:event, start_time: 2.weeks.from_now.to_datetime - 1.day)
          expect(subject.more).to be_blank
        end
      end
    end
  end
end
