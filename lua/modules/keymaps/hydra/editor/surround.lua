-- Surround has a few core action types:
-- * changing surrounding characters
-- * adding surrounding characters to selection/movement
-- * deleting surrounding characters
--
-- How is this hydra going to implement these?
-- Leader will be something like <C-S> or <leader>s
-- Changing: <C-S> + c + [before] + [after]
--           his will be able to be chained easily
-- Deleting: <C-S> + d + [before]
-- Adding: <C-S> + a + movement + 

local surround = require('mini.surround')

local function delete()
    surround.delete()
end

local function add_normal()
    surround.add('normal')
end

local function add_visual()
    surround.add('visual')
end

local function replace()
    surround.replace()
end

local hydra = {
    
}


return {
    'Surround',
    hydra,
}
