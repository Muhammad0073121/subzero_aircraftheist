Config = {}

-- Location of the robbery
Config.RobberyLocation = vector3(3089.673828, -4725.548340, 26.966164) -- Replace with actual coordinates


Config.RequiredItems = {
    { item = "trojan_usb", amount = 1 } -- Example: requires 1 USB
}

-- Progress bar duration (in seconds)
Config.ProgressBarDuration = 8

-- Animation details
Config.HackingAnimation = {
    dict = "anim@heists@ornate_bank@hack",
    clip = "hack_enter"
}

-- Lootable boxes near the robbery location
Config.LootableBoxes = {
    { coords = vector3(3124.472900, -4800.571289, 14.266785), reward = { item = 'goldbar', amount = 2 } },
    { coords = vector3(3111.460938, -4808.502930, 10.875221), reward = { item = 'cashbundle', amount = 5 } },
    { coords = vector3(3073.468262, -4825.130371, 14.276787), reward = { item = 'cashbundle', amount = 5 } },
    { coords = vector3(3057.418213, -4781.333496, 14.841407), reward = { item = 'cashbundle', amount = 5 } },
    { coords = vector3(3058.593994, -4783.166504, 14.276787), reward = { item = 'cashbundle', amount = 5 } },
    { coords = vector3(3113.758789, -4815.975586, 10.817505), reward = { item = 'diamond', amount = 1 } }, -- bombs
}

-- Robbery configuration
Config.RequiredPolice = 0
Config.RobberyDuration = 10 -- 10 minutes
Config.Cooldown = 20        -- 4 hours
