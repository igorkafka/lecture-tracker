require "rails_helper"

RSpec.describe Event do
    subject= described_class.create(name: 'Campus Party', date_scheduled: DateTime.now)
    describe "Validations" do
      it "must be presented" do
        subject.name = nil
        expect(subject).to_not be_valid
        subject.name = "Campus Party"
        expect(subject).to be_valid
      end
    end
    describe "Date Scheduled" do
      it "must be present" do
        subject.date_scheduled = nil
        expect(subject).to_not be_valid
        subject.date_scheduled = DateTime.now
        expect(subject).to be_valid
      end
    end
    describe "Read document" do
      it "must be present" do
        file_path = File.expand_path("../../fixtures/teste.txt", __FILE__) # Get the absolute path to the text file
        file_contents = File.read(file_path).force_encoding('UTF-8')
        formatted_lectures = Lecture.parse_lectures(file_contents.split(/\r\n/))
        tracks = Track.build_tracks(formatted_lectures)
        expect(tracks.count > 0).to eql(true)
      end
    end
  end
  