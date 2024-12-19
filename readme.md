# Nature regeneration

A simple mod that makes all naturally occuring entities (like rocks on Nauvis)
regenerate health over time (just like trees do).

Do you on accident touch a rock with your car and now you have to destroy it
or a 99.9% full health bar will haunt you for the rest of time? No more!

Also adds a command to heal all nature entities to max health, just type `/regenerate-nature` into chat.

### Notes

Healing is quite heavy on UPS on large worlds (script has to iterate through all nature entities).
It is possible to disable healing over time in the map settings. You can still use the `/regenerate-nature` command without any performance consequences while playing.

Entities that this mod applies health regen stat to are autodetected
(all entities that are autoplaceable by the map generator). Should also
work for modded/newly added entities.

In case some entities are missed, contact me please.
