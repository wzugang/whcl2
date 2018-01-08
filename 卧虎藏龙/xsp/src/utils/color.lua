require("utils/log")

--精确型，核对颜色
function checkcoloraccurate(x,y,color,delay)
	for i=1,3 do
		color1 = getColor(x,y)
		if math.abs(color-color1) < 3 then
			return true
		end
		mSleep(delay)
	end
	sysLog("checkcoloraccurate color not match")
	logcolor(x,y,color)
	return false
end

--等待型，核对颜色
function checkcolor(x,y,color,delay)
	color1 = getColor(x,y)
	mSleep(delay)
	color2 = getColor(x,y)
	
	if  math.abs(color1-color2) >= 3 then
		return false
	end
	if math.abs(color-color1) >= 3 then
		return false
	end
	return true
end

function waitcolor(x,y,color,func)
	while not checkcolor(x,y,color,60) do
		--logcolor(x,y,getColor(x,y))
		mSleep(60)
	end
	func()
end

