// app/javascript/controllers/modal_controller.js
import { Controller } from "@hotwired/stimulus"
import bulmaCalendar from 'bulma-calendar';
import 'jquery';
import 'jquery-steps';
import * as Vue from "vue"

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
      },
      removeTrack(track) {
        book.isFav = !book.isFav;
      },
      alterTrack(track)  {
      },
      addLecture(track) {
        const index = this.tracks.indexOf(track);
        console.log(index);
        this.tracks[index].lectures.push({title: '',time_duration: 0});
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
        console.log(this.tracks);
        this.tracks.push({title: `Track ${letraDoAlfabeto(this.tracks.length)}`, lectures: [{}]});
      },
      configFileUpload (event) {
           alert('teste');
            const fileName = document.querySelector('#file-lecture-name');
            fileName.textContent = event.target.files[0].name
            console.log(this.sendLectureFile(event.target.files[0]));
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
           this.tracks = response.filter(x => x != null);;
            return response;
          },
          error: () => {
            alert("ajax send error");
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