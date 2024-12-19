data:extend({
    {
        type = "bool-setting",
        name = "nature-regeneration-enable",
        localised_name = {"", "Enable nature regeneration"},
        localised_description = {"", "This enables nature regeneration in game. Might be heavy for UPS on large worlds."},
        setting_type = "runtime-global",
        default_value = true
    }
})

data:extend({
    {
        type = "int-setting",
        name = "nature-regeneration-heal-rate",
        localised_name = {"", "Seconds between healing"},
        localised_description = {"", "Number of seconds between healing 1 point. Affects healing rate as well as performance."},
        setting_type = "runtime-global",
        minimum_value = 1,
        default_value = 5,
    }
})
