rcon.print('tick ' .. game.tick)
rcon.print('ticks_played ' .. game.ticks_played)

for k, force in pairs(game.forces) do
    rcon.print('rockets_launched{force="' .. force.name .. '"} ' .. force.rockets_launched)
    for item, amount in pairs(force.kill_count_statistics.input_counts) do
        rcon.print('killed{force="' .. force.name .. '", name="' .. item .. '"} ' .. amount)
    end
    for item, amount in pairs(force.kill_count_statistics.output_counts) do
        rcon.print('killed_by{force="' .. force.name .. '", name="' .. item .. '"} ' .. amount)
    end    
    for item, amount in pairs(force.item_production_statistics.input_counts) do
        rcon.print('production{type="item", force="' .. force.name .. '", name="' .. item .. '"} ' .. amount)
    end
    for item, amount in pairs(force.item_production_statistics.output_counts) do
        rcon.print('consumption{type="item", force="' .. force.name .. '", name="' .. item .. '"} ' .. amount)
    end
    for item, amount in pairs(force.fluid_production_statistics.input_counts) do
        rcon.print('production{type="fluid", force="' .. force.name .. '", name="' .. item .. '"} ' .. amount)
    end
    for item, amount in pairs(force.fluid_production_statistics.output_counts) do
        rcon.print('consumption{type="fluid", force="' .. force.name .. '", name="' .. item .. '"} ' .. amount)
    end
    for item, amount in pairs(force.entity_build_count_statistics.input_counts) do
        rcon.print('production{type="entity", force="' .. force.name .. '", name="' .. item .. '"} ' .. amount)
    end
    for item, amount in pairs(force.entity_build_count_statistics.output_counts) do
        rcon.print('consumption{type="entity", force="' .. force.name .. '", name="' .. item .. '"} ' .. amount)
    end
end