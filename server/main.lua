if Config.Framework == 'QBCore' then
    QBCore = exports['qb-core']:GetCoreObject()
end

if Config.Framework == 'QBCore' then
    RegisterNetEvent('sd-paycheck:server:CollectPaycheck', function()
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local result = MySQL.Sync.fetchScalar("SELECT paycheck FROM players WHERE citizenid = ?",
            { Player.PlayerData.citizenid })
        local paycheck = tonumber(result)
        if (paycheck > 0) then
            if Config.CashOut then
                Player.Functions.AddMoney('cash', paycheck)
                Config.Notification(src, 'Paycheck', 'Paycheck of $' .. paycheck .. ' has been collected.', 5000, 'success')
            else
                Player.Functions.AddMoney('bank', paycheck)
                Config.Notification(src, 'Paycheck', 'Paycheck of $' .. paycheck .. ' has been deposited into your account.', 5000, 'success')
            end
            MySQL.Async.execute("UPDATE players SET paycheck = ? WHERE citizenid = ?", { 0, Player.PlayerData.citizenid })
        else
            Config.Notification(src, 'Paycheck', 'Sorry, There is no paycheck to be collected', 5000, 'error')
        end
    end)
elseif Config.Framework == 'ESX' then
    RegisterNetEvent('sd-paycheck:server:CollectPaycheck', function()
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local result = MySQL.Sync.fetchScalar("SELECT paycheck FROM users WHERE identifier = ?", { xPlayer.identifier })
        local paycheck = tonumber(result)
        if (paycheck > 0) then
            if Config.CashOut then
                xPlayer.addMoney(paycheck)
                Config.Notification(src, 'Paycheck', 'Paycheck of $' .. paycheck .. ' has been collected.', 5000, 'success')
            else
                xPlayer.addAccountMoney('bank', paycheck)
                Config.Notification(src, 'Paycheck', 'Paycheck of $' .. paycheck .. ' has been deposited into your account.', 5000, 'success')
            end
            MySQL.Async.execute("UPDATE users SET paycheck = ? WHERE identifier = ?", { 0, xPlayer.identifier })
        else
            Config.Notification(src, 'Paycheck', 'Sorry, There is no paycheck to be collected', 5000, 'error')
        end
    end)
end

if Config.Framework == 'QBCore' then
    RegisterNetEvent('sd-paycheck:server:AddPaycheck', function(amount, player)
        local src = player
        if not src then return end
        local Player = QBCore.Functions.GetPlayer(src)
        MySQL.Async.execute("UPDATE players SET paycheck = paycheck + ? WHERE citizenid = ?", {amount, Player.PlayerData.citizenid})
    end)
elseif Config.Framework == 'ESX' then
    RegisterNetEvent('sd-paycheck:server:AddPaycheck', function(amount, player)
        local src = player
        if not src then return end
        local xPlayer = ESX.GetPlayerFromId(src)
        MySQL.Async.execute("UPDATE users SET paycheck = paycheck + ? WHERE identifier = ?", { amount, xPlayer.identifier })
    end)
end