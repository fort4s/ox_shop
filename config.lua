Config = {
    InteractionDistance = 2.5,
    InteractionLabel = 'Open Shop',
    Debug = false,
    Notifications = { position = 'top-right', duration = 3000 },
    Shops = {
        convenience = {
            name = 'Convenience Store',
            moneyType = 'money',
            blipEnabled = true,
            items = {
                { name = 'bread', label = 'Bread', price = 5 },
                { name = 'water', label = 'Water', price = 3 },
                { name = 'cola', label = 'eCola', price = 4 },
            },
            locations = {
                {
                    npc = 's_m_y_shop_mask',
                    coords = vector4(25.73, -1345.57, 29.5, 270.0),
                    emote = 'WORLD_HUMAN_GUARD_STAND',
                    blip = vector3(25.73, -1345.57, 29.5),
                    sprite = 59,
                    color = 2,
                    scale = 0.8,
                    blipName = 'Convenience Store',
                    shortRange = true,
                },
                {
                    npc = 's_m_y_shop_mask',
                    coords = vector4(1728.66, 6415.44, 35.04, 242.95),
                    emote = 'WORLD_HUMAN_GUARD_STAND',
                    blip = vector3(1728.66, 6415.44, 35.04),
                    sprite = 59,
                    color = 2,
                    scale = 0.8,
                    blipName = 'Convenience Store (Paleto)',
                    shortRange = true,
                },
            },
        },
        weaponshop = {
            name = 'Ammu-Nation',
            moneyType = 'bank',
            blipEnabled = false,
            items = {
                { name = 'WEAPON_PISTOL', label = 'Pistol', price = 5000 },
                { name = 'ammo-pistol', label = 'Pistol Ammo', price = 50 },
            },
            locations = {
                {
                    npc = 's_m_m_ammucountry',
                    coords = vector4(21.75, -1106.49, 29.8, 160.0),
                    emote = 'WORLD_HUMAN_SMOKING',
                    blip = vector3(21.75, -1106.49, 29.8),
                    sprite = 110,
                    color = 1,
                    scale = 0.8,
                    blipName = 'Ammu-Nation',
                    shortRange = true,
                },
            },
        },
    },
}