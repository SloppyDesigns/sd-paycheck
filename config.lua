Config = {}
Config.Debug = false
Config.Target = 'qb-target' -- qb-target / qtarget

-- Framework Detection
if GetResourceState('es_extended') == 'started' then
    Config.Framework = "ESX"
elseif GetResourceState('qb-core') == 'started' then
    Config.Framework = "QBCore"
end

-- Notification
local isServer = IsDuplicityVersion()
if isServer then
    Config.Notification = function(source, title, message, length, type)
        TriggerClientEvent('sd-notify:Notify', source, title, message, length, type)
    end
else
    Config.Notification = function(title, message, length, type)
        exports['sd-notify']:Notify(title, message, length, type)
    end
end

-- Pay Paycheck in Cash other wise deposited to bank
Config.CashOut = false

-- Collect Paycheck on a specific Day
-- -1 = Disabled
--  0 = Sunday  
--  1 = Monday  
--  2 = Tuesday  
--  3 = Wednesday  
--  4 = Thursday  
--  5 = Friday  
--  6 = Saturday
Config.PayCheckDay = -1

-- Using Ped
Config.UsePed = true
Config.Ped = 'ig_lifeinvad_02'
Config.PedCoords = vector4(-1078.77, -244.78, 36.76, 163.08)

-- Using BoxZone
Config.BoxZone = vector3(-1082.73, -246.56, 37.76)
Config.BoxZoneLength = 5
Config.BoxZoneWidth = 2
Config.BoxZoneHeading = 300
Config.BoxZoneMaxZ = 36.76
Config.BoxZoneMinZ = 38.76