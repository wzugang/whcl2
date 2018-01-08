
function openqq()
	x, y = findMultiColorInRegionFuzzy(0x121214,"25|35|0x121214,-8|66|0xe22a0e,-37|113|0xfdbd18,17|116|0xffbc13,-18|67|0xe32b0f,-48|52|0xe32a0e,31|56|0xe32b0f,-39|21|0x121214,-72|41|0xffffff,51|36|0xffffff", 95, 52, 654, 1040, 1484, 0, 0)
	if x > -1 then
		--logpos(x,y)
		click(x, y) 
	end
end

function isapprunning(app)
	flag = appIsRunning(app); --检测app是否在运行
	if 0 ~= flag then --如果运行
		sysLog(app.." is running")
		return true
	end
	sysLog(app.." is not running")
	return false
end

--"com.sqage.xtxj.huawei"
function openapp(app)
	flag = appIsRunning(app); --检测app是否在运行
	if 0 == flag then --如果没有运行
		runApp(app) --运行app
		sysLog("openapp "..app)
	end
end

function closeapp(app)
	flag = appIsRunning(app); --检测app是否在运行
	if 0 == flag then --如果没有运行
		return ;
	end
	closeApp(app)
	sysLog("closeapp "..app)
end

function restartapp(app)
	if (isapprunning(app)) then 
		closeapp(app)
	end
	openapp(app)
	sysLog("restartapp "..app)
end

