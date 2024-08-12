class CalendarEvent extends HTMLElement {
  constructor(event) {
    super()
    this._setupDom(event)
  }

  _setupDom(event) {
    console.log(event)
    const body = createElement("div", "event-body")
    const title = createElement("h4", "event-title")
    const detailsContainer = createElement("div", "event-details-container")
    const detailsArrow = createElement("div", "event-details-arrow")
    
    title.innerText = event.title
    
    detailsArrow.append(this._createDetails(event))
    detailsContainer.append(detailsArrow)
    
    body.append(this._createTimeLabel(event.start, event.end))
    body.append(title)
    this.append(body)
    this.append(detailsContainer)

    document.addEventListener("click", () => {
      if (this.matches(":hover")) {
        this.setAttribute("open", "")
      } else {
        this.removeAttribute("open")
      }
    })
  }

  _createTimeLabel(start, end) {
    const time = createElement("time", "event-time")
    time.setAttribute("datetime", start.toISOString())

    let innerText = start.toLocaleTimeString(undefined, {timeStyle: "short"})
    if (end) {
      innerText += " - " + end.toLocaleTimeString(undefined, {timeStyle: "short"})
    }
    
    time.innerText = innerText
    return time
  }

  _createDetails(event) {
    const details = createElement("div", "event-details")
    const header = createElement("h4")
    const description = createElement("div", "event-description")
    const link = createElement("a")
    
    header.innerText = event.title
    link.setAttribute("href", event.id)
    link.setAttribute("target", "_blank")
    link.innerText = "View Event"

    details.append(header)

    if (event.extendedProps.location) {
      const address = createElement("address")
      const addr = event.extendedProps.location.replaceAll("&#13;", "")
      address.innerText = addr;

      details.append(address)
    }

    if (event.extendedProps.description) {
      const desc = event.extendedProps.description.replaceAll("&#13;", "").split("\n")
      desc.forEach(line => {
        if (line == "") { return }
        const p = document.createElement("p")
        p.innerText = line
        description.append(p)
      })
    }

    details.append(description)
    details.append(link)

    return details
  }
}

function createElement(element, ...classes) {
  const instance = document.createElement(element)
  if (classes.length > 0) {
    instance.classList.add(classes)
  }
  return instance
}

window.customElements.define("calendar-event", CalendarEvent)

export {CalendarEvent}