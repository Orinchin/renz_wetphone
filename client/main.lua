Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1000)
    local ped = PlayerPedId()
    if IsPedSwimming(ped) then
        TriggerServerEvent("renz_wetphone:damage")
    end
   end
end)

Citizen.CreateThread(function()
    local npc = nil
    local isNearby = false

    while true do
        Citizen.Wait(1000)

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        local model = Config.Model
        local x, y, z, h = Config.Coords
        local heading = Config.Heading 

        local spawnDistance = Config.SpawnDistance

        local distance = GetDistanceBetweenCoords(playerCoords, x, y, z, h, true)

        if distance <= spawnDistance and not isNearby then
            RequestModel(model)
            while not HasModelLoaded(model) do
                Citizen.Wait(10)
            end
            npc = CreatePed(4, model, x, y, z, h, false, true)

            SetPedFleeAttributes(npc, 0, 0)
            SetPedDropsWeaponsWhenDead(npc, false)
            SetPedDiesWhenInjured(npc, false)
            SetEntityInvincible(npc , true)
            SetBlockingOfNonTemporaryEvents(npc, true)
            Wait(1000)
            TaskStartScenarioInPlace(npc, "WORLD_HUMAN_STAND_MOBILE", 0, true)
            FreezeEntityPosition(npc, true)

            isNearby = true
        elseif distance > spawnDistance and isNearby then
            if DoesEntityExist(npc) then
                DeleteEntity(npc)
                npc = nil
            end
            isNearby = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        local sleep = 1000
        local coords = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(coords, Config.Coords.x, Config.Coords.y, Config.Coords.z, true)

        if distance <= Config.SpawnDistance then
            sleep = 0
            Draw3DText(Config.Coords.x, Config.Coords.y, Config.Coords.z, "[E] Phone Repair")
            if IsControlJustPressed(0, 46) then
                TriggerEvent('renz_wetphone:fixphone')
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent("renz_wetphone:fixphone")
AddEventHandler("renz_wetphone:fixphone", function()
    TriggerServerEvent("renz_wetphone:fixphone:server")
end)    

-- I just want to use ox_lib for notifications lol

RegisterNetEvent("showNotification")
AddEventHandler("showNotification", function(source)
    lib.notify({
        description = 'Oops! Your phone is wet.',
        type = 'inform'
    })
end)

RegisterNetEvent("showNotification:noCash")
AddEventHandler("showNotification:noCash", function(source)
    lib.notify({
        description = 'You dont have enough cash.',
        type = 'error'
    })
end)

RegisterNetEvent("showNotification:noPhone")
AddEventHandler("showNotification:noPhone", function(source)
    lib.notify({
        description = 'You dont have wet phone.',
        type = 'error'
    })
end)

Citizen.CreateThread(function()
    local blipPos = vector3(Config.Coords)
    local blip = AddBlipForCoord(blipPos.x, blipPos.y, blipPos.z)
    SetBlipSprite(blip, 521)
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 42)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Repair Phone")
    EndTextCommandSetBlipName(blip)
end)

function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end