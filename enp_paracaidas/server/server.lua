ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('enp_paracaidas:buy')
AddEventHandler('enp_paracaidas:buy', function(price)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if(xPlayer.getMoney() >= price) then
		xPlayer.removeMoney(price)
        TriggerClientEvent('enp_paracaidas:give', source)
    else
        xPlayer.showNotification('No tienes suficiente dinero')
	end
end)