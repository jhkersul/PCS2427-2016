require './automata'

class Main

  # Setando a codificação padrão do Ruby
  Encoding.default_internal = Encoding::UTF_8
  Encoding.default_external = Encoding::UTF_8

  # Começando programa
  puts "",
       "Projeto PCS2427 - Simulação de Autômatos",
       "João Henrique Kersul Faria - 8041157",
       ""

  puts "Digite o nome do arquivo .txt que deseja carregar (não precisa colocar a extensão):"

  # Pegando nome do arquivo do usuário
  file_name = "../" + gets.chomp + ".txt"

  # Se o arquivo existir, começamos a construir o automato
  if File.exist? file_name
    Automata.construct(file_name)
  else
    puts "Arquivo não existe, finalizando programa."
  end


end
