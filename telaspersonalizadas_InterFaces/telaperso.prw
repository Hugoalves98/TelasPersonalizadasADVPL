#INCLUDE 'TOTVS.CH'
//#INCLUDE 'FWMBROWSE'

user function fwmnavgdr()

local oBrowse

//cria��o do objeto do tipo browse
oBrowse := FWMBrowse():New

//definir qual a tabela que ser� apresentada no browse
oBrowse:SetAlias('SB1')

//definir o t�tulo ou a descri��o que ser� apresentada no browse
oBrowse:SetDescription('Cadastro de produto')

//Realiza a tiva��o do oBrowse
oBrowse:Activate()



  
return 

