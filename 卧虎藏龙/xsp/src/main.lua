require("whcl/activity")
require("whcl/app")
require("whcl/action")
require("whcl/pos")
require("utils/click")
require("utils/catch")
require("utils/work")
require("utils/timer")
require("utils/time")
require("utils/ui")
require("utils/utils")
require("utils/config")

--旋转屏幕
function setup() 
	init("0",0); --屏幕方向，0 - 竖屏， 1 - Home键在右边， 2 - Home键在左边(设置为其它值有问题,当前设置为0)
	setScreenScale(1080,1920,0)
	sysLog("初始化完成...")
end

--锁屏会导致断开
function test()
	--后续传入活动参数坐标X
	--local x,y = gettaskpos()
	--logpos(x,y)
	--openqq()
	--getposclick(getactivitypos)
	--shortcut("aaaa.png", 1,1,1080,1920)
	--restartwhcl()

	runwithui()

	--重置锁屏时间，防止锁屏
	--startcycletimer(30000, function() resetIDLETimer() end)

	--sysLog(getnowtimestring())
	--jierirenwu()
	--getreward()
	--caishenjianglin()
	--catchNPoint(3)
	--erenxuanshang()
	--mSleep(10000) --任务之间间隔10s
	--caishenjianglin()
end

function runwithui()
	timeout = cfg:getnumber("countdown")
	sysLog("countdown:"..timeout)
	--使用countdown自动确认
	ui = createui("default", timeout, 1080, 1600)	--0表示不超时
	--page1 = createpage("模式切换")
	page2 = createpage("日常任务")
	page3 = createpage("限时任务")
	page4 = createpage("特殊任务")
	--labe1 = createview("center","0,0,0",50,"任务模式选择：","255,255,255","Label")		--L是大写的，不要写错了
	labe2 = createview("center","0,0,0",50,"日常任务列表：","255,255,255","Label")		--L是大写的，不要写错了
	labe3 = createview("center","0,0,0",50,"限时任务列表：","255,255,255","Label")		--L是大写的，不要写错了
	labe4 = createview("center","0,0,0",50,"特殊任务列表：","255,255,255","Label")		--L是大写的，不要写错了
	
	--Edit = createview("center","0,0,0",40,"hello world","255,255,255","Edit")		--L是大写的，不要写错了
	--checkboxgroup=createcheckboxgroup("createcheckboxgroup1", "horizontal", 40, "江湖跑商,江湖酒仙,帮会环跑,师门环跑,江湖行下,侠客岛")
	--radioboxgroup1=createradiobox("radioboxgroup1", "vertical", 40, "设置模式,运行模式")
	checkboxgroup1=createcheckboxgroup("checkboxgroup1", "vertical", 40, "江湖跑商,江湖酒仙,江湖行侠,师门环跑,帮会环跑,帮会演武,侠客岛,重温剧情,镖行天下,宝图任务")
	checkboxgroup2=createcheckboxgroup("checkboxgroup2", "vertical", 40, "黑风寨据点环跑,五仙寨据点环跑,安锋营据点环跑,沙水营据点环跑,龙盘虎踞-黑风寨,龙盘虎踞-五仙寨,龙盘虎踞-安锋营,龙盘虎踞-沙水营,龙盘虎踞-开放日")
	checkboxgroup3=createcheckboxgroup("checkboxgroup3", "vertical", 40, "节日任务,财神使者,帮会药园,帮会叛匪,帮会大盗,全服王者,古城夺宝,一气呵成,领取奖励")
	--uiaddview(page1,labe1)
	--uiaddview(page1,radioboxgroup1)
	uiaddview(page2,labe2)
	uiaddview(page2,checkboxgroup1)
	uiaddview(page3,labe3)
	uiaddview(page3,checkboxgroup2)
	uiaddview(page4,labe4)
	uiaddview(page4,checkboxgroup3)
	--uiaddview(ui,page1)
	uiaddview(ui,page2)
	uiaddview(ui,page3)
	uiaddview(ui,page4)
	uistring = uitostring(ui)
	sysLog(uistring)
	ret,data=uishow(uistring)
	--mSleep(1000*10)
	sysLog("ret:"..ret)
--[[
返回值 
除了标签 Label，页面Page 其余四种控件均存在文本型返回值，
按照定义时的id，会返回以id为key的Map类型数据。
单选框返回当前选中项的编号；
编辑框返回其中的内容；
多选框返回 当前选中项的编号（从 0 开始），多个选项以 @ 分割。如：3@5 表示多选框组编号为 3 和 5 的两个选项已被选中。 
解析函数的第1个返回值为整数型，用户单击右下角的“确认”时返回 1，单击左下角的“取消”时返回 0。
--]]

	if ret == 0 then							--点击取消
		cfg:setnumber("countdown",0)
		return
	else										--点击确定
		if timeout == 0 then
			cfg:setnumber("countdown",1)
			return
		end
	end

--[[
	k,v = lua_table_get_kv_by_key(data, "radioboxgroup1")
	sysLog(k..","..v)
	if v == "0" then
		cfg:setnumber("countdown",0)
	elseif v == "1" then
		cfg:setnumber("countdown",1)
	end	
--]]

	k,v = lua_table_get_kv_by_key(data, "checkboxgroup1")
	if(string.len(v) ~= 0) then
		sysLog(k..","..v)
		dailyactivity(v)
	end

	k,v = lua_table_get_kv_by_key(data, "checkboxgroup2")
	if(string.len(v) ~= 0) then
		sysLog(k..","..v)
		limitactivity(v)
	end

	k,v = lua_table_get_kv_by_key(data, "checkboxgroup3")
	if(string.len(v) ~= 0) then
		sysLog(k..","..v)
		specialactivity(v)
	end
end


--日常任务
function dailyactivity(targetstr)
	local list=lua_string_split(targetstr, "@")
	--[[
	for	i=1,table.getn(list) do
		--sysLog(tonumber(list[i]))
		if lua_table_include(list, "1") then
			sysLog("exists")
		end
		
	end
	--]]
	local count = table.getn(list)
	switchtotask()
	for i=1,count do
		if list[i] == "0" then
			jianghupaoshang()
		elseif list[i] == "1" then
			jianghujiuxian()
		elseif list[i] == "2" then
			jianghuxingxia()
		elseif list[i] == "3" then
			shimenhuanpao()
		elseif list[i] == "4" then
			banghuihuanpao()
		elseif list[i] == "5" then
			banghuiyanwu()
		elseif list[i] == "6" then
			xiakedao()
		elseif list[i] == "7" then
			chongwenjuqing(70-50,5)
		elseif list[i] == "8" then
			biaoxingtianxia()
		elseif list[i] == "9" then
			baoturenwu()
		end
	end
end

--限时任务
function limitactivity(targetstr)
	local list=lua_string_split(targetstr, "@")
	local count = table.getn(list)
	switchtotask()
	for i=1,count do
		if list[i] == "0" then
			--黑风寨据点环跑
			sysLog("黑风寨据点环跑")
			heifengzhaijudianhuanpao()
		elseif list[i] == "1" then
			--五仙寨据点环跑
			sysLog("五仙寨据点环跑")
			wuxianzhaijudianhuanpao()
		elseif list[i] == "2" then
			--安锋营据点环跑
			sysLog("安锋营据点环跑")
			anfengyingjudianhuanpao()
		elseif list[i] == "3" then
			--沙水营据点环跑
			sysLog("沙水营据点环跑")
			shashuiyingjudianhuanpao()
		elseif list[i] == "4" then
			--龙盘虎踞-黑风寨
			sysLog("龙盘虎踞-黑风寨")
		elseif list[i] == "5" then
			--龙盘虎踞-五仙寨
			sysLog("龙盘虎踞-五仙寨")
			longpanhujuwuxianzhai()
		elseif list[i] == "6" then
			--龙盘虎踞-安锋营
			sysLog("龙盘虎踞-安锋营")
		elseif list[i] == "7" then
			--龙盘虎踞-沙水营
			sysLog("龙盘虎踞-沙水营")
			longpanhujushashuiying()
		elseif list[i] == "8" then
			--龙盘虎踞-开放日
			sysLog("龙盘虎踞-开放日")
			longpanhujukaifangri()
		end
	end
end

--特殊任务
function specialactivity(targetstr)
	local list=lua_string_split(targetstr, "@")
	local count = table.getn(list)
	switchtotask()
	for i=1,count do
		if list[i] == "0" then
			--节日任务
			jierirenwu()
		elseif list[i] == "1" then
			--财神降临
			caishenjianglin()
		elseif list[i] == "2" then
			--帮会药园
			banghuiyaoyuan()
		elseif list[i] == "3" then
			--帮会叛匪
			sysLog("帮会叛匪")
		elseif list[i] == "4" then
			--帮会大盗
			sysLog("帮会大盗")
		elseif list[i] == "5" then
			--全服王者
			sysLog("全服王者")
		elseif list[i] == "6" then
			--古城夺宝
			sysLog("古城夺宝")
		elseif list[i] == "7" then		--一气呵成
			yiqihecheng()
		elseif list[i] == "8" then		--领取奖励
			getreward()
		end
	end
end

--192.168.125.118
function main()
  setup();
  test();
end

main();
 