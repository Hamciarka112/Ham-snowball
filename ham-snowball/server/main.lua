ESX.RegisterServerCallback('ham-snowball:addSnowballItem', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        local snowballItem = Config.Snowball.ItemName
        local snowballQuantity = Config.Snowball.Amount

        if xPlayer.canCarryItem(snowballItem, snowballQuantity) then
            xPlayer.addInventoryItem(snowballItem, snowballQuantity)
            cb(true) 
        else
            cb(false)
        end
    else
        cb(false)
    end
end)
