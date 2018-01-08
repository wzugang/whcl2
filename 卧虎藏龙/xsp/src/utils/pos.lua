require("utils/log")
require("utils/check")


function getpos(func)
	return func()
end

function testgetpos(func)
	x,y=getpos(func)
	if x <= -1 then
		return false
	end
	return true
end

function blockgetpos(func)
	while not testgetpos(func) do
		mSleep(60)
	end
	x,y=getpos(func)
	logpos(x,y)
	return x,y
end

function rectgetpos(func,degree,x1,y1,x2,y2)
	return func(degree,x1,y1,x2,y2)
end

function testrectgetpos(func,degree,x1,y1,x2,y2)
	x,y=func(degree,x1,y1,x2,y2)
	_,__=checkrectpos(x, y, x1, y1, x2, y2)
	if ((x <= -1) or (_ <= -1)) then
		return false,x,y
	end
	return true,x,y
end

function blockrectgetpos(func,degree,x1,y1,x2,y2)
	while not testrectgetpos(func,degree,x1,y1,x2,y2) do
		mSleep(50)
	end
	_,x,y=testrectgetpos(func,degree,x1,y1,x2,y2)
	logpos(x,y)
	return x,y
end




