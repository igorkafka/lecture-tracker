require "rails_helper"

RSpec.describe "Events requests" do
      event = Event.create(name: 'Campus Party', date_scheduled: DateTime.now)

    describe "GET /events", type: :request do
      it "returns an array of the consoles" do
        visit("/")
        puts page
        expect(page).to have_content(
          'Campus Party'
        )
      end
  
      it "Abrir Modal de editar", type: :request do
        visit('/')
        click_link("Editar", match: :first)
        expect(page).to have_content(
          'Próximo'
        )
      end
      it "Excluir", type: :request do
        visit('/')
        click_link("Editar", match: :first)
        expect(page).to_not have_content(
          'Campus Party'
        )
      end
    end
  end