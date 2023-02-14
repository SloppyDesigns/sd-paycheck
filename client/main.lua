QBCore = exports['qb-core']:GetCoreObject()

local function GetDayAsString(day)
    if day == 0 then return 'Sunday' end
    if day == 1 then return 'Monday' end
    if day == 2 then return 'Tuesday' end
    if day == 3 then return 'Wednesday' end
    if day == 4 then return 'Thursday' end
    if day == 5 then return 'Friday' end
    if day == 6 then return 'Saturday' end
end

CreateThread(function()
    if Config.UsePed then
        local hash = GetHashKey(Config.Ped)
        if not HasModelLoaded(hash) then
            RequestModel(hash)
            Wait(10)
        end
        while not HasModelLoaded(hash) do
            Wait(10)
        end
        local PayCheckNPC = CreatePed(5, hash, vector3(Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z), Config.PedCoords.w, false, false)
        FreezeEntityPosition(PayCheckNPC, true)
        SetEntityInvincible(PayCheckNPC, true)
        SetBlockingOfNonTemporaryEvents(PayCheckNPC, true)
        SetModelAsNoLongerNeeded(hash)
        TaskStartScenarioInPlace(PayCheckNPC, 'WORLD_HUMAN_HANG_OUT_STREET')

        exports[Config.Target]:AddEntityZone('PayCheckNPC', PayCheckNPC, {
            name = "PayCheckNPC",
            debugPoly = Config.Debug,
            useZ = true
        }, {
            options = {
                {
                    event = 'sd-paycheck:client:CollectPaycheck',
                    icon = "fas fa-money-check-dollar",
                    label = "Collect Paycheck",
                },
            },
            distance = 2.5
        })
    else
        exports[Config.Target]:AddBoxZone('PayCheckZone', Config.BoxZone, Config.BoxZoneLength, Config.BoxZoneWidth, {
            name = "PayCheckNPC",
            debugPoly = Config.Debug,
            heading = Config.BoxZoneHeading,
            minZ = Config.BoxZoneMaxZ,
            maxZ = Config.BoxZoneMinZ,
        }, {
            options = {
                {
                    event = 'sd-paycheck:client:CollectPaycheck',
                    icon = "fas fa-money-check-dollar",
                    label = "Collect Paycheck",
                },
            },
            distance = 2.5
        })
    end
end)

RegisterNetEvent('sd-paycheck:client:CollectPaycheck', function()
    if Config.PayCheckDay == -1 then
        TriggerServerEvent('sd-paycheck:server:CollectPaycheck')
    else
        local Today = GetClockDayOfWeek()
        if Today == Config.PayCheckDay then
            TriggerServerEvent('sd-paycheck:server:CollectPaycheck')
        else
            QBCore.Functions.Notify("Come Back " .. GetDayAsString(Config.PayCheckDay) .. " To Collect Your PayCheck", "error")
        end
    end
end)