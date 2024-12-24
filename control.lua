--- Nature entities are considered entities of type 'simple-entity' with
--- non-nil autoplace_specification (they are placed by the map generator)
--- The regenerate_nature function is UPS instensive, so the storage.nature_damaged flag exists -
--- regenerate_nature is only run when at least one nature entity is damaged.

--- Adds healing_amount to all nature entities (simple entities that are autoplaceable).
--- If healing_amount is nil, entities will be set to max_health.
--- Returns true if any entity was healed, false otherwise.
--- @param healing_amount integer?
--- @return boolean
function regenerate_nature(healing_amount)
    local healed = false
    for _, surface in pairs(game.surfaces) do
        local entities = surface.find_entities_filtered({type = "simple-entity"})
        for _, entity in pairs(entities) do
            -- if entity is autoplaceable, it is considered nature
            if entity.prototype.autoplace_specification then
                if entity.valid and entity.health and entity.health < entity.max_health then
                    healed = true
                    if healing_amount then
                        entity.health = math.min(entity.health + healing_amount, entity.max_health)
                    else
                        entity.health = entity.max_health
                    end
                end
            end
        end
    end
    return healed
end

function regenerate_nature_event(event)
    if storage.nature_damaged then
        local healed = regenerate_nature(1) -- heal all entities by 1
        storage.nature_damaged = healed -- if no entities were healed, no need to regenerate anymore
    end
end

function regenerate_nature_full()
    regenerate_nature(nil) -- heal all entities to max health
end

function handle_simple_entity_damaged(event)
    -- if nature entity was damaged, set flag to true to enable healing again
    if event.entity.prototype.autoplace_specification then
        storage.nature_damaged = true
    end
end

function init_mod()
    storage.nature_damaged = true -- assume nature damaged at the beginning
    load_mod()
end

function load_mod()
    local seconds_per_health_regen = settings.global["nature-regeneration-heal-rate"].value

    script.on_nth_tick(nil)
    if settings.global["nature-regeneration-enable"].value then
        script.on_nth_tick(seconds_per_health_regen * 60, regenerate_nature_event)
    end

    script.on_event(defines.events.on_entity_damaged, handle_simple_entity_damaged, {{filter = "type", type = "simple-entity"}})
end

commands.add_command("regenerate-nature",
                     { "", "Regenerates all nature to max health instantly." },
                     regenerate_nature_full)

-- init the mod on load and also when settings change
script.on_event(defines.events.on_runtime_mod_setting_changed, init_mod)
script.on_init(init_mod)
script.on_load(load_mod)
