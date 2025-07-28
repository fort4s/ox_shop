local ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function()
    for shopId, shop in pairs(Config.Shops) do
        for i, location in ipairs(shop.locations) do
            if location.npc then
                RequestModel(GetHashKey(location.npc))
                while not HasModelLoaded(GetHashKey(location.npc)) do
                    Wait(100)
                end
                local npc = CreatePed(4, GetHashKey(location.npc), location.coords.x, location.coords.y, location.coords.z, location.coords.w, false, true)
                SetEntityInvincible(npc, true)
                SetBlockingOfNonTemporaryEvents(npc, true)
                SetEntityNoCollisionEntity(npc, PlayerPedId(), false)
                FreezeEntityPosition(npc, true)
                if location.emote then
                    TaskStartScenarioInPlace(npc, location.emote, 0, true)
                end
            end
            if shop.blipEnabled and location.blip then
                local blip = AddBlipForCoord(location.blip.x, location.blip.y, location.blip.z)
                SetBlipSprite(blip, location.sprite)
                SetBlipColour(blip, location.color)
                SetBlipScale(blip, location.scale)
                SetBlipAsShortRange(blip, location.shortRange)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString(location.blipName)
                EndTextCommandSetBlipName(blip)
            end
            exports.ox_target:addSphereZone({
                coords = location.coords.xyz,
                radius = Config.InteractionDistance,
                options = {
                    {
                        label = Config.InteractionLabel,
                        icon = 'fas fa-shopping-cart',
                        onSelect = function()
                            OpenShopMenu(shopId)
                        end
                    }
                }
            })
        end
    end
end)

function OpenShopMenu(shopId)
    local shop = Config.Shops[shopId]
    if not shop then
        if Config.Debug then
            print('Shop not found: ' .. shopId)
        end
        return
    end
    local menuOptions = {}
    for _, item in ipairs(shop.items) do
        table.insert(menuOptions, {
            title = item.label,
            description = ('Price: $%d'):format(item.price),
            icon = 'box',
            onSelect = function()
                local input = lib.inputDialog(('Buy %s'):format(item.label), {
                    {
                        type = 'number',
                        label = Locales['en'].quantity_prompt,
                        required = true,
                        min = 1,
                    }
                })
                if input and input[1] then
                    local quantity = tonumber(input[1])
                    if quantity and quantity >= 1 then
                        TriggerServerEvent('shopas:purchaseItem', shopId, item.name, quantity)
                    else
                        lib.notify({ description = Locales['en'].quantity_invalid, type = 'error', position = Config.Notifications.position, duration = Config.Notifications.duration })
                    end
                end
            end,
        })
    end
    lib.registerContext({
        id = 'shop_menu_' .. shopId,
        title = Locales['en'].shop_title:format(shop.name),
        options = menuOptions
    })
    lib.showContext('shop_menu_' .. shopId)
end

RegisterNetEvent('shopas:purchaseResult')
AddEventHandler('shopas:purchaseResult', function(success, message)
    if success then
        lib.notify({ description = message, type = 'success', position = Config.Notifications.position, duration = Config.Notifications.duration })
    else
        lib.notify({ description = message, type = 'error', position = Config.Notifications.position, duration = Config.Notifications.duration })
    end
end)