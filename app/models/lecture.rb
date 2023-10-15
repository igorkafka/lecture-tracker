class Lecture < ApplicationRecord
  belongs_to :event
  def parse_lista_palestras(lista)
    palestras = []
    lista.each do |item|
      horario_match = /(\d{2}:\d{2})/.match(item)
      horario = horario_match[0] if horario_match
  
      titulo_match = /([^\d]+)\s+\d{2}min/.match(item)
      titulo = titulo_match[1].strip if titulo_match
  
      duracao_match = /(\d{2}min)/.match(item)
      duracao = duracao_match[0] if duracao_match
  
      if horario && titulo && duracao
        palestra = Palestra.new(horario, titulo, duracao)
        palestras << palestra
      end
    end
  end
end
