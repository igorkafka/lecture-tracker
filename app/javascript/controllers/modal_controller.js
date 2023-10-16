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
      sendLectureFile(fileInput.files[0])
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

const sendLectureFile = (file) => {
  var myformData = new FormData();      
  myformData.append('lecture_file',file);

  $.ajax({
    url: "/lectures/file",
    type: "POST",
    headers: {
      Accept: "application/json",
      "X-Requested-With": "XMLHttpRequest",
      "X-CSRF-Token": document.querySelector("meta[name=csrf-token]")?.getAttribute("content"),
    },
    beforeSend(xhr, options) {
      options.data = myformData;
      return true;
    },
    success: response => {
      if (response.success) {
        alert("File uploaded successfully");
      }
      else {
        alert(response.errors.join("<br>"));
      }
    },
    error: () => {
      alert("ajax send error");
    }
  });
}