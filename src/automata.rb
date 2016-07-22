require 'matrix'

class Automata
  class << self

    @@valid_chars = 'a'.upto('z').to_a + 'A'.upto('Z').to_a + 0.upto(9).to_a
    @@automata_data ||= [] # Constitui os dados puros do automato
    @@states ||= []

    # Esta função constrói um autômato através da leitura de um arquivo
    def construct(file_name)
      # Abrindo e lendo arquivo
      file = File.open(file_name, "r")

      # Lendo linhas
      file.each_line do |line|

        line_array = line.split(' ')

        if line_array[0] != '#' && !line_array.nil?
          @@automata_data << line_array
        end

      end

      @@states == get_states

      file.close
    end

    def get_states
      states ||=[]

      @@automata_data.each do |data|
        current_state = data[0]

        unless states.contains(current_state)
          states << current_state
        end
      end

      states
    end


    # SETANDO VARIÁVEIS GLOBAIS

    def automata_data
      @@automata_data
    end

  end
end