require './automata'

class Main

  puts "",
       "Projeto PCS2427 - Simulação de Autômatos",
       "João Henrique Kersul Faria - 8041157",
       ""

  puts "Digite o nome do arquivo .txt que deseja carregar (não precisa colocar a extensão):"

  file_name = "../" + gets.chomp + ".txt"

  if File.exist? file_name
    Automata.construct(file_name)

    puts Automata.automata_data.to_s
  else
    puts "Arquivo não existe, finalizando programa."
  end


end