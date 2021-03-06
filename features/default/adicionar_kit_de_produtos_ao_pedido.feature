# http://www.pivotaltracker.com/story/show/791126
@gustavo
Feature: Adicionar kit de produtos ao pedido
  Como um vendedor
  Eu quero adicionar kit de produtos
  Para que eu possa realizar a venda e não precise selecionar os produtos individualmente

  Cenário: Adicionar produtos kit válido
    Dado que existe(m) registro(s) de produto com os seguintes dados:
      | id | descricao          | kit |
      | 1  | Kit de Teste       | sim |
      | 2  | Produto de Teste 1 | não |
      | 3  | Produto de Teste 2 | não |
    E que existe(m) registro(s) de produto kit com os seguintes dados:
      | produto id | item id | fator conversao | preco normal |
      | 1          | 2       | 4               | 10           |
      | 1          | 3       | 1               | 20           |
    E que existe um pedido
    E que estou em adicionar item ao pedido
    E seleciono o(a) produto "Kit de Teste"
    E defino quantidade como "1"
    Quando peço para salvar
    Então eu preciso ver os seguintes registros:
      | produto id | descricao      |  quantidade  |
      | 1          | Kit de Teste   |  1           |

  Cenário: Adicionar kit de produto inválido
    Dado que existe(m) registro(s) de produto com os seguintes dados:
      | id | descricao        | valor normal | emissao relatorio |
      | 1  | Produto de Teste | 736          | sim               |
    E que existe um pedido
    E que estou em adicionar item ao pedido
    E seleciono o(a) produto "Produto de Teste"
    E defino valor de venda como "100"  
    E defino percentual de desconto como "10"
    E defino quantidade como "1"
    Quando peço para salvar
    Então preciso ver "Item adicionado com sucesso ao pedido."
