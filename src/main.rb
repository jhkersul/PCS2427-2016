require '../src/simulator'

=begin
Classe Main
Responsável por controlar o inicio da execução do programa
=end
class Main

  #
  def run
    # Setando a codificação padrão do Ruby
    Encoding.default_internal = Encoding::UTF_8
    Encoding.default_external = Encoding::UTF_8

    # Começando programa
    puts "",
         "Projeto PCS2427 - Simulação de Autômatos",
         "João Henrique Kersul Faria - 8041157",
         ""


    # Pegar se o usuário quer ou não mostrar os rastros da simulação
    print 'Mostrar ou não rastros (s/n): '
    track = gets.chomp

    if track == 's'
      track = true
    elsif track == 'n'
      track = false
    else
      puts 'Entrada inválida'
      return
    end

    # Pegando o tipo de automato que o usuário quer simular
    print 'Digite o tipo de automato que deseja executar (af/mt/ap): '
    type = gets.chomp

    if type != 'af' && type != 'mt' && type != 'ap'
      puts 'Entrada inválida'
      return
    end

    # Pegando arquivo que contém o automato
    print 'Digite o nome do arquivo que possui este automato: '
    #file_name = './test/' + gets.chomp + '.txt'
    file_name = "./test/taf1.txt"

    # Se o arquivo existir, começamos a construir o automato
    if File.exist? file_name
      automata_file = File.open(file_name, 'r')
    else
      puts 'Arquivo não existe, finalizando programa.'
      return
    end

    # Pegando arquivo que contém as entradas do automato
    print 'Digite o nome do arquivo que possui as entradas para o automato: '
    #file_name = './test/' + gets.chomp + '.txt'
    file_name = "./test/eaf11.txt"

    # Se o arquivo existir, começamos a construir o automato
    if File.exist? file_name
      entry_file = File.open(file_name, 'r')
    else
      puts 'Arquivo não existe, finalizando programa.'
      return
    end

    puts ''

    # Instanciando simulador e começando simulação
    simulator = Simulator.new(track, type, automata_file, entry_file)
    simulator.run

  end

  # Rodando Main
  Main.new.run

end
