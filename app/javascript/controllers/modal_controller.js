// app/javascript/controllers/modal_controller.js
import { Controller } from "@hotwired/stimulus"
import bulmaCalendar from 'bulma-calendar';
import 'jquery';

export default class extends Controller {
  connect() {
    console.log(document.getElementById('event_date_scheduled'));
  }

  open() {
    configCalendar();
    document.getElementsByClassName("modal")[0].classList.add("is-active");
  }

  close(event) {
    document.getElementsByClassName("modal")[0].classList.remove("is-active");
  }
  save(){
    $("#form-event-create-update form").first().submit();
  }
}


const configCalendar = () => {
  const options = {
    showHeader: false,
    lang: 'pt-BR',
    dateFormat: 'dd/MM/yyyy'
  };
// Initialize all input of date type.
const calendars = bulmaCalendar.attach('[type="date"]', options);
// Loop on each calendar initialized
calendars.forEach(calendar => {
	// Add listener to select event
	calendar.on('select', date => {
		console.log(date);
	});
});

// To access to bulmaCalendar instance of an element
const element = document.querySelector('#my-element');
if (element) {
	// bulmaCalendar instance is available as element.bulmaCalendar
	element.bulmaCalendar.on('select', datepicker => {
		console.log(datepicker.data.value());
	});
}
}