QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('sd-paycheck:server:CollectPaycheck', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = MySQL.Sync.fetchScalar("SELECT paycheck FROM players WHERE citizenid = ?", {Player.PlayerData.citizenid})
    local paycheck = tonumber(result)
    if (paycheck > 0) then
        if Config.CashOut then
            Player.Functions.AddMoney('cash', paycheck)
            TriggerClientEvent("QBCore:Notify",src,"Paycheck of $"..paycheck.." has been collected.", "primary")
        else
            Player.Functions.AddMoney('bank', paycheck)
            TriggerClientEvent("QBCore:Notify",src,"Paycheck of $"..paycheck.." has been deposited into your account.", "primary")
        end
        MySQL.Async.execute("UPDATE players SET paycheck = ? WHERE citizenid = ?", {0, Player.PlayerData.citizenid})
    else
        TriggerClientEvent('QBCore:Notify', src, 'Sorry, There is no paycheck to be collected', 'error')
    end
end)

RegisterNetEvent('sd-paycheck:server:AddPaycheck', function(amount, player)
    local src = player
    if not src then return end
    local Player = QBCore.Functions.GetPlayer(src)
    MySQL.Async.execute("UPDATE players SET paycheck = paycheck + ? WHERE citizenid = ?", {amount, Player.PlayerData.citizenid})
end)