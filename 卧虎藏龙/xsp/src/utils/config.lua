
cfg={}

function cfg:setnumber(key,value)
	setNumberConfig(key,value)
end

function cfg:getnumber(key)
	return getNumberConfig(key,0)
end

function cfg:setstring(key,value)
	setStringConfig(key,value)
end

function cfg:getstring(key)
	return getStringConfig(key,"")
end

