require "rails_helper"

RSpec.describe Lecture do
    describe "Read document" do
      it "must be present" do
        file_path = File.expand_path("../../fixtures/teste.txt", __FILE__) # Get the absolute path to the text file
        file_contents = File.read(file_path).force_encoding('UTF-8')
        formatted_lectures = Lecture.parse_lectures(file_contents.split(/\r\n/))
        tracks = Track.build_tracks(formatted_lectures)
        expect(tracks.first.lectures.first.title).to include('Diminuindo tempo de execução de testes em aplicações Rails enterprise')
      end
    end
  end
  