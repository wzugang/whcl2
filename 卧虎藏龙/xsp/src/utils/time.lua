
function getnetsec()  --获取GMT时区从1970年到现在经过的秒数
	return getNetTime()
end

function getunixmsec()  --显示从1970年到现在经过的毫秒数，更加精确
	return mTime()
end

function isleapyear(year)
	if(year%4 == 0 and (year%400 == 0 or year%100 ~= 0)) then
		return true
	else
		return false
	end
end

function getmonthday(year, month)
	monthday={{31,28,31,30,31,30,31,31,30,31,30,31},{31,29,31,30,31,30,31,31,30,31,30,31}}
	if (isleapyear(year)) then
		return monthday[2][month]
	else
		return monthday[1][month]
	end
end

function getminutesecods()
	return (60)
end

function gethoursecods()
	return (60*60)
end

function getdaysecods()
	return (24*60*60)
end

function getmonthsecods(year,month)
	return (getmonthday(year,month)*getdaysecods())
end

function getyearsecods(year)
	if (isleapyear(year)) then
		return (getdaysecods()*366)
	else
		return (getdaysecods()*365)
	end
end

function secondstotime(seconds)
	year=1970
	month=1
	day=1
	hour=0
	minute=0
	second=0
	while seconds >= getyearsecods(year) do
		year = year + 1
		seconds = seconds - getyearsecods(year)
	end
	while seconds >= getmonthsecods(year,month) do
		month = month + 1
		seconds = seconds - getmonthsecods(year,month)
	end
	while seconds >= getdaysecods() do
		day = day + 1
		seconds = seconds - getdaysecods()
	end
	while seconds >= gethoursecods() do
		hour = hour + 1
		seconds = seconds - gethoursecods()
	end
	while seconds >= getminutesecods() do
		minute = minute + 1
		seconds = seconds - getminutesecods()
	end
	second = seconds
	
	return year,month,day,hour,minute,second
end

function timetostring(year,month,day,hour,minute,second)
	--return (year.."-"..month.."-"..day.." "..hour..":"..minute..":"..second)
	return string.format("%04d-%02d-%02d %02d:%02d:%02d",year,month,day,hour,minute,second)
end

function getnowtime()
	return secondstotime(getnetsec())
end

function getnowtimestring()
	return timetostring(getnowtime())
end
