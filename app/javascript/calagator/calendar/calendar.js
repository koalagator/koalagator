import {CalendarEvent} from 'calendar/event'
import {BaseComponent} from 'calendar/lib/components'
import ICAL from "ical.js";
import EventCalendar from "@event-calendar/core"
import ListView from "@event-calendar/list"
import DayGrid from "@event-calendar/day-grid"

class Calendar extends BaseComponent {
  static validViews = ["dayGridMonth", "listMonth"]
  static {
    this.observe("src", "view")
  }

  calendar

  constructor() {
    super()

    this.calendar = this._setupCalendar()
  }

  onSrcChanged(_, value) { this._loadICAL(value) }

  onViewChanged(_, value) {
    if (!Calendar.validViews.includes(value)) {
      this.setAttribute('view', validViews[0])
      return
    }
    this.calendar.setOption('view', value)
  }

  _loadICAL(source) {
    if (source == "") { return; }
    const calendar = this.calendar;

    fetch(source)
      .then(r => r.text())
      .then(text => this._parseICAL(calendar, text))
  }

  _parseICAL(calendar, rawText) {
    const jCal = ICAL.parse(rawText)
    const parser = new ICAL.ComponentParser
  
    const events = []
    parser.onevent = (event) => {
      events.push(
        {
          id: event.uid,
          start: event.startDate.toJSDate(),
          end: event.endDate.toJSDate(),
          title: event.summary,
          color: event.color || "#59a12d",
          editable: false,
          extendedProps: event
        }
      )
    };
    
    parser.oncomplete = () => {
      calendar.setOption("events", events)
    }
    parser.process(jCal)
  }

  _setupCalendar() {
    return new EventCalendar({
      target: this,
      props: {
        plugins: [ListView, DayGrid],
        options: {
          view: "dayGridMonth",
          events: [],
          firstDay: 1,
          eventContent: info => { return {domNodes: [new CalendarEvent(info.event)]} }
        }
      }
    })
  }
}

window.customElements.define("events-calendar", Calendar)
