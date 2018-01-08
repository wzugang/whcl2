require("utils/work")
require("utils/color")
require("utils/pos")

function click(x, y) 
	touchDown(0, x, y)
	mSleep(5)
	touchUp(0, x, y)
	sysLog("click("..x..", "..y..")...")
end

function nologclick(x, y) 
	touchDown(0, x, y)
	mSleep(5)
	touchUp(0, x, y)
end

function touchclick(delay,x, y) 
	touchDown(0, x, y)
	mSleep(delay)
	touchUp(0, x, y)
	sysLog("touchclick("..x..", "..y..")...")
end

function getposclick(func)
	click(getpos(func))
end

function delayclick(delay,x,y)
	delaywork(delay, function() click(x,y) end)
end

function delaytouchclick(delay,touchdelay,x,y)
	delaywork(delay, function() touchclick(touchdelay,x,y) end)
end

function delaygetposclick(delay,func)
	delaywork(delay, function() getposclick(func) end)
end

function onlycolorclick(x,y,color)
	return onlycolorwork(x,y,color, function() click(x,y) end)
end

function onlygetposclick(func)
	return onlygetposwork(func, function() click(getpos(func)) end)
end

function delayonlygetposclick(delay, func)
	return delaywork(delay, function() onlygetposclick(func) end)
end

function onlyrectgetposclick(func,degree,x1,y1,x2,y2)
	return onlyrectgetposwork(func,degree,x1,y1,x2,y2, function() click(rectgetpos(func,degree,x1,y1,x2,y2)) end)
end

function delayonlyrectgetposclick(delay,func,degree,x1,y1,x2,y2)
	return delaywork(delay, function() onlyrectgetposclick(func,degree,x1,y1,x2,y2) end)
end

function blockcolorclick(x,y,color)
	blockcolorwork(x,y,color, function() click(x,y) end)
end

function blockgetposclick(func)
	return blockgetposwork(func, function() click(getpos(func)) end)
end

--修改确认x,y有效
function blockrectgetposclick(func,degree,x1,y1,x2,y2)
	return blockrectgetposwork(func,degree,x1,y1,x2,y2, function() x,y=rectgetpos(func,degree,x1,y1,x2,y2) while x <= -1 do x,y=rectgetpos(func,degree,x1,y1,x2,y2) end click(x,y) end)
end

function blockrectgetposdelayclick(func,degree,x1,y1,x2,y2,delay)
	return blockrectgetposwork(func,degree,x1,y1,x2,y2, function() x,y=rectgetpos(func,degree,x1,y1,x2,y2) while x <= -1 do x,y=rectgetpos(func,degree,x1,y1,x2,y2) end mSleep(delay) click(x,y) end)
end

function blockrectgetposanyclick(dict)
	while true do
		for i=1,#dict do
			--onlyrectgetposwork(dict[i][1],dict[i][2],dict[i][3],dict[i][4],dict[i][5],dict[i][6], function() x,y=rectgetpos(dict[i][1],dict[i][2],dict[i][3],dict[i][4],dict[i][5],dict[i][6]) while x <= -1 do x,y=rectgetpos(dict[i][1],dict[i][2],dict[i][3],dict[i][4],dict[i][5],dict[i][6]) end click(x,y) end)
			flag,x,y=testrectgetpos(dict[i][1],dict[i][2],dict[i][3],dict[i][4],dict[i][5],dict[i][6])
			if (flag) then
				mSleep(1000)
				flag,x,y=testrectgetpos(dict[i][1],dict[i][2],dict[i][3],dict[i][4],dict[i][5],dict[i][6])
				if(flag) then
					click(x,y)
					return
				end
			end
		end
	end
end

--[[
function blockrectgetposclick(func,degree,x1,y1,x2,y2)
	click(blockrectgetpos(func,degree,x1,y1,x2,y2))
end
--]]

function blockgetsamelineclick(line,startpos,endpos,step,x,y)
	blockgetsamelinework(line,startpos,endpos,step,function() click(x,y) end)
end