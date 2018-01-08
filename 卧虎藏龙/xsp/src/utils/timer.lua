
--定时器函数里面不能有sleep，否则会卡死

function starttimer(delay, func, arg, ...)
	setTimer(delay,func,arg)
end

function startcycletimer(delay, func, arg, ...)
	setTimer(delay, function() func(arg) startcycletimer(delay, func, arg) end)
end

function newthread(func)
	setTimer(0,func)
end
