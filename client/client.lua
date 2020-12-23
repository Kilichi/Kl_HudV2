-- ESX Library
ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
end)
-- Fin Config

-- Principal Event
RegisterNetEvent("Kl_Hud:updateStatus")
AddEventHandler("Kl_Hud:updateStatus", function(status)
    TriggerEvent('esx_status:getStatus', 'hunger', function(status)
        food = status.val / 10000
    end)
    TriggerEvent('esx_status:getStatus', 'thirst', function(status)
        thirst = status.val / 10000
    end)
    if (Config['Stress']) then
        TriggerEvent('esx_status:getStatus', 'stress', function(status)
            stress = status.val / 10000
        end)
    end
end)
-- End Principal Event

-- Principal Loop
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(Config['TickTime'])
        if (Config['HideMinimap']) then
            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                DisplayRadar(true)
            else
                DisplayRadar(false)
            end
        else
            DisplayRadar(true)
        end
        if (Config['Stress']) then
            localStress = stress
        else
            localStress = false
        end
		if (Config['PlayerID']) then
            localPlayerID = playerid
            playeridInput = GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))
        else
            localPlayerID = false
        end
        
        local hudPosition
        if IsPedSittingInAnyVehicle(PlayerPedId()) or not Config['HideMinimap'] then
            hudPosition = 'right'
        else
            hudPosition = 'left'
        end

        local fuelPosition
        local playerVeh = GetVehiclePedIsIn(PlayerPedId(), false)
        if (Config['Fuel']) then
        if IsPedSittingInAnyVehicle(PlayerPedId()) then
            fuelPosition = 'right'
            fuelEvent = GetVehicleFuelLevel(playerVeh);
        else 
            localPlayerID = false
        end
    end

        SendNUIMessage({
            hud = Config['Hud'];
            pauseMenu = IsPauseMenuActive();
            armour = GetPedArmour(PlayerPedId());
            health = GetEntityHealth(PlayerPedId())-100;
            food = food;
            thirst = thirst;
            stress = localStress;
            playerid = playeridInput;
            fuel = fuelEvent;
            hudPosition = hudPosition;
            fuelPosition = fuelPosition;
        })
    end
end)
-- End Principal Loop
