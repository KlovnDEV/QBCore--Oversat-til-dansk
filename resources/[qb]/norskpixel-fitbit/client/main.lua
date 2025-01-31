
local QBCore = exports['norskpixel-core']:GetCoreObject()

local inWatch = false

-- Functions

function openWatch()
    SendNUIMessage({
        action = "openWatch",
        watchData = {}
    })
    SetNuiFocus(true, true)
    inWatch = true
end

local function openWatch()
    SetNuiFocus(false, false)
end

local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- Events

RegisterNUICallback('close', function()
    closeWatch()
end)

RegisterNetEvent('norskpixel-fitbit:use', function()
    openWatch()
end)

RegisterNUICallback('setFoodWarning', function(data)
    local foodValue = tonumber(data.value)

    TriggerServerEvent('norskpixel-fitbit:server:setValue', 'food', foodValue)

    QBCore.Functions.Notify('Fitbit: Sult advarsel sat til '..foodValue..'%')
end)

RegisterNUICallback('setThirstWarning', function(data)
    local thirstValue = tonumber(data.value)

    TriggerServerEvent('norskpixel-fitbit:server:setValue', 'thirst', thirstValue)

    QBCore.Functions.Notify('Fitbit: Tørst advarsel sat til '..thirstValue..'%')
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5 * 60 * 1000)
        if LocalPlayer.state.isLoggedIn then
            QBCore.Functions.TriggerCallback('norskpixel-fitbit:server:HasFitbit', function(hasItem)
                if hasItem then
                    local PlayerData = QBCore.Functions.GetPlayerData()
                    if PlayerData.metadata["fitbit"].food ~= nil then
                        if PlayerData.metadata["hunger"] < PlayerData.metadata["fitbit"].food then
                            --TriggerEvent("chatMessage", "FITBIT ", "warning", "Din sult er på "..round(PlayerData.metadata["hunger"], 2).."%")
                            QBCore.Functions.Notify("Fitbit: Din sult er på "..round(PlayerData.metadata["hunger"], 2).."%", "error", 3500)
                            PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
                        end
                    end
                    if PlayerData.metadata["fitbit"].thirst ~= nil then
                        if PlayerData.metadata["thirst"] < PlayerData.metadata["fitbit"].thirst  then
                            --TriggerEvent("chatMessage", "FITBIT ", "warning", "Din tørst er på "..round(PlayerData.metadata["thirst"], 2).."%")
                            QBCore.Functions.Notify("Fitbit: Din tørst er på "..round(PlayerData.metadata["thirst"], 2).."%", "error", 3500)
                            PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
                        end
                    end
                end
            end, "fitbit")
        end
    end
end)