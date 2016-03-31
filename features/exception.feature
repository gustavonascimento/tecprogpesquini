#language: pt

Funcionalidade: Tratar exceçoes

Cenário: Acessar uma rota invalida

Ao usuario tentar acessar uma rota invalida, uma exceçao deve surgir.

Dado que eu estou na pagina "/"
Quando o usuário digitar uma url inválida
Então o sistema deve mostrar uma mensagem de página não encontrada

Cenário: Acessar uma empresa que nao existe no banco

Ao usuario tentar acessar uma id de uma empresa que nao existe no banco, uma exceçao deve surgir.

Dado que eu estou na pagina "/"
Quando o usuário digitar uma id de uma empresa não existente no banco
Então o sistema deve mostrar uma mensagem de página não encontrada




