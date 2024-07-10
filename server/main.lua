local kickMessage = "You have been kicked for executing a protected event." -- Anti-trigger event for cheats?

RegisterServerEvent("renz_wetphone:damage")
AddEventHandler("renz_wetphone:damage", function()
    local _source = source
    local hasItem = exports.ox_inventory:GetItem(_source, Config.Phone, nil, true)

    if _source ~= nil then
        if hasItem > 0 then
            exports.ox_inventory:RemoveItem(_source, Config.Phone, 1)
            exports.ox_inventory:AddItem(_source, Config.WetPhone, 1)
            TriggerClientEvent('ox_lib:notify', source, { title = 'System', description = 'Oops! Your phone is wet.', position = 'center-right', type = 'inform', duration = 3000 })
        end
    else
        DropPlayer(_source, kickMessage)
    end
end)

RegisterServerEvent("renz_wetphone:fixphone:server")
AddEventHandler("renz_wetphone:fixphone:server", function()
    local _source = source
    local hasItem = exports.ox_inventory:GetItem(_source, Config.WetPhone, nil, true)
    local hasCash = exports.ox_inventory:GetItem(_source, "cash", nil, true)

    if _source ~= nil then
        if hasItem > 0 then
            if hasCash >= Config.FixPrice then
            exports.ox_inventory:RemoveItem(_source, Config.WetPhone, 1)
            exports.ox_inventory:RemoveItem(_source, "cash", Config.FixPrice)
            exports.ox_inventory:AddItem(_source, Config.Phone, 1)
            else
                TriggerClientEvent('ox_lib:notify', source, { title = 'System', description = 'You dont have enough cash.', position = 'center-right', type = 'error', duration = 3000 })
            end
        else
            TriggerClientEvent('ox_lib:notify', source, { title = 'System', description = 'You dont have wet phone.', position = 'center-right', type = 'error', duration = 3000 })
        end
    else
        DropPlayer(_source, kickMessage)
    end
end)    
