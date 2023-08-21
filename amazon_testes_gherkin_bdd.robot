*** Settings ***

Documentation      Essa suíte testa o site da Amazon
Resource           amazon_resources.robot
Test Setup         Abrir o navegador
Test Teardown      Fechar o navegador

*** Test Cases ***
Caso Test 01 - Acesso ao menu "Eletrônicos"
    [Documentation]     Esse teste verifica o menu eletronicos do site da Amazon.com.br
    ...                 e verifica a categoria Computadores e informatica
    [Tags]              menus  categorias
    Dado que estou na home page da Amazon.com.br
    Quando acessar o menu "Eletrônicos"
    Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    E a categoria "Computadores e Informática" deve ser exibida na página


Caso Test 02 - Pesquisa de um Produto
    [Documentation]         Esse teste verifica a busca de um produto
    [Tags]                  busca_produtos  lista_busca
    Dado que estou na home page da Amazon.com.br
    Quando pesquisar pelo produto "Xbox Series S"
    Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    E um produto da linha "Xbox Series S" deve ser mostrado na página
  