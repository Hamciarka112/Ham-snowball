Config = {}

Config.Snowball = {
    CollectTime = 3000, -- Collection time in milliseconds
    RefreshInterval = 5000, -- Refresh interval in milliseconds
    InteractionDistance = 2.0,
    DebugMode = false,
    ZoneCount = math.random(1, 6), -- Number of zones spawned around the player
    PreventMovement = true,
    ItemName = 'WEAPON_SNOWBALL',
    Amount = 1
}

Config.Locales = {
    PickupLabel = 'Pick up Snowball',
    ProgressLabel = 'Collecting Snowball...',
    NotificationTitle = 'Snowball',
    SuccessMessage = 'Snowball collected successfully!',
    ErrorMessage = 'Not enough space or an error occurred!',
    NotificationPosition = 'bottom',
    NotificationIcon = 'fas fa-snowflake',
}