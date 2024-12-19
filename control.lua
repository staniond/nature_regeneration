--- Adds healing_amount to all nature entities (simple entities that are autoplaceable).
--- If healing_amount is nil, entities will be set to max_health
--- @param healing_amount integer?
function regenerate_nature(healing_amount)
    for _, surface in pairs(game.surfaces) do
        local entities = surface.find_entities_filtered({type = "simple-entity"})
        for _, entity in pairs(entities) do
            -- if entity is autoplaceable, it is considered nature
            if entity.prototype.autoplace_specification then
                if entity.valid and entity.health and entity.health < entity.max_health then
                    if healing_amount then
                        entity.health = math.min(entity.health + healing_amount, entity.max_health)
                    else
                        entity.health = entity.max_health
                    end
                end
            end
        end
    end
end

function regenerate_nature_event(event)
    regenerate_nature(1) -- heal all entities by 1
end

function regenerate_nature_full()
    regenerate_nature(nil) -- heal all entities to max health
end

function init_mod()
    local seconds_per_health_regen = settings.global["nature-regeneration-heal-rate"].value

    script.on_nth_tick(nil)
    if settings.global["nature-regeneration-enable"].value then
        script.on_nth_tick(seconds_per_health_regen * 60, regenerate_nature_event)
    end
end

commands.add_command("regenerate-nature",
                     { "", "Regenerates all nature to max health instantly." },
                     regenerate_nature_full)

-- init the mod on load and also when settings change
script.on_event(defines.events.on_runtime_mod_setting_changed, init_mod)
script.on_init(init_mod)
script.on_load(init_mod)
