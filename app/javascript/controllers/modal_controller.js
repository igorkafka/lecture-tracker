// app/javascript/controllers/modal_controller.js
import { Controller } from "@hotwired/stimulus"
import bulmaCalendar from 'bulma-calendar';
import 'jquery';
import 'jquery-steps';

export default class extends Controller {
  connect() {
    console.log(document.getElementById('event_date_scheduled'));
  }

  open() {
    configJquerySteps();
    configCalendar();
    configFileUpload();
    document.getElementsByClassName("modal")[0].classList.add("is-active");
  }

  close() {
    document.getElementsByClassName("modal")[0].classList.remove("is-active");
  }
  save(){
    $('.modal input[type="submit"]').first().click();
  }
}

const configFileUpload = () => {
  const fileInput = document.querySelector('#file-lecture[type=file]');
  fileInput.onchange = () => {
    if (fileInput.files.length > 0) {
      const fileName = document.querySelector('#file-lecture-name');
      fileName.textContent = fileInput.files[0].name;
    }
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
	});
});

// To access to bulmaCalendar instance of an element
const element = document.querySelector('#my-element');
if (element) {
	// bulmaCalendar instance is available as element.bulmaCalendar
	element.bulmaCalendar.on('select', datepicker => {
	});
}
}
const configJquerySteps = () => {
  $('#demo').steps({
    onFinish: function () {  }
  });
}