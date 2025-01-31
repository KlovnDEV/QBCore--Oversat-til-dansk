
local QBCore = exports['norskpixel-core']:GetCoreObject()

-- AFK Kick Time Limit (in seconds)

local group = 'user'
local secondsUntilKick = 1800
local isLoggedIn = LocalPlayer.state['isLoggedIn']

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('norskpixel-afkkick:server:GetPermissions', function(UserGroup)
        group = UserGroup
    end)
end)

RegisterNetEvent('QBCore:Client:OnPermissionUpdate')
AddEventHandler('QBCore:Client:OnPermissionUpdate', function(UserGroup)
    group = UserGroup
end)

-- Code
Citizen.CreateThread(function()
	while true do
		Wait(1000)
        playerPed = PlayerPedId()
        if isLoggedIn then
            if group == 'user' then
                currentPos = GetEntityCoords(playerPed, true)
                if prevPos ~= nil then
                    if currentPos == prevPos then
                        if time ~= nil then
                            if time > 0 then
                                if time == (900) then
                                    QBCore.Functions.Notify('Du er AFK, og vil få et kick om ' .. math.ceil(time / 60) .. ' minutter!', 'error', 10000)
                                elseif time == (600) then
                                    QBCore.Functions.Notify('Du er AFK, og vil få et kick om ' .. math.ceil(time / 60) .. ' minutter!', 'error', 10000)
                                elseif time == (300) then
                                    QBCore.Functions.Notify('Du er AFK, og vil få et kick om ' .. math.ceil(time / 60) .. ' minutter!', 'error', 10000)
                                elseif time == (150) then
                                    QBCore.Functions.Notify('Du er AFK, og vil få et kick om ' .. math.ceil(time / 60) .. ' minutter!', 'error', 10000)   
                                elseif time == (60) then
                                    QBCore.Functions.Notify('Du er AFK, og vil få et kick om ' .. math.ceil(time / 60) .. ' minut!', 'error', 10000) 
                                elseif time == (30) then
                                    QBCore.Functions.Notify('Du er AFK, og vil få et kick om ' .. time .. ' sekunder!', 'error', 10000)  
                                elseif time == (20) then
                                    QBCore.Functions.Notify('Du er AFK, og vil få et kick om ' .. time .. ' sekunder!', 'error', 10000)    
                                elseif time == (10) then
                                    QBCore.Functions.Notify('Du er AFK, og vil få et kick om ' .. time .. ' sekunder!', 'error', 10000)                                                                                                            
                                end
                                time = time - 1
                            else
                                TriggerServerEvent('KickForAFK')
                            end
                        else
                            time = secondsUntilKick
                        end
                    else
                        time = secondsUntilKick
                    end
                end
                prevPos = currentPos
            end
        end
    end
end)