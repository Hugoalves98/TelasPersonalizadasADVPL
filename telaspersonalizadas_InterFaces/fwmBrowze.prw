#INCLUDE "TOTVS.CH"
//#INCLUDE "FWMVCDEF.CH"


user function fwmNaveg()

local aArea := GetNextAlias()
local oBrowseSZ9 //Vari�vel Objeto q receber� o instanciamento da classe FWMBrowse

oBrowseSZ9 := FwmBrowse():New()

oBrowseSZ9:SetAlias("SA1")

oBrowseSZ9:SetDescription("Tela FWMBrowse")

oBrowseSZ9:Activate()

RestArea(aArea)

return


