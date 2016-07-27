
class FiniteAutomata

  ## Variáveis
  # track - Se o usuário quer ou não ver os rastros da simulação
  # type - Tipo de automato
  # automata_file - Arquivo com os dados do automato
  # entry_file - Arquivo com os dados de entrada do automato
  # automata - Automato em si, trata-se de um hash
  # current - Possui alguns dados sobre o estado atual do automato, também é um hash
  attr_accessor :track, :automata_file, :entry_file, :automata, :current, :name, :num_iters

  def initialize(track, automata_file, entry_file, name=nil)
    @track = track
    @automata_file = automata_file
    @entry_file = entry_file
    @name = name

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

    unless entry_file.nil?
      construct_entry
      puts @current.to_s
    end
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
            :entry => symbols[1]
        }

        if symbols[2][0] == "*"
          transition[:next] = symbols[2].delete('*')
          if !@automata[:terminals].include?(transition[:next])
            @automata[:terminals].push(transition[:next])
          else
            transition[:next] = symbols[2]
          end
        end

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
        @current[:right].push(symbol)
      end

    end
  end

  def run(i = 0, submachines = nil)
    # Setando configuração inicial
    if @current[:current_state].nil?
      @current[:current_state] = @automata[:initial]
    end
    if @name.nil?
      @current[:head] = @current[:left].shift
    end

    legal = true

    while @current[:head] != '#' && legal
      i += 1
      @num_iters = i
      legal = false

      @automata[:transitions].each do |transition|
        if transition[:current] == @current[:current_state] && transition[:entry] == @current[:head]
          @current[:current_state] = transition[:next]
          legal = true

          @current[:left].push(@current[:head])
          @current[:head] = @current[:right].shift
        end
      end

      if !legal & !submachines.nil?
        @automata[:transitions].each do |transition|

          if transition[:current] == @current[:current_state]

            if submachines.include? transition[:entry]
              return {
                  :from => @name,
                  :to => transition[:entry],
                  :state => transition[:next]
              }
            end

          end

        end
      end

    end

    if !legal
      if @automata[:terminals].include? @current[:current_state] && !@name.nil?
        puts "A MÁQUINA #{@name} TERMINOU EM UM ESTADO DE ACEITAÇÃO: #{@current[:current_state]}"
        result = true
      else
        puts "ENTRADA INVÁLIDA. FIM DA SIMULAÇÃO."
        result = false
      end
    else
      if @automata[:terminals].include? @current[:current_state]
        puts "TERMINOU EM UM ESTADO DE ACEITAÇÃO: #{@current[:current_state]}"
        result = true
      else
        puts "TERMINOU EM ESTADO NÃO TERMINAL. NÃO ACEITO"
        result = false
      end
    end

    if @name.nil?
      # Se chegamos ao final, podemos imprimir a lista de eventos
    end

    # Retorna o resultado
    result
  end

  def print

  end



end