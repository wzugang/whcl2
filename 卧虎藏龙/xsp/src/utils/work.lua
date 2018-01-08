require("utils/color")
require("utils/pos")
require("utils/check")

function delaywork(delay,work)
	mSleep(delay)
	work()
end

function repeatwork(count,func)
	for i=1,count do mSleep(50) func() end
end

function getposwork(func,work)
	work(func())
end

function workuntil(func,work)
	while not func() do
		work()
	end
end

function onlywork(func,work)
	if func() then
		work()
		return true
	end
		return false
end

function onlycolorwork(x,y,color, work)
	return onlywork(function() return checkcolor(x,y,color,50) end, work)
end

function onlygetposwork(func,work)
	return onlywork(function() return testgetpos(func) end, work)
end

function onlyrectgetposwork(func,degree,x1,y1,x2,y2, work)
	return onlywork(function() return testrectgetpos(func,degree,x1,y1,x2,y2) end, work)
end

--阻塞直到函数返回true
function blockwork(func,work)
	while not func() do
		mSleep(50)
	end
	sysLog("block over...")
	work()
end

function blockcolorwork(x,y,color, work)
	return blockwork(function() return checkcolor(x,y,color,50) end, work)
end

function blockgetposwork(func,work)
	return blockwork(function() return testgetpos(func) end, work)
end

function blockrectgetposwork(func,degree,x1,y1,x2,y2, work)
	return blockwork(function() return testrectgetpos(func,degree,x1,y1,x2,y2) end, work)
end

function blockgetsamelinework(line,startpos,endpos,step,work)
	while not checklinesamecolor(line,startpos,endpos,step) do
		mSleep(10)
	end
	work()
end
