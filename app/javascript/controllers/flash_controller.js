// app/javascript/controllers/flash_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    this.timeout = setTimeout(() => {
      this.close()
    }, 2000)
  }

  disconnect() {
    clearTimeout(this.timeout)
  }

  close() {
    this.element.classList.add('opacity-0', 'transition-opacity', 'duration-500');
    setTimeout(() => {
      this.element.remove()
    }, 500)
  }
}
