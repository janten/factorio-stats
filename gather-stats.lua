local force_statistics = {
    "item_production_statistics",
    "fluid_production_statistics",
    "kill_count_statistics",
    "entity_build_count_statistics",
}

local game_statistics = {
    "pollution_statistics"
}

local directions = {
    "input_counts",
    "output_counts"
}

function get_keys(statistic)
    local keyset = {}

    for _, direction in pairs(directions) do
        for key, _ in pairs(statistic[direction]) do
            keyset[key] = true
        end
    end

    return keyset
end

function value_or_zero(table, key)
    local value = table[key]
    if value == nil then
        value = 0
    end
    return math.floor(value)
end

function get_values(object, statistic_name, additional_tags)
    statistic = object[statistic_name]
    local keys = get_keys(statistic)
    local counts = {}

    for key, _ in pairs(keys) do
        local count = {
            measurement = statistic_name,
            tags = {
                entity = key
            },
            fields = {
                input = value_or_zero(statistic.input_counts, key),
                output = value_or_zero(statistic.output_counts, key)
            }
        }

        for key, value in pairs(additional_tags) do
            count.tags[key] = value
        end

        table.insert(counts, count)
    end

    return counts
end

local counts = {}

for _, game_statistic in pairs(game_statistics) do
    local new_counts = get_values(game, game_statistic, {})
    for _, value in pairs(new_counts) do 
        table.insert(counts, value)
    end
end

for _, force_statistic in pairs(force_statistics) do
    for _, force in pairs(game.forces) do
        local new_counts = get_values(force, force_statistic, {force = force.name})
        for _, value in pairs(new_counts) do 
            table.insert(counts, value)
        end
    end
end

for _, player in pairs(game.players) do
    local name = player.name
    local inventory = player.get_main_inventory().get_contents()
    for item, count in pairs(inventory) do
        local value = {
            measurement = "player_inventory_statistics",
            tags = {
                player = name,
                item = item
            },
            fields = {
                value = count
            }
        }
        table.insert(counts, value)
    end
end

table.insert(counts, {
    measurement = "game_statistics", 
    fields = {
        players = #game.connected_players, 
        tick = game.tick
    }
})

rcon.print(game.table_to_json(counts))