local ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('shopas:purchaseItem')
AddEventHandler('shopas:purchaseItem', function(shopId, itemName, quantity)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local shop = Config.Shops[shopId]
    if not shop then
        if Config.Debug then
            print('Shop not found: ' .. shopId)
        end
        return
    end
    local item = nil
    for _, v in ipairs(shop.items) do
        if v.name == itemName then
            item = v
            break
        end
    end
    if not item then
        if Config.Debug then
            print('Item not found: ' .. itemName .. ' in shop: ' .. shopId)
        end
        return
    end
    if not quantity or quantity < 1 then
        if Config.Debug then
            print('Invalid quantity: ' .. tostring(quantity) .. ' for item: ' .. itemName)
        end
        return
    end
    if item.requiresJob then
        local hasJob = false
        local playerJob = xPlayer.getJob().name
        if type(item.requiresJob) == 'string' then
            hasJob = playerJob == item.requiresJob
        elseif type(item.requiresJob) == 'table' then
            for _, job in ipairs(item.requiresJob) do
                if playerJob == job then
                    hasJob = true
                    break
                end
            end
        end
        if not hasJob then
            TriggerClientEvent('shopas:purchaseResult', src, false, Locales['en'].purchase_fail_job)
            return
        end
    end
    local totalPrice = item.price * quantity
    local money = xPlayer.getAccount(shop.moneyType).money
    if money >= totalPrice then
        xPlayer.removeAccountMoney(shop.moneyType, totalPrice)
        xPlayer.addInventoryItem(itemName, quantity)
        TriggerClientEvent('shopas:purchaseResult', src, true, Locales['en'].purchase_success:format(item.label, quantity, totalPrice))
    else
        TriggerClientEvent('shopas:purchaseResult', src, false, Locales['en'].purchase_fail_money)
    end
end)