#INCLUDE 'TOTVS.CH'
//#INCLUDE 'FWMBROWSE'

user function fwmnavgdr()

local oBrowse

//criação do objeto do tipo browse
oBrowse := FWMBrowse():New

//definir qual a tabela que será apresentada no browse
oBrowse:SetAlias('SB1')

//definir o título ou a descrição que será apresentada no browse
oBrowse:SetDescription('Cadastro de produto')

//Realiza a tivação do oBrowse
oBrowse:Activate()



  
return 

