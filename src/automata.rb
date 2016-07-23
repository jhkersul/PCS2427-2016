class Automata
  class << self

    @@valid_chars = 'a'.upto('z').to_a + 'A'.upto('Z').to_a + 0.upto(9).to_a # Caracteres validos para serem usados nos automatos
    @@automata_data ||= [] # Constitui os dados puros do automato
    @@states ||= [] # Conjunto de estados que o automato possui

    ### Esta função constrói um autômato através da leitura de um arquivo
    def construct(file_name)
      # Abrindo e lendo arquivo
      file = File.open(file_name, "r")

      # Lendo linhas
      file.each_line do |line|

        # Criando um array com cada item da linha
        line_array = line.split(" ")

        # Jogando os valores que não são comentários para automata_data
        if line_array[0] != '#' && !line_array.nil?
          @@automata_data << line_array
        end

      end

      # Fechando arquivo
      file.close

      # Construindo estados
      @@states = construct_states

      puts "Estados: " + @@states.to_s
    end

    ### Este método constrói um array com todos os estados que constituem este automato
    def construct_states
      states ||=[]

      @@automata_data.each do |data|
        current_state = data[0]

        unless states.include? current_state
          states << current_state
        end
      end


      states
    end


    ### SETANDO VARIÁVEIS GLOBAIS
    def automata_data
      @@automata_data
    end

  end
end
