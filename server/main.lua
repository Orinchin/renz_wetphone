local kickMessage = "You have been kicked for executing a protected event." -- Anti-trigger event for cheats?

RegisterServerEvent("renz_wetphone:damage")
AddEventHandler("renz_wetphone:damage", function()
    local _source = source
    local hasItem = exports.ox_inventory:GetItem(_source, Config.Phone, nil, true)

    if _source ~= nil then
        if hasItem > 0 then
            exports.ox_inventory:RemoveItem(_source, Config.Phone, 1)
            exports.ox_inventory:AddItem(_source, Config.WetPhone, 1)
            TriggerClientEvent("showNotification", source)
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
                TriggerClientEvent("showNotification:noCash", source)
            end
        else
            TriggerClientEvent("showNotification:noPhone", source)
        end
    else
        DropPlayer(_source, kickMessage)
    end
end)    