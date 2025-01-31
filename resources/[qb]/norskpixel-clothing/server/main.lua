local QBCore = exports['norskpixel-core']:GetCoreObject()


RegisterServerEvent("doj:server:payForClothing", function(args)
    local args = tonumber(args)
    local Player = QBCore.Functions.GetPlayer(source)
    local cash = Player.Functions.GetMoney('cash')
    local bank = Player.Functions.GetMoney('bank')
    local cashAmount = Config.Cost.ClothingCash
    local bankAmount = Config.Cost.ClothingBank

    if args == 1 then 
        if tonumber(cashAmount) <= cash then
            Player.Functions.RemoveMoney('cash', tonumber(cashAmount))
            TriggerClientEvent('doj:client:accessShop', source, 1)
            TriggerClientEvent('QBCore:Notify', source, "Payed $"..cashAmount)
        else 
            TriggerClientEvent('QBCore:Notify', source, "You dont have enough cash", "error")
        end
    else
        if tonumber(bankAmount) <= bank then
            Player.Functions.RemoveMoney('bank', tonumber(bankAmount))
            TriggerClientEvent('doj:client:accessShop', source, 1)
            TriggerClientEvent('QBCore:Notify', source, "Payed $"..bankAmount)
        else 
            TriggerClientEvent('QBCore:Notify', source, "You dont have enough in the bank", "error")
        end
    end
end)


RegisterServerEvent("doj:server:payForBarber", function(args)
    local args = tonumber(args)
    local Player = QBCore.Functions.GetPlayer(source)
    local cash = Player.Functions.GetMoney('cash')
    local bank = Player.Functions.GetMoney('bank')
    local cashAmount = Config.Cost.BarberCash
    local bankAmount = Config.Cost.BarberBank
    if args == 1 then 
        if tonumber(cashAmount) <= cash then
            Player.Functions.RemoveMoney('cash', tonumber(cashAmount))
            TriggerClientEvent('doj:client:accessShop', source, 2)
            TriggerClientEvent('QBCore:Notify', source, "Payed $"..cashAmount)
        else 
            TriggerClientEvent('QBCore:Notify', source, "You dont have enough cash", "error")
        end
    else
        if tonumber(bankAmount) <= bank then
            Player.Functions.RemoveMoney('bank', tonumber(bankAmount))
            TriggerClientEvent('doj:client:accessShop', source, 2)
            TriggerClientEvent('QBCore:Notify', source, "Payed $"..bankAmount)
        else 
            TriggerClientEvent('QBCore:Notify', source, "You dont have enough in the bank", "error")
        end
    end
end)


RegisterServerEvent("doj:server:payForSurgeon", function(args)
    local args = tonumber(args)
    local Player = QBCore.Functions.GetPlayer(source)
    local cash = Player.Functions.GetMoney('cash')
    local bank = Player.Functions.GetMoney('bank')
    local cashAmount = Config.Cost.SurgeonCash
    local bankAmount = Config.Cost.SurgeonBank
    if args == 1 then 
        if tonumber(cashAmount) <= cash then
            Player.Functions.RemoveMoney('cash', tonumber(cashAmount))
            TriggerClientEvent('doj:client:accessShop', source, 3)
            TriggerClientEvent('QBCore:Notify', source, "Payed $"..cashAmount)
        else 
            TriggerClientEvent('QBCore:Notify', source, "You dont have enough cash", "error")
        end
    else
        if tonumber(bankAmount) <= bank then
            Player.Functions.RemoveMoney('bank', tonumber(bankAmount))
            TriggerClientEvent('doj:client:accessShop', source, 3)
            TriggerClientEvent('QBCore:Notify', source, "Payed $"..bankAmount)
        else 
            TriggerClientEvent('QBCore:Notify', source, "You dont have enough in the bank", "error")
        end
    end
end)




RegisterServerEvent("norskpixel-clothing:saveSkin")
AddEventHandler('norskpixel-clothing:saveSkin', function(model, skin)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if model ~= nil and skin ~= nil then
        -- TODO: Update primary key to be citizenid so this can be an insert on duplicate update query
        exports.oxmysql:execute('DELETE FROM playerskins WHERE citizenid = ?', { Player.PlayerData.citizenid }, function()
            exports.oxmysql:insert('INSERT INTO playerskins (citizenid, model, skin, active) VALUES (?, ?, ?, ?)', {
                Player.PlayerData.citizenid,
                model,
                skin,
                1
            })
        end)
    end
end)

RegisterServerEvent("norskpixel-clothes:loadPlayerSkin")
AddEventHandler('norskpixel-clothes:loadPlayerSkin', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = exports.oxmysql:executeSync('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', { Player.PlayerData.citizenid, 1 })
    if result[1] ~= nil then
        TriggerClientEvent("norskpixel-clothes:loadSkin", src, false, result[1].model, result[1].skin)
    else
        TriggerClientEvent("norskpixel-clothes:loadSkin", src, true)
    end
end)

RegisterServerEvent("norskpixel-clothes:saveOutfit")
AddEventHandler("norskpixel-clothes:saveOutfit", function(outfitName, model, skinData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if model ~= nil and skinData ~= nil then
        local outfitId = "outfit-"..math.random(1, 10).."-"..math.random(1111, 9999)
        exports.oxmysql:insert('INSERT INTO player_outfits (citizenid, outfitname, model, skin, outfitId) VALUES (?, ?, ?, ?, ?)', {
            Player.PlayerData.citizenid,
            outfitName,
            model,
            json.encode(skinData),
            outfitId
        }, function()
            local result = exports.oxmysql:executeSync('SELECT * FROM player_outfits WHERE citizenid = ?', { Player.PlayerData.citizenid })
            if result[1] ~= nil then
                TriggerClientEvent('norskpixel-clothing:client:reloadOutfits', src, result)
            else
                TriggerClientEvent('norskpixel-clothing:client:reloadOutfits', src, nil)
            end
        end)
    end
end)

RegisterServerEvent("norskpixel-clothing:server:removeOutfit")
AddEventHandler("norskpixel-clothing:server:removeOutfit", function(outfitName, outfitId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    exports.oxmysql:execute('DELETE FROM player_outfits WHERE citizenid = ? AND outfitname = ? AND outfitId = ?', {
        Player.PlayerData.citizenid,
        outfitName,
        outfitId
    }, function()
        local result = exports.oxmysql:executeSync('SELECT * FROM player_outfits WHERE citizenid = ?', { Player.PlayerData.citizenid })
        if result[1] ~= nil then
            TriggerClientEvent('norskpixel-clothing:client:reloadOutfits', src, result)
        else
            TriggerClientEvent('norskpixel-clothing:client:reloadOutfits', src, nil)
        end
    end)
end)

QBCore.Functions.CreateCallback('norskpixel-clothing:server:getOutfits', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local anusVal = {}

    local result = exports.oxmysql:executeSync('SELECT * FROM player_outfits WHERE citizenid = ?', { Player.PlayerData.citizenid })
    if result[1] ~= nil then
        for k, v in pairs(result) do
            result[k].skin = json.decode(result[k].skin)
            anusVal[k] = v
        end
        cb(anusVal)
    end
    cb(anusVal)
end)
