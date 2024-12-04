local snowballSpawned = false
local snowballZones = {}

CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local pedID = PlayerId()

        if not snowballSpawned then
            -- Remove existing zones
            for _, zone in pairs(snowballZones) do
                exports.ox_target:removeZone(zone.id)
            end
            snowballZones = {}

            -- Generate new zones
            local zoneCount = Config.Snowball.ZoneCount
            local offset = 2.0
            local spawnLocations = {}

            for i = 1, zoneCount do
                local angle = math.rad((math.random(320, 360) / zoneCount) * i)
                local spawnX = pedCoords.x + offset * math.sin(angle) + math.random(1, 5)
                local spawnY = pedCoords.y + offset * math.cos(angle) + math.random(1, 5)
                local spawnZ = pedCoords.z - 0.9
                table.insert(spawnLocations, { coords = vector3(spawnX, spawnY, spawnZ), id = tostring(i) })
            end

            -- Create snowball zones
            for _, location in ipairs(spawnLocations) do
                local zoneId = exports.ox_target:addSphereZone({
                    coords = location.coords,
                    radius = 0.9,
                    debug = Config.Snowball.DebugMode,
                    options = {
                        {
                            name = 'Snowball Zone',
                            icon = 'fas fa-snowflake',
                            label = Config.Locales.PickupLabel,
                            onSelect = function()
                                local zone = snowballZones[location.id]
                                if zone then
                                    local collected = lib.progressBar({
                                        duration = Config.Snowball.CollectTime,
                                        anim = {
                                            dict = 'anim@mp_snowball',
                                            clip = 'pickup_snowball',
                                        },
                                        prop = {
                                            model = `w_ex_snowball`,
                                            pos = vec3(0.03, 0.03, 0.02),
                                            rot = vec3(0.0, 0.0, -1.5)
                                        },
                                        label = Config.Locales.ProgressLabel,
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = Config.Snowball.PreventMovement,
                                        },
                                    })
                                    if collected then
                                        ESX.TriggerServerCallback('ham-snowball:addSnowballItem', function(success)
                                            if success then
                                                lib.notify({
                                                    title = Config.Locales.NotificationTitle,
                                                    description = Config.Locales.SuccessMessage,
                                                    position = Config.Locales.NotificationPosition,
                                                    icon = Config.Locales.NotificationIcon,
                                                    type = 'success'
                                                })
                                                exports.ox_target:removeZone(zone.id)
                                            else
                                                lib.notify({
                                                    title = Config.Locales.NotificationTitle,
                                                    description = Config.Locales.ErrorMessage,
                                                    position = Config.Locales.NotificationPosition,
                                                    icon = Config.Locales.NotificationIcon,
                                                    type = 'error'
                                                })
                                            end
                                        end)
                                    end
                                end
                            end
                        }
                    },
                    distance = Config.Snowball.InteractionDistance
                })
                snowballZones[location.id] = { id = zoneId, coords = location.coords }
            end

            snowballSpawned = true
            Wait(Config.Snowball.RefreshInterval)

            for _, zone in pairs(snowballZones) do
                exports.ox_target:removeZone(zone.id)
            end

            if GetSelectedPedWeapon(ped) == GetHashKey('WEAPON_SNOWBALL') then
                SetPlayerWeaponDamageModifier(pedID, 0.0)
            end

            snowballSpawned = false
        end
    end
end)