RobberyInProgress = false
local lastRobberyTime = 0
LootBoxes = {}
CurrentCops = 0
QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('custom-robbery:startRobberyAttempt', function()
    local source = source
    local xPlayer = QBCore.Functions.GetPlayer(source)

    for _, item in ipairs(Config.RequiredItems) do
        if xPlayer.Functions.GetItemByName(item.item).count < item.amount then
            TriggerClientEvent('QBCore:Notify', source, 'You do not have the required items!', 'error')
            return
        end
    end

    for _, item in ipairs(Config.RequiredItems) do
        xPlayer.Functions.RemoveItem(item.item, item.amount)
    end


    if RobberyInProgress then
        TriggerClientEvent('QBCore:Notify', source, 'Robbery is already in progress!', 'error')
        return
    end

    if CurrentCops < Config.RequiredPolice then
        TriggerClientEvent('QBCore:Notify', source, 'Not enough police on duty!', 'error')
        return
    end

    local currentTime = os.time()
    if currentTime - lastRobberyTime < Config.Cooldown then
        TriggerClientEvent('QBCore:Notify', source, 'Robbery is on cooldown!', 'error')
        return
    end

    -- Start robbery
    RobberyInProgress = true
    lastRobberyTime = currentTime
    TriggerClientEvent('custom-robbery:startRobbery', -1, Config.RobberyDuration)

    -- Spawn lootable boxes when the robbery ends
    LootBoxes = Config.LootableBoxes
    SetTimeout(Config.RobberyDuration * 1000, function()
        RobberyInProgress = false
        TriggerClientEvent('custom-robbery:spawnLootBoxes', -1, LootBoxes)
        TriggerClientEvent('custom-robbery:endRobbery', -1)
    end)
end)

-- Handle loot box interaction
RegisterNetEvent('custom-robbery:lootBox', function(data)
    local source = source
    local xPlayer = QBCore.Functions.GetPlayer(source)

    local index = data.args.index
    local box = Config.LootableBoxes[index]
    if not box then return end

    local reward = box.reward
    xPlayer.Functions.AddItem(reward.item, reward.amount)
    TriggerClientEvent('QBCore:Notify', source, 'You looted a box!', 'success')

    -- Remove the looted box from the global list
    LootBoxes[index] = nil
    TriggerClientEvent('custom-robbery:removeLootBox', -1, data.zone)
end)
