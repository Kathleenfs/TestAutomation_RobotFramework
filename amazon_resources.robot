*** Settings ***
Library      SeleniumLibrary
Library    XML


*** Variables ***
${URL}    https://www.amazon.com.br/
${MENU_ELETRONICOS}    //a[@href='/Eletronicos-e-Tecnologia/b/?ie=UTF8&node=16209062011&ref_=nav_cs_electronics'][contains(.,'Eletrônicos')]
${HEADER_ELETRONICOS}    //h1[contains(.,'Eletrônicos e Tecnologia')]
${TEXTO_HEADER_ELETRONICOS}    Eletrônicos e Tecnologia 
${excluir}       //input[contains(@name,'submit.delete.C7c7abeac-7d03-4da8-81e8-93a650401c67')]

*** Keywords ***

Abrir o navegador
    Open Browser   browser=chrome  options=add_experimental_option("detach", True)
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Close Browser

Acessar a home page do site Amazon.com.br
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=${MENU_ELETRONICOS}

Entrar no menu "Eletrônicos"
    Click Element    locator=${MENU_ELETRONICOS}

Verificar se aparece a frase "Eletrônicos e Tecnologia"
    Wait Until Page Contains         text=${TEXTO_HEADER_ELETRONICOS}
    Wait Until Element Is Visible    locator=${HEADER_ELETRONICOS} 

Verificar se o título da página fica "${TITULO}"
    Title Should Be    title=${TITULO}

Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible    locator=//img[contains(@alt,'${NOME_CATEGORIA}')]
    

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text    locator=twotabsearchtextbox    text=${PRODUTO}

Clicar no botão de pesquisa 
    Click Element    locator=nav-search-submit-button

Verificar o resultado da pesquisa, listando o produto "${PRODUTO}".

    Wait Until Element Is Visible    locator=//span[@class='a-size-base-plus a-color-base a-text-normal'][contains(.,'${PRODUTO}')]



# # GHERKIN STEPS
# Given (pt: Dado): Utilizado para especificar uma pré condição, dentro desse step é feita a validação de uma condição antes de se prosseguir para os próximos passos. Por se tratar de uma pré condição, normalmente vem escrito no passado;
# When (pt: Quando): Utilizado quando será executada uma ação de que se espera uma reação vinda do sistema, que será validada no step “Then”. Este passo vem escrito no presente;
# Then (pt: Então): Valida se o esperado aconteceu. Segue sempre um passo do tipo “Quando”, pois aqui é validada a reação da ação recebida. Por se tratar do resultado esperado, normalmente vem escrito na forma de futuro próximo;
# And (pt: E): Caso seja necessário mais uma interação com o sistema para complementar um fluxo, mas que não necessariamente se trata de uma ação ou reação, se utiliza “And”;
# But (pt: Mas): No geral serve a mesma funcionalidade do “And”, porém é normalmente utilizado após uma validação negativa depois do “Then”;
# Sabendo disso, podemos traduzir a nossa etapa de login no sistema XPTO para:

# Dado que “Fulano” possui uma conta no sistema
# E ele acessa a página de login
# E ele preenche suas credenciais válidas
# Quando ele aciona a opção de realizar login
# Então ele deve ser redirecionado para a página inicial logado

Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br
    Verificar se o título da página fica "Amazon.com.br | Tudo pra você, de A a Z."

Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"

Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    Verificar se o título da página fica "Eletrônicos e Tecnologia | Amazon.com.br"
E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se aparece a frase "Eletrônicos e Tecnologia"

E a categoria "Computadores e Informática" deve ser exibida na página
    Verificar se aparece a categoria "Computadores e Informática"

Quando pesquisar pelo produto "Xbox Series S"
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa 
Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    Verificar se o título da página fica "Amazon.com.br : Xbox Series S"
E um produto da linha "Xbox Series S" deve ser mostrado na página
    Verificar o resultado da pesquisa, listando o produto "Console Xbox Series S".

#case 4
Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"
    Verificar o resultado da pesquisa, listando o produto "Console Xbox Series S".

Adicionar o produto "Console Xbox Series S" no carrinho
    Click Element    locator=//span[@class='a-size-base-plus a-color-base a-text-normal'][contains(.,'Console Xbox Series S')]
    Wait Until Element Is Visible     locator=//input[contains(@name,'submit.add-to-cart')]
    Click Element    locator=add-to-cart-button

Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso
  Click Element    locator=//a[contains(@data-csa-c-type,'button')]
  Wait Until Element Is Visible     locator=//span[@class='a-truncate-cut'][contains(.,'Console Xbox Series S')]


 Remover o produto "Console Xbox Series S" do carrinho
  
     Click Element    locator=${excluir}

Verificar se o carrinho fica vazio
    Wait Until Element Is Visible    locator= //h1[@class='a-spacing-mini a-spacing-top-base'][contains(.,'Seu carrinho de compras da Amazon está vazio.')]