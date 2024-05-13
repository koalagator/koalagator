module Calagator
  module EventFilterable
    extend ActiveSupport::Concern

    included do
      acts_as_taggable_on :blocks, :requires, :denies, :allows
    end

    def events
      event_list = Event.all
      event_list.merge!(Event.tagged_with(block_list, exclude: true)) if block_list.any?
      event_list.merge!(Event.tagged_with(require_list), any: true) if require_list.any?
      if deny_list.any?
        deny = event_list.tagged_with(deny_list, exclude: true).or(
          event_list.tagged_with(allow_list, any: true).except(:select, :order)
        )
        event_list.merge!(deny)
      end
      event_list
    end
  end
end
