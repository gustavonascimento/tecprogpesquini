#language: pt

Funcionalidade: Visualizar Grafico por Tipo de Sanções e por estados com mais sanções
  Ao usuario visualizar as estatisticas, ele poderá ver um grafico de pizza com os numeros por tipo de sanção e outro grafico de barras com os estados que sofreram maior numero de sanções .

Cenario: Ver grafico de sanções por tipo

Dado que eu estou na pagina "/statistics"
Quando eu clico no link "Clique aqui para ser redirecionado para a página..."
Entao eu vejo o texto "Filtrar sanções por Estado:"

Cenário: Ver grafico de estados com mais sanções

Dado que eu estou na pagina "/statistics"
Quando eu clico no link "Clique aqui para ser redirecionado para a página."
Entao eu vejo o texto "Filtrar sanções por Ano:"
