ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end 

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end
end)

Citizen.CreateThread(
    function()
        for k, v in pairs(Config['Parachute']) do
            blip = AddBlipForCoord(vector3(454.13, 5572.22, 780.18))
            SetBlipSprite(blip, 377)
            SetBlipScale(blip, 0.9)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Actividad | Paracaidismo')
            EndTextCommandSetBlipName(blip)
        end
    end
)

Citizen.CreateThread(
    function()
    while true do
            local _msec = 250
            for k, v in pairs(Config['Parachute']) do
                local _ply = PlayerPedId()
                local _plyCoords = GetEntityCoords(_ply)
                local _dist = Vdist(_plyCoords, v.x, v.y, v.z, true)

                if _dist < 3 then
                    _msec = 0
                    ESX.ShowFloatingHelpNotification('Pulsa ~r~E~w~ para iniciar la actividad de paracaidismo', vector3(v.x, v.y, v.z + 2))
                    DrawMarker(1, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 0.2, 255,255,255, 100, false, true, 2, false, false, false, false)
                    if IsControlJustPressed(0, 38) then 
                        GiveParachute()
                    end
                end
            end
            Citizen.Wait(_msec)
        end
    end
)

RegisterNetEvent('enp_paracaidas:give')
AddEventHandler('enp_paracaidas:give', 
    function(source)
        local _ply = PlayerPedId()
        GiveWeaponToPed(_ply, GetHashKey("GADGET_PARACHUTE"), 150, true, true) 
    end
)

GiveParachute = function()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'enp_paracaidas',
		{
			title    = 'Bienvenido/a a la actividad de paracaidismo',
			align    = 'bottom-right',
			elements = {
				{label = 'Comprar Paracidas (1500$)', value = 'yes', price = 1500},
                {label = 'No quiero saltar', value = 'no'},
			}
		},
		function(data, menu)
			local price = data.current.price
            local _val = data.current.value
            if _val == 'yes' then 
                ESX.ShowNotification('Has comprado un paracaidas disfruta de tu salto.')
                TriggerServerEvent('enp_paracaidas:buy', price)
            elseif _val == 'no' then 
                ESX.ShowNotification('La proxima vez será hasta pronto.')
                menu.close()
            end
            
		end,
	function(data, menu)
		menu.close()
	end)
end