require '../src/finite_automata'


class StackAutomata

  ## Variáveis
  # track - Se o usuário quer ou não ver os rastros da simulação
  # type - Tipo de automato
  # automata_file - Arquivo com os dados do automato
  # entry_file - Arquivo com os dados de entrada do automato
  # automata - Automato em si, trata-se de um hash
  # current - Possui alguns dados sobre o estado atual do automato, também é um hash
  attr_accessor :track, :automata_file, :entry_file, :automata, :current, :submachines, :submachine_names

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

    @submachines = []
    @submachine_names = []

    construct_automata
    puts @automata.to_s

    construct_entry
    puts @current.to_s
  end

  def construct_automata

    line_num = 0
    submachine_file = ""

    # Lendo linhas
    # Vamos construir as submáquinas
    @automata_file.each_line do |line|
      # Criando um array com cada item da linha
      symbols = line.split(" ")

      # Se estamos na primeira linha
      if line_num == 0
        submachine_file = ""
        @submachine_names << symbols[0]
      elsif symbols[0] == '@'
        line_num = 0
        @submachines << FiniteAutomata.new(@track, submachine_file, nil)
        next
      else
        # Adicionamos ao arquivo da submachine a nova linha
        submachine_file = "#{submachine_file}#{line}"
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
        @current[:right].push(symbol)
      end

    end
  end

  def run


  end



end