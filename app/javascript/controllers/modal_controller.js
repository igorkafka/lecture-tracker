// app/javascript/controllers/modal_controller.js
import { Controller } from "@hotwired/stimulus"
import bulmaCalendar from 'bulma-calendar';
import 'jquery';
import 'jquery-steps';
import * as Vue from "vue"
import 'toast'
export default class extends Controller {
  connect() {
  }

  open() {
    configJquerySteps();
    configCalendar();
    const domTracksHiddenValue = document.getElementById('tracks_render').value;
    let initial_value;
    if (domTracksHiddenValue == "[]") {
      initial_value = []
    }
    else {
      initial_value = JSON.parse(domTracksHiddenValue);
    }
    configVue(initial_value);
    configInputNotAllowNumbers();
    document.getElementsByClassName("modal")[0].classList.add("is-active");
  }

  close() {
    document.getElementsByClassName("modal")[0].classList.remove("is-active");
  }
  save(){
    $('.modal input[type="submit"]').first().click();
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

const configVue = (initial_value) => {
  const app = Vue.createApp({
    data() {
      return {
        tracks: initial_value
      }
    },
    methods: {
      addTrack() {
        this.tracks.push({title: `Track ${letraDoAlfabeto(this.tracks.length)}`, lectures: [{}]});
        configInputNotAllowNumbers();
      },
      addLecture(track) {
        const index = this.tracks.indexOf(track);
        this.tracks[index].lectures.push({title: '',time_duration: 0});
        setTimeout(() => {
          configInputNotAllowNumbers();
        }, 500);
      },
      deleteTrack(track) {
        const index = this.tracks.indexOf(track);
        this.tracks.splice(index, 1);
      },
      removeLecture(track, lecture) {
        const index = this.tracks.indexOf(track);
         const indexLecture=  this.tracks[index].lectures.indexOf(lecture);
         this.tracks[index].lectures.splice(index, 1);
      },
      startManually() {
        this.tracks.push({title: `Track ${letraDoAlfabeto(this.tracks.length)}`, lectures: [{}]});
        setTimeout(() => {
          configInputNotAllowNumbers();
        }, 500);
      },
      configFileUpload (event) {
            (this.sendLectureFile(event.target.files[0]))

      },
       removeNumbersFromString() {
      },      
     sendLectureFile  (file, tracks)  {
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
            $.toast({
              text: 'Criado track de palestras com sucesso',
              position: 'top-right',
              stack: false,
              heading: 'Success',
              icon: 'success'
          })
           this.tracks = response.filter(x => x != null);;
            return response;
          },
          error: (response) => {
            $.toast({
              text: `${response.responseText}`,
              position: 'top-right',
              stack: false,
              heading: 'Erro',
              icon: 'erro'
          })
          }
        });
      }
    },
    computed: {
      filteredBooks() {
        return this.books.filter(book => book.isFav)
      }
    }
  })
  
  app.mount('#appTrack')
  
}

function letraDoAlfabeto(indice) {
  // Verifique se o índice está dentro do intervalo válido (0 a 25)
  if (indice >= 0 && indice <= 25) {
    // Crie uma string com todas as letras do alfabeto
    const alfabeto = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    
    // Use o índice para acessar a letra correspondente na string do alfabeto
    const letra = alfabeto.charAt(indice);
    
    return letra;
  } else {
    return "Índice fora do intervalo válido";
  }
}

const configInputNotAllowNumbers = () => {
  const inputElements = document.querySelectorAll('.lecture-input');
  console.log(inputElements);
    // Loop through each input element and add the event listener
    inputElements.forEach(function(inputElement) {
      inputElement.addEventListener('input', function (event) {
        // Get the current input value
        const inputValue = event.target.value;
        
        // Remove any numbers from the input
        const filteredValue = inputValue.replace(/[0-9]/g, '');

        // Update the input value with the filtered value
        event.target.value = filteredValue;
      });
    })
}

