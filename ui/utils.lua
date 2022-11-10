--[[
	xNormal LUA utils
	(c) 2005-2018 S.Orgaz.
--]]

-- ---------------------------------------------------------------------------------------------	
-- Table-clone methods
-- ---------------------------------------------------------------------------------------------

-- Copy table function
function copy_table ( table )
	local copy = {}
	copy_table_private ( copy, table )
	return copy
end

-- Internal deep table copy function, not for direct use ( is called in the copy_table function )
function copy_table_private ( copy, origTable )
	for k,v in pairs(origTable)
	do
		if ( type(v) ~= "table" )
		then
			copy[k] = v;
		else
			copy[k] = {}
			copy_table_private ( copy[k], v )
		end
	end
end
