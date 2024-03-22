# frozen_string_literal: true

# Methods added to this helper will be available to all templates in the application.
module Calagator
  module ApplicationHelper
    include TimeRangeHelper

    # Returns HTML string of an event or venue description for display in a view.
    def format_description(string)
      sanitize(auto_link(upgrade_br(markdown(string))))
    end

    def markdown(text)
      BlueCloth.new(text, relaxed: true).to_html
    end

    # Return a HTML string with the BR tags converted to XHTML compliant markup.
    def upgrade_br(content)
      content.gsub("<br>", "<br />")
    end

    def display_username(user)
      name = sanitize(user.name)
      display_name = sanitize(user.display_name)
      admin_flag = (user.admin? ? "<span title=\"Administrator\">#{Calagator.admin_icon} </span>" : nil )
      raw "<span title=\"@#{name}\">#{admin_flag}#{display_name}</span>"
    end

    FLASH_TYPES = %i[success failure].freeze

    def render_flash
      FLASH_TYPES.map do |type|
        next if flash[type].blank?

        content_tag(:div, class: "flash #{type} flash_#{type}") do
          "#{(type == :failure) ? "ERROR: " : ""}#{flash[type]}".html_safe
        end
      end.compact.join.html_safe
    end

    def datetime_format(time, format)
      format = format.gsub(/(%[dHImU])/, '*\1')
      time.strftime(format).gsub(/\*0*/, "").html_safe
    end

    # Return a string describing the source code version being used
    def source_code_version
      Calagator::VERSION
    end

    # returns html markup with source (if any), imported/created time, and - if modified - modified time
    def datestamp(item)
      source = if item.source.nil?
        "added directly to #{Calagator.title}"
      else
        "imported from #{link_to truncate(item.source.name, length: 40), url_for(item.source)}"
      end
      creator = if item&.created_by_id?
        " by:<br />#{display_username(item.created_by)}"
      elsif item&.created_by_name?
        " by:<br />#{CGI.escapeHTML(item.created_by_name)}"
      else
        nil
      end
      created = " <br /><strong>#{normalize_time(item.created_at, format: :html)}</strong>"
      updated = if item.updated_at > item.created_at
        " and last updated <br /><strong>#{normalize_time(item.updated_at, format: :html)}</strong>"
      end
      raw "This item was #{source}#{creator}#{created}#{updated}."
    end

    # Caches +block+ in view only if the +condition+ is true.
    # http://skionrails.wordpress.com/2008/05/22/conditional-fragment-caching/
    def cache_if(condition, name = {}, &block)
      if condition
        cache(name, &block)
      else
        yield
      end
    end

    def subnav_class_for(controller_name, action_name)
      css_class = "#{controller.controller_name}_#{controller.action_name}_subnav"
      if [controller.controller_name, controller.action_name] == [controller_name, action_name]
        css_class += " active"
      end
      css_class
    end
  end
end
