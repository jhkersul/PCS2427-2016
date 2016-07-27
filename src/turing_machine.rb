
class TuringMachine

  ## Variáveis
  # track - Se o usuário quer ou não ver os rastros da simulação
  # type - Tipo de automato
  # automata_file - Arquivo com os dados do automato
  # entry_file - Arquivo com os dados de entrada do automato
  # automata - Automato em si, trata-se de um hash
  # current - Possui alguns dados sobre o estado atual do automato, também é um hash
  attr_accessor :track, :automata_file, :entry_file, :automata, :current

  def initialize(track, automata_file, entry_file)
    @track = track
    @automata_file = automata_file
    @entry_file = entry_file
    @automata = {
        :initial => nil,
        :transitions => [],
        :terminals => []
    }

    @current = {
        :current_state => nil,
        :head => nil,
        :left => [],
        :right => []
    }

    construct_automata
    puts @automata.to_s

    construct_entry
    puts @current.to_s
  end

  def construct_automata

    line_num = 0

    # Lendo linhas
    @automata_file.each_line do |line|

      # Criando um array com cada item da linha
      symbols = line.split(" ")

      if line_num == 0
        if symbols[0][0] == "*"
          @automata[:terminals].push(symbols[0].delete('*'))
          @automata[:initial] = symbols[0].delete('*')
        else
          @automata[:initial] = symbols[0]
        end

      else
        transition = {
            :current => symbols[0],
            :entry => symbols[1],
            :next => symbols[2],
            :direction => symbols[3]
        }

        @automata[:transitions].push(transition)
      end

      line_num += 1

    end

  end

  def construct_entry
    # Lendo linhas
    @entry_file.each_line do |line|

      # Criando um array com cada item da linha
      symbols = line.split(" ")

      symbols.each do |symbol|
        @current[:left].push(symbol)
      end

    end
  end

  def run

  end

end