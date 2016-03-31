#language: pt

Funcionalidade: Visualizar ranking das empresas com mais sançoes

Cenario: Visualizar os rankings

Ao usuario acessar a pagina de estatisticas e selecionar a opçao "Empresas com mais sançoes", o sistema deve mostrar um ranking com os grupos de empresas com mais sançoes

Dado que eu estou na pagina "/"
Dado que eu visitei a pagina de estatisticas
Quando eu clico no link "Clique aqui para ser redirecionado para a página ."
Entao vejo o ranking dos grupos das empresas com mais sançoes

Cenario: Visualizar empresas dentro dos grupos do ranking

Dado que eu estou na pagina "/statistics/most_sanctioned_ranking"
Dado que a empresa COOPERSEMO exista
Quando eu clico no link "Grupo de Empresas com 32 sanções"
Entao vejo o nome de todas as empresas com 32 sanções
