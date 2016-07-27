require '../src/turing_machine'
require '../src/finite_automata'
require '../src/stack_automata'

=begin
Classe Simulator
Define o comportamento do simulador em si
=end
class Simulator

  ## Variáveis
  # track - Se o usuário quer ou não ver os rastros da simulação
  # type - Tipo de automato
  # automata_file - Arquivo com os dados do automato
  # entry_file - Arquivo com os dados de entrada do automato
  attr_accessor :track, :type, :automata_file, :entry_file

  def initialize(track, type, automata_file, entry_file)
    @track = track
    @type = type
    @automata_file = automata_file
    @entry_file = entry_file
  end

  def run
    case @type
      when 'af'
        finite_automata = FiniteAutomata.new(@track, @automata_file, @entry_file)
        finite_automata.run
      when 'mt'
        turing_machine = TuringMachine.new(@track, @automata_file, @entry_file)
        turing_machine.run
      when 'ap'
        stack_automata = StackAutomata.new(@track, @automata_file, @entry_file)
        stack_automata.run
      else
        puts 'Entrada inválida'
    end
  end



end