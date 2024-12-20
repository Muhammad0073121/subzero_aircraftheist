IsRobberyActive = false
QBCore = exports['qb-core']:GetCoreObject()

-- Add the robbery start zone
exports.ox_target:addSphereZone({
    coords = Config.RobberyLocation,
    radius = 2.0,
    debug = false,
    options = {
        {
            name = 'start_robbery',
            label = 'Start Robbery',
            icon = 'fa-solid fa-sack-dollar',
            event = 'custom-robbery:startHacking',
            canInteract = function(entity, distance, zone)
                return not IsRobberyActive
            end
        }
    }
})

RegisterNetEvent('custom-robbery:startHacking', function(data)
    if lib.progressBar({
            duration = Config.ProgressBarDuration * 1000,
            label = 'Hacking...',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                movement = true,
                combat = true,
                mouse = false
            },
            anim = Config.HackingAnimation,
        }) then
        TriggerServerEvent('custom-robbery:startRobberyAttempt')
    else
        QBCore.Functions.Notify('Robbery Cancelled', 'error')
    end
end)

-- Start robbery event
RegisterNetEvent('custom-robbery:startRobbery', function(duration)
    IsRobberyActive = true
    QBCore.Functions.Notify('Robbery started! Defend the location for ' .. duration / 60 .. ' minutes!', 'success')

    -- Notify players when the robbery ends
    SetTimeout(duration * 1000, function()
        QBCore.Functions.Notify('Boxes are now lootable!', 'success')
    end)
end)

-- Add lootable boxes globally
RegisterNetEvent('custom-robbery:spawnLootBoxes', function(lootBoxes)
    for i, box in ipairs(lootBoxes) do
        exports.ox_target:addSphereZone({
            coords = box.coords,
            radius = 1.0,
            debug = false,
            options = {
                {
                    name = 'loot_box_' .. i,
                    label = 'Loot Box',
                    icon = 'fa-solid fa-box',
                    serverEvent = 'custom-robbery:lootBox',
                    args = { index = i },
                    canInteract = function(entity, distance, zone)
                        return true
                    end
                }
            }
        })
    end
end)

-- End robbery event
RegisterNetEvent('custom-robbery:endRobbery', function()
    IsRobberyActive = false
end)



-- Remove loot box globally
RegisterNetEvent('custom-robbery:removeLootBox', function(zone)
    exports.ox_target:removeZone(zone)
end)
