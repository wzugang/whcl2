function lua_string_split(szFullString, szSeparator)  
	local nFindStartIndex = 1  
	local nSplitIndex = 1  
	local nSplitArray = {}  
	while true do  
	   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)  
	   if not nFindLastIndex then  
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))  
		break  
	   end  
	   nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)  
	   nFindStartIndex = nFindLastIndex + string.len(szSeparator)  
	   nSplitIndex = nSplitIndex + 1  
	end  
	return nSplitArray  
end  

--ipairs只能遍历list
function lua_table_include(tab, value)
    for k,v in ipairs(tab) do
      if v == value then
          return true
      end
    end
    return false
end

--pairs可以遍历dict
function lua_table_get_kv_by_key(tab,key)
    for k,v in pairs(tab) do
		if k == key then
			return k,v
		end
    end
	return nil
end

