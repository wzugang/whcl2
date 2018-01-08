
function uiselectfile(file)
	resetUIConfig(file)
end

function uishow(file)
	return showUI(file)
end

function uigetstring(file)
	return getUIContent(file)
end

function resetuicountdown(uistring,countdown)
	list=lua_string_split(uistring,",")
	for str in list do
		if string.find(str,'"'.."countdown"..'"'..":") > 0 then
			sysLog(str)
			newstr = '"'.."countdown"..'"'..":"..countdown
			sysLog(newstr)
			uishow(string.gsub(uistring,str,newstr))
		end
	end
end

function createui(uitype,interval,width,height)
	local ui={}
	ui["style"] = uitype
	ui["config"] = "save_backup.dat"
	ui["width"] = width
	ui["height"] = height
	ui["cancelscroll"] = false
	ui["countdown"] = interval
	ui["cancelname"] = "取消"
	ui["okname"] = "确定"
	ui["views"] = {}
	return ui
end

function uiaddview(ui,view)
	local index=table.nums(ui["views"])
	--sysLog(index)
	ui["views"][index] = view
	--sysLog(#{ui["views"][index]})
	--sysLog(viewtojsonstring(view))
	--sysLog(viewtojsonstring(ui["views"][index]))
end

function uidelview(ui,index)
	for i = #{ui["views"]}, 1, -1 do
		if i == index then
			table.remove(ui["views"], i)
		end
	end
end

function uitostring(ui)
	local str="{"
	for k,v in pairs(ui) do
		if type(v) ~= "table" then
			if type(v) == "string" then
				str = str..'"'..k..'":"'..v..'",'
			elseif type(v) == "boolean" then
				if v == false then
					str = str..'"'..k..'":false,'
				else
					str = str..'"'..k..'":true,'
				end
			else
				str = str..'"'..k..'":'..v..','
			end
		end
	end
	str = str..'"views":['
	local count=table.nums(ui["views"])		--需要local,否则会被子函数改写
	--sysLog(count)
	if count >= 1 then
		for i=0,count-1 do
			--sysLog(i..count)
			if i ~= count-1 then
				str = str..viewtojsonstring(ui["views"][i])..","
			else
				str = str..viewtojsonstring(ui["views"][i])
			end
		end
	end
	str = str.."]}"
	return str
end

function createview(align,color,size,text,bg,uitype)
	local view={}
	view["align"] = align
	view["color"] = color
	view["size"] = size
	view["text"] = text
	view["bg"] = bg
	view["type"] = uitype

	return view
end

function viewaddproperty(view, key,value)
	view[key] = value
end

function createcheckboxgroup(id, dirct, size, list)
	local checkboxgroup = {}
	checkboxgroup["type"] = "CheckBoxGroup"
	checkboxgroup["id"] = id
	checkboxgroup["orientation"] = dirct
	checkboxgroup["list"] = list
	checkboxgroup["size"] = size

	return checkboxgroup
end

function createradiobox(id, dirct, size, list)
	local radiobox = {}
	radiobox["type"] = "RadioGroup"
	radiobox["id"] = id
	radiobox["orientation"] = dirct
	radiobox["list"] = list
	radiobox["size"] = size

	return radiobox
end

function createpage(text)
	local page={}
	page["text"] = text
	page["type"] = "Page"
	page["views"] = {}
	return page
end

--record不计算table长度,table.getn
function table.nums(t)  
    local count = 0
	if t == nil then
		return count
	end
    for k, v in pairs(t) do  
        count = count + 1  
    end  
    return count  
end 

function viewtojsonstring(view)
	local count = table.nums(view)
	local index = 0
	local subindex = 0
	str="{"
	for k,v in pairs(view) do
		index = index + 1
		if type(v) == "string" then
			if index ~= count then
				str = str..'"'..k..'":"'..v..'",'
			else
				str = str..'"'..k..'":"'..v..'"'
			end
		elseif type(v) == "table" then
		--elseif k == "views" then
			local subviewscount = table.nums(view["views"])
			str = str..'"views":['
				if subviewscount >= 1 then
					for	k=0,subviewscount-1 do
						if k ~= subviewscount-1 then
							str = str..viewtojsonstring(view["views"][k])..","
						else
							str = str..viewtojsonstring(view["views"][k])
						end
					end
				end
			str = str.."],"
		elseif type(v) == "number" then
			if index ~= count then
				str = str..'"'..k..'":'..v..','
			else
				str = str..'"'..k..'":'..v
			end
		end
	end
	str = str.."}"
	return str
end


