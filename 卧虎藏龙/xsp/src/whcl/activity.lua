require("utils/work")
require("utils/click")
require("utils/log")
require("utils/move")
require("utils/check")
require("whcl/pos")
require("whcl/base")
require("whcl/action")

--师门环跑，完美
function shimenhuanpao() --line,column
	getposclick(getactivitypos)
	delaywork(2000, function() click(getposdaily(getshimenpos)) end)
	blockcolorclick(422,1452,0x7ba3d9)															--接取任务
	delaywork(1000,talk)																						--自动对话
	blockcolorclick(420,1476,0xdec07c)															--找到任务引导员
	mSleep(5000)
	blockrectgetposclick(getlittlepos, 95, 363, 1294, 411, 1437)    --巡视捉拿门派叛徒
	mSleep(5000)
	blockrectgetposclick(getlittlepos, 95, 363, 1294, 411, 1437)    --炼药,打坐
	mSleep(5000)
	blockrectgetposclick(gethandinpos, 95, 170, 1175, 224, 1337)    --上交物品
	mSleep(5000)
	blockrectgetposclick(getlittlepos, 95, 363, 1294, 411, 1437)    --巡视捉拿小贼
	mSleep(5000)
	blockcolorclick(420,1476,0xdec07c)														  --接取任务，领取奖励
end

--江湖跑商，OK
function jianghupaoshang() --line,column
	getposclick(getactivitypos)
	delaywork(2000, function() click(getposdaily(getjianghupaoshangpos)) end)
	logpos(getpaoshangstartpos())
	blockcolorclick(418,1587,0x79a1d7)														--点击开始跑商
	
	buy=function(buyindex)
			current = buyindex
			for i=buyindex,5 do																				--购买物品
				x1,y1,x2,y2 = getpaoshangpos(i-1)
				logrect(x1,y1,x2,y2)
				x,y = getpaoshangposlow(45,x1,y1,x2,y2)									--50 OK
				if x <= -1 then																					--再次验证
					x,y = getpaoshangposlowbb(45,x1,y1,x2,y2)
				end
				logpos(x,y)
				if x > -1 then
					current = i
					delayclick(50, x-75, y)
					delayclick(50, getpaoshangbuy())
					mSleep(100)
				end
				--[[
				x,y = getpaoshangposlowbak(40,x1,y1,x2,y2)									--50 OK
				logpos(x,y)
				if x > -1 then
					current = i
					delayclick(150, x-75, y)
					delayclick(150, getpaoshangbuy())
					mSleep(300)
					--blockrectgetposclick(getyellowpos,60,368,997,428,1193) --购买确认
				end
				--]]
		end
		return current
	end
	
	sell=function(index)
		if testrectgetpos(getpaoshanggreypos, 80, 136, 1386, 202, 1588) then	--没有卖的，直接返回
			return
		end
		for k=1,10 do --卖掉能卖的
			delayonlyrectgetposclick(50, getyellowpos,60,135,1388,200,1585)	--dianji
			if (testrectgetpos(getyellowpos,60,368,997,428,1193)) then --确认卖出，亏本或原价才有这个，如果到这个了表明没有卖的了
				delayclick(50,742,1267) --关闭提醒对话框
				break
			end
			
			if testrectgetpos(getpaoshanggreypos, 80, 136, 1386, 202, 1588) then	--没有卖的了，退出
				break
			end
		end
		if (index > 26) then
			--大于26环时(还有4次)，只要不亏50%，就点击出售
			for m=1,10 do
				--onlywork(function() if not testrectgetpos(getpaoshangkuihalf, 80, 345, 596, 374, 688) then return true end return false end, function() mSleep(500) click(164,1489) end)
				onlywork(function() if not testrectgetpos(getpaoshangkuihalf, 45, 345, 596, 374, 688) then return true end return false end, function() mSleep(500) click(164,1489) end)
				if (testrectgetpos(getyellowpos,60,368,997,428,1193)) then 				--亏本有这个，但是要点击确认卖出
					delayclick(50,398,1098) 											--点击确定，卖出
					break
				end
				if testrectgetpos(getpaoshanggreypos, 80, 136, 1386, 202, 1588) then	--没有卖的，直接返回
					return
				end
			end
		end
	end
	
	once=function(index)
		sysLog("第"..index.."环跑商开始")
		if(index == 21) then
			--mSleep(3000)
			blockrectgetposclick(getpaoshang21,90,358,837,459,1078)						--跳过21环提醒界面
			sysLog("跳过...")
		end
		delayclick(500,getcurrenttaskpos())																--开启新的一环跑商任务
		blockrectgetposclick(getpaoshangshoppos,100,385,1149,462,1798)			--打开商店
		
		--出售物品
		sysLog("开始出售物品...")
		sell(index)
		sysLog("开始购买物品...")
		buyindex=1
		--采购物品,30环不要买了
		if(buyindex < 5) then
			buyindex = buy(buyindex)
		end

		--出售物品
		sell(index)
		
		--卖出之后再买一次，防止背包满了，购买失败
		if(buyindex < 5) then
			buyindex = buy(buyindex)
		end
		--出售物品
		sysLog("再次出售物品...")
		sell(index)
	
		if (index > 25) then
			sysLog("已经25次了...")
		end
		delayclick(500,1013,1747) 	--关闭该次任务
		delayclick(500,374,1099) 	--确认关闭该次跑商
		sysLog("第"..index.."环跑商结束")
	end

	for j=1,30 do
		once(j)
	end
	delayclick(1000,885,1463)			--关闭跑商清单
end

--江湖酒仙,需要保证有足够的酒，需要修改喝完酒检测
function jianghujiuxian()
	drink=function()
		d = function(x,y) mSleep(1000) click(x,y) mSleep(1000) click(323,1215) end  --选酒，喝酒
		page = function()
			mSleep(1000)
			onlywork(function() return checkcoloraccurate(323,1215,0xdec07c,100) end,function() d(672,604) end) 	 	--蓝酒
			onlywork(function() return checkcoloraccurate(323,1215,0xdec07c,100) end,function() d(669,790) end)   		--紫酒
			onlywork(function() return checkcoloraccurate(323,1215,0xdec07c,100) end,function() d(672,964) end)   		--橙酒
			onlywork(function() return checkcoloraccurate(323,1215,0xdec07c,100) end,function() d(672,1143) end)  		--金酒
			onlywork(function() return checkcoloraccurate(323,1215,0xdec07c,100) end,function() d(667,1325) end)  		--红酒
		end

		for i=1,3 do
			page()														--找酒喝
			--如果喝完了就退出
			if not checkcoloraccurate(323,1215,0xdec07c, 100) then 
				return 
			end
			sysLog("翻页...")
			onlycolorclick(642,489,0xbfaf7f)                           	--翻到下一页喝酒
		end
		onlycolorclick(807,1459,0x391a18)                            	--关闭选酒界面
	end

	getposclick(getactivitypos)
	delaywork(2000, function() click(getposdaily(getjiuxianpos)) end)
	delayclick(1000,325,1206) 											--喝酒寻路
	blockcolorclick(323,1215,0xdec07c)

	sysLog("寻路选酒...")

	drink() 															--喝酒
	sysLog("酒喝中...")
	--640,16,0x3c3c49,这个颜色不会变,之前坐标不对
	blockwork(function() return checkcolor(640,40,0x3c3c49, 100) end, function() mSleep(12000) end)
	--blockcolorwork(642,18,0x3c3c49,function() mSleep(10000) end)
	sysLog("第一壶酒喝完了...")
	sysLog("再次选酒...")
	delayclick(2000,729,148)										 	--打开喝酒界面

	drink()																--喝酒
	sysLog("酒喝中...")
	blockwork(function() return checkcolor(640,40,0x3c3c49, 100) end, function() return mSleep(15000) end)
	--blockcolorwork(642,18,0x3c3c49,function() mSleep(10000) end)
	sysLog("第二壶酒喝完了...")
end

--重温剧情home键在充电一侧，背包已满没有自动清理背包，需要添加。（打完快速退出时正常退出已修复）,退出条件需要进行修改
function chongwenjuqing(degree,times)
	sysLog("重温剧情副本开始...")
	sysLog("副本等级:"..degree)
	degree = degree/10
	once=function()
		getposclick(getactivitypos)
		delaywork(2000, function() click(getposdaily(getchongwenpos)) end)
		--20级参考坐标为193,360，每10级相差314像素
		realY = (degree-2)*314 + 360
		sysLog("逻辑坐标:"..realY)
		while realY > 1610 do
			moveY = 314
			sysLog("移动: 378,"..(360+moveY).." , 378,360")
			delaymoveaccurate(1000,378,360+moveY,378,360)
			realY = realY - moveY
		end
		sysLog("实际坐标:"..realY)
		delayclick(1000,193,realY) --点击重温
		delayclick(1000,406,1214) --进入副本
		workuntil(function() return checkcolor(406,1220,0xdec07c,100) end, function() x,y=getputong(70) if x > -1 then delayclick(1000,x,y) end mSleep(2000) end)
		delayclick(1000,407,743)	--先不退出，往前面走几步，再等捡完装备再退出
		mSleep(2000)
		moveup(3000)
		mSleep(8000) --等待10秒拾取装备
		huishouzhuangbei()
		workuntil(function() return checkcolor(406,1220,0xdec07c,100) end, function() x,y=getputong(70) if x > -1 then delayclick(1000,x,y) end end)
		click(406,1220) --确认退出副本
	end
	for i=1,times do
		sysLog("第"..i.."次进入")
		mSleep(2000)
		once()
		mSleep(8000)
	end
	sysLog("重温剧情副本结束...")
end

--侠客岛
function xiakedao()
	getposclick(getactivitypos)
	delayclick(1000,getposdaily(getxiakedaopos))
	blockcolorclick(419,1574,0x79a1d7)
	mSleep(8000)
	click(714,138)	--第一次战斗
	workuntil(function() return checkcolor(405,1179,0xddbf7b,100) end,function() mSleep(15000) click(714,138) end) --继续战斗，直到退出
	delayclick(2000,405,1179)
	mSleep(10000) --等待退出
end

--帮会环跑，动态按钮不太好认，degree从95改为90
function banghuihuanpao()
	sysLog("帮会环跑...")
	getposclick(getactivitypos)
	delayclick(1000,getposdaily(getbanghuihuanpaopos))  							--帮会环跑
	delayclick(1000,406,1178)														--进入帮会驻地
	blockcolorclick(419,1229,0x79a1d7)												--帮会环跑，蓝色
	delaywork(1000,talk) 															--跳过对话
	blockcolorclick(194,1313,0xdbbd79) 												--上交npc物品
	mSleep(1000)
	--blockcolorclick(426,1495,0xe1c37f) 												--传达口令,多余
	--mSleep(1000)

	blockrectgetposclick(getyellowposbig,90,384,1149,463,1804)       				--索要账目 
	mSleep(1000)

	blockrectgetposclick(getlittlepos,90,366,1297,408,1434) 						--小怪
	mSleep(5000)
	delayonlyrectgetposclick(25000,getlittlepos,90,366,1297,408,1434)				--防止一个任务刷新多次
	mSleep(5000)
	blockrectgetposclick(getlittlepos,90,366,1297,408,1434) 						--小怪
	mSleep(5000)
	delayonlyrectgetposclick(25000,getlittlepos,90,366,1297,408,1434) 				--防止一个任务刷新多次
	blockcolorclick(390,1005,0xe0c27e)  											--确认完成
	tuichubanghuizhudi()                                              				--退出帮会驻地
end

--镖行天下
function biaoxingtianxia()
	once=function()
		count = 0
		getposclick(getactivitypos)
		delayclick(1000,getposdaily(getbiaoxingtianxia))							--镖行天下2,1
		blockcolorclick(421,1228,0x7aa2d8)											--点击接镖
		delayclick(2000,727,966)													--五仙寨727,966,0x282f43
		delayclick(1000,262,957)													--下一步262,957,0xd8ba76
		delayclick(1000,287,1247) 													--接镖287,1247,0xe2c481
		delayclick(1000,685,158)													--开始运镖685,158,0x229c05
		c2=0
		c3=getColor(973,1763)
		while not onlycolorclick(411,963,0xdec07c) do
			count = count + 1
			t1,t2=math.mod(count,100)
			if (0 == t2) then 
				c1 = c2
				c2 = c3
				c3=getColor(973,1763)
				if (c1 == c2 and c1 == c3) then
					mSleep(10000)													--等待10秒再次确认
					c4=getColor(973,1763)
					if c3 == c4 then
						click(685,158)                   								--异常下车后继续上车运镖
					end
				end
			end
		end																		--while退出，即结束运镖
	end
	for i=1,2 do
		once()
	end
end

--宝图任务，该任务需要活力达到75,小怪范围要足够精确,单个调好，需要计算个数
function baoturenwu()
	sysLog("宝图任务...")
	getposclick(getactivitypos)
	delayclick(2000,getposdaily(getbaoturenwupos))  					--宝图任务
	blockcolorclick(423,1660,0x7ca3d9)											 	--接取宝图任务
	--blockrectgetposclick(getbluepos,75,384,1148,463,1804)  	--接取宝图任务
	delaywork(2000,talk)
	--blockrectgetposclick(getlittlepos,90,363,1296,410,1436)  	--小怪
	mSleep(5000)

	--匹配度要高一点
	dict={{getlittlepos,95,363,1296,410,1436},{getposyellow,95,384,1148,463,1804}}
	for i=1,6 do
		blockrectgetposanyclick(dict)
		mSleep(3000)
	end
	mSleep(30000)	--等待打死小怪，后续需该进
	--[[
	blockrectgetposclick(getlittlepos,90,363,1296,410,1436)  	--小怪
	mSleep(5000)
	blockrectgetposclick(getlittlepos,90,363,1296,410,1436)  	--小怪
	mSleep(5000)
	blockrectgetposclick(getlittlepos,90,363,1296,410,1436)  	--小怪
	mSleep(5000)
	--]]
	--blockcolorclick(425,1640,0xe0c27f) 											--人物对话
	--[[
	blockrectgetposclick(getposyellow,95,384,1148,463,1804)  	--人物对话
	mSleep(5000)
	blockrectgetposclick(getposyellow,95,384,1148,463,1804)  	--人物对话
	mSleep(5000)
	blockrectgetposclick(getlittlepos,90,363,1296,410,1436)  	--小怪
	mSleep(5000)
	blockrectgetposclick(getlittlepos,90,363,1296,410,1436)  	--小怪
	mSleep(5000)
	blockrectgetposclick(getlittlepos,90,363,1296,410,1436)  	--小怪
	--]]
end

--财神降临
function caishenjianglin()
	--获取财神坐标
	x,y = catchTouchPoint()
	logpos(x,y)
	--循环操作
	while true do
		--sysLog("click..."..x.." ,"..y)
		nologclick(x,y) 					--点击财神，15修改成了10
		mSleep(10)
		nologclick(425,1465) 				--接取任务
		mSleep(10)
		nologclick(410,1176)     			--进入副本
		mSleep(10)
	end
end

--帮会演武
function banghuiyanwu()
	yanwu=function()
		d = function(x,y) mSleep(1000) click(x,y) click(290,1280) end  		--选则假人
		page = function()
			--290,1280,0xdcbe7a,做完之后返回
			mSleep(1000)
			onlywork(function() return checkcoloraccurate(290,1280,0xdcbe7a,500) end,function() d(629,562) end)		--蓝629,562,0x608af7	 	
			onlywork(function() return checkcoloraccurate(290,1280,0xdcbe7a,500) end,function() d(629,752) end)   	--紫629,752,0xb932e8
			onlywork(function() return checkcoloraccurate(290,1280,0xdcbe7a,500) end,function() d(629,958) end)   	--橙629,958,0xff8022
			onlywork(function() return checkcoloraccurate(290,1280,0xdcbe7a,500) end,function() d(629,1160) end)  	--金629,1160,0xfcc423
			onlywork(function() return checkcoloraccurate(290,1280,0xdcbe7a,500) end,function() d(629,1358) end)  	--红629,1358,0xff2044
		end
		sysLog("开始选择演武假人...")
		delayclick(1000,718,114)											--打开演武假人页面
		for i=1,3 do
			page()															--找演武假人
			--如果已经找到演武假人，开始演武就直接退出
			if not checkcoloraccurate(290,1280,0xdcbe7a,500) then 
				return 
			end
			sysLog("翻页...")
			onlycolorclick(653,454,0xb7a676)                           		--翻到下一页找假人
		end
		onlycolorclick(849,1459,0x391a18)                            		--关闭选酒界面
	end

	getposclick(getactivitypos)
	delayclick(1000, getposdaily(getposbanghuiyanwu))  --帮会演武
	delayclick(1000, 408, 1178)                        --进入帮会
	mSleep(20000)
	yanwu()
	mSleep(205*1000)
	yanwu()
	mSleep(210*1000)
	tuichubanghuizhudi()															 --退出帮会
end


--黑风寨据点环跑
function heifengzhaijudianhuanpao()
	getposclick(getactivitypos)																	--点击活动
	delayclick(1000,626,1783)																	--点击限时任务
	delayclick(1000, getposdaily(getposheifengzhaijudianhuanpao))								--黑风寨据点环跑
	blockcolorclick(422,1648,0x7ba3d9)															--接取任务
	delayclick(1000,406,1179)																	--确认接取任务
	blockcolorclick(423,1632,0xdfc17d)															--开始据点建设
	blockcolorclick(423,1632,0xdfc17d)															--收取饷银
	blockcolorclick(423,1632,0xdfc17d)															--交接任务
end

--五仙寨据点环跑
function wuxianzhaijudianhuanpao()
	getposclick(getactivitypos)																	--点击活动
	delayclick(1000,626,1783)																	--点击限时任务
	delayclick(1000, getposdaily(getposwuxianzhaijudianhuanpao))								--五仙寨据点环跑
	blockcolorclick(422,1648,0x7ba3d9)															--接取任务
	delayclick(1000,406,1179)																	--确认接取任务
	blockcolorclick(423,1632,0xdfc17d)															--开始据点建设
	blockcolorclick(423,1632,0xdfc17d)															--收取饷银
	blockcolorclick(423,1632,0xdfc17d)															--交接任务
end

--安锋营据点环跑
function anfengyingjudianhuanpao()
	getposclick(getactivitypos)																	--点击活动
	delayclick(1000,626,1783)																	--点击限时任务
	delayclick(1000, getposdaily(getposanfengyinghuanpao))										--五仙寨据点环跑
	blockcolorclick(422,1648,0x7ba3d9)															--接取任务
	delayclick(1000,406,1179)																	--确认接取任务
	blockcolorclick(423,1632,0xdfc17d)															--开始据点建设
	blockcolorclick(423,1632,0xdfc17d)															--收取饷银
	blockcolorclick(423,1632,0xdfc17d)															--交接任务
end

--沙水营据点环跑
function shashuiyingjudianhuanpao()
	getposclick(getactivitypos)																	--点击活动
	delayclick(1000,626,1783)																	--点击限时任务
	delayclick(1000, getposdaily(getposshashuiyinghuanpao))  									--五仙寨据点环跑
	blockcolorclick(422,1648,0x7ba3d9)															--接取任务
	delayclick(1000,406,1179)																	--确认接取任务
	blockcolorclick(423,1632,0xdfc17d)															--开始据点建设
	blockcolorclick(423,1632,0xdfc17d)															--收取饷银
	blockcolorclick(423,1632,0xdfc17d)															--交接任务
end

--领取每日活动奖励
function getreward()
	getposclick(getactivitypos)							--打开活动界面
	delaywork(2000, function() click(240,950) end)   	--竹蜻蜓
	delaywork(2000, function() click(240,1175) end)  	--硬币
	delaywork(2000, function() click(240,1390) end)  	--宝石礼包
	delaywork(2000, function() click(240,1620) end)  	--金币
	delaywork(2000, function() click(1014,1747) end) 	--关闭
end

--节日任务
function jierirenwu()
	getposclick(getactivitypos)											 	--打开活动界面
	delayclick(2000,626,1783)												--点击限时任务
	--delayclick(2000, getposdaily(getposjieri))  							--点击节日任务
	delayclick(2000, getdailypos(1,1))  									--点击节日任务

	blockrectgetposclick(getposjieriblue, 90, 390, 1198, 456, 1734)      	--接取任务
	
	delaywork(2000,talk)													--跳过对话

	dict={{getlittlepos,90,363,1296,410,1436},{getposyellow,90,384,1148,463,1804},{getposlinqujiangli,90, 404, 1384, 445, 1573}}
	
	for i=1,6 do
		blockrectgetposanyclick(dict)
		mSleep(3000)
	end
end

--恶人悬赏
function erenxuanshang()
	while true do
		nologclick(173,1750)
		mSleep(100)
	end
end

--一气呵成
function yiqihecheng()
	switchtoteam()
	delayclick(1000,635,270)  													--便捷组队
	delayclick(1000,688,342)														--点击一气呵成
	delayclick(1000,102,1566)													--点击自动匹配
	delayonlyrectgetposclick(500, getposjixupipei, 95, 387, 667, 428, 816)		--如果没有适合队伍，继续匹配
	delayclick(1000,1014,1748)													--1014,1748,0x391a19，关闭匹配界面
	blockrectgetposclick(getposgenshuiduizhang, 95, 349, 0, 546, 179)			--跟随队长
	delaywork(1000,switchtotask)												--切换回任务
end

--江湖行侠，一次只能使用一个令牌
function jianghuxingxia()
	drink=function()
		d = function(x,y) mSleep(1000) click(x,y) mSleep(1000) click(378,960) end  --选令牌，使用令牌		378,960,0xf7df9a
		page = function()
			mSleep(1000)
			onlywork(function() return checkcoloraccurate(378,960,0xf7df9a,100) end,function() d(593,647) end) 	 --蓝令牌593,647,0x608af7
			onlywork(function() return checkcoloraccurate(378,960,0xf7df9a,100) end,function() d(593,803) end)   --紫令牌593,803,0xb932e8
			onlywork(function() return checkcoloraccurate(378,960,0xf7df9a,100) end,function() d(593,962) end)   --橙令牌593,962,0xff8022
			onlywork(function() return checkcoloraccurate(378,960,0xf7df9a,100) end,function() d(593,1119) end)  --金令牌593,1119,0xfcc423
			onlywork(function() return checkcoloraccurate(378,960,0xf7df9a,100) end,function() d(593,1276) end)  --红令牌593,1276,0xff2044
		end

		for i=1,3 do
			page()														--找令牌使用
			--如果已经使用令牌，直接退出
			if not checkcoloraccurate(378,960,0xf7df9a,100) then 					--378,960,0xf7df9a，使用按钮
				return 
			end
			sysLog("翻页...")
			onlycolorclick(618,532,0xcab988)                           	--翻到下一页使用令牌618,532,0xcab988
		end
	end

	getposclick(getactivitypos)
	delaywork(2000, function() click(getposdaily(getjianghuxingxiapos)) end)
	mSleep(1000)
	drink()
	delayclick(1000,405,1179)										--确认使用令牌405,1179,0xddbf7b
	delayclick(2000,getcurrenttaskpos())								--寻路
	--workuntil(function() x,y=getposjishalittlemonster(50, 458, 7, 808, 216) if x > -1 then return false else return true end,function() mSleep(5000) click(getcurrenttaskpos()) end) --继续战斗，直到退出
	workuntil(function() x,y=getposkillwildmonster(50, 458, 7, 808, 216) if x > -1 then return false else return true end end,function() mSleep(5000) click(getcurrenttaskpos()) end) --继续战斗，直到退出
	mSleep(60*1000)			--等待装备自动回蓝回血
	
	getposclick(getactivitypos)
	delaywork(2000, function() click(getposdaily(getjianghuxingxiapos)) end)
	mSleep(1000)
	drink()
	delayclick(1000,405,1179)										--确认使用令牌405,1179,0xddbf7b
	delayclick(2000,getcurrenttaskpos())							--寻路
	workuntil(function() x,y=getposkillwildmonster(50, 458, 7, 808, 216) if x > -1 then return false else return true end end,function() mSleep(5000) click(getcurrenttaskpos()) end) --继续战斗，直到退出
	mSleep(60*1000)			--等待装备自动回蓝回血
end

--周一周四8点进入,只抓贼，捡装备，调试OK
function banghuiyaoyuan()
	sysLog("帮会药园")
	switchtotask()
	delayclick(500,705,145)		--点击当前任务
	delayclick(500,622,1526)	--点击去帮忙，抓贼
	delayclick(500,405,1180)	--点击确认，进入帮会
	mSleep(1000*5)				--进入帮会延时
	blockrectgetposclick(getyaoyuanpos, 95, 402, 1332, 450, 1433)
	blockrectgetposclick(getyaoyuanzhuazeipos, 95, 32, 221, 82, 345)	--点南宫秋开始任务
	blockrectgetposclick(getyaoyuanzhuazeipos, 95, 32, 221, 82, 345)	--点南宫秋结束任务
	
	delayclick(500,705,145)		--点击当前任务
	delayclick(500,622,1526)	--点击去帮忙，抓贼
	blockrectgetposclick(getyaoyuanpos, 95, 402, 1332, 450, 1433)
	blockrectgetposclick(getyaoyuanzhuazeipos, 95, 32, 221, 82, 345)	--点南宫秋开始任务
	blockrectgetposclick(getyaoyuanzhuazeipos, 95, 32, 221, 82, 345)	--点南宫秋结束任务

	delayclick(500,705,145)		--点击当前任务
	delayclick(500,622,1526)	--点击去帮忙，抓贼
	blockrectgetposclick(getyaoyuanpos, 95, 402, 1332, 450, 1433)
	blockrectgetposclick(getyaoyuanzhuazeipos, 95, 32, 221, 82, 345)	--点南宫秋开始任务
	blockrectgetposclick(getyaoyuanzhuazeipos, 95, 32, 221, 82, 345)	--点南宫秋结束任务

	--等待果实成熟，捡装备
end

--龙盘虎踞(开放日)不是自己帮会据点，只参拜帮主
function longpanhujukaifangri()
	isInjudian = testrectgetpos(getposdiancicanjiajudianhuodong, 95, 456, 15, 717, 282)
	getposclick(getactivitypos)																	--点击活动
	delayclick(1000,626,1783)																	--点击限时任务
	delayclick(1000, getposdaily(getposlongpanhujukaifangri))									--黑风寨据点环跑
	if isInjudian then
		mSleep(40*1000)																				--防止当前还在前一个据点没有退出
	end

	blockrectgetposclick(getposdiancicanjiajudianhuodong, 95, 456, 15, 717, 282)				--点击当前据点活动712,162,0x20150c
	--delayclick(1000,712,162)																	--点击当前据点活动712,162,0x20150c
	delayclick(8000,768,1489)																	--点击参拜帮主活动768,1489,0xcbaf71
	delayclick(2000,424,1478)																	--参拜帮主424,1478,0x7da4da
	mSleep(10000)
end

--龙盘虎踞-五仙寨
function longpanhujuwuxianzhai()
	isInjudian = testrectgetpos(getposdiancicanjiajudianhuodong, 95, 456, 15, 717, 282)
	getposclick(getactivitypos)																	--点击活动
	delayclick(1000,626,1783)																	--点击限时任务
	delayclick(1000, getposdaily(getposlongpanhujuwuxianzhai))									--龙盘虎踞-五仙寨,寻路
	if isInjudian then
		mSleep(40*1000)																				--防止当前还在前一个据点没有退出
	end
	--参拜帮主
	blockrectgetposclick(getposdiancicanjiajudianhuodong, 95, 456, 15, 717, 282)				--点击当前据点活动712,162,0x20150c
	--delayclick(1000,712,162)																	--点击当前据点活动712,162,0x20150c
	delayclick(5000,768,1489)																	--点击参拜帮主活动768,1489,0xcbaf71
	delayclick(2000,424,1478)																	--参拜帮主424,1478,0x7da4da
	mSleep(10000)

	--划拳
	delayclick(1000,712,162)																	--点击当前据点活动712,162,0x20150c
	delayclick(1000,616,1489)																	--点击酒馆活动616,1489,0xccb072
	blockgetsamelineclick(452,1267,1667,50,424,1499)
	count = 0
	while count < 3 do
		delaytouchclick(1000,3000,408,965)
		if testrectgetpos(getposfu, 95, 652, 1070, 761, 1173) then			--负
			count = count + 1
		end
		if testrectgetpos(getpossheng, 95, 657, 1071, 758, 1175) then		--胜
			count = count + 1
		end
	end
	delayclick(1000,942,1627)												--关闭942,1627,0x391a18

	--赌坊
	delayclick(1000,712,162)																	--点击当前据点活动712,162,0x20150c
	delayclick(1000,460,1490)																	--点击赌坊活动616,1489,0xccb072
	blockgetsamelineclick(452,1267,1667,50,424,1499)
	count = 0
	while count < 3 do
		delaytouchclick(1000,3000,300,963)
		mSleep(5000)																--防遮挡
		if testrectgetpos(getposdufangfu, 95, 247, 1066, 375, 1181) then			--负
			count = count + 1
		end
		if testrectgetpos(getposdufangsheng, 95, 247, 1066, 375, 1184) then			--胜
			count = count + 1
		end
	end
	delayclick(1000,943,1625)												--关闭943,1625,0x381a18

	--江湖百事通
	baishitong=function()
		--百事通-宝图
		delayclick(1000,712,162)																	--点击当前据点活动712,162,0x20150c
		delaywork(1000,function() touchmovestepaccurate(386,793, 386 + 290,793) end)				--移动两格
		delayclick(1000,292,1489)																	--点击江湖百事通活动616,1489,0xccb072
		blockgetsamelineclick(452,1267,1667,50,424,1480)
		delayclick(1000,406,1178)																	--确定购买406,1178,0xddc07c)
		delaywork(500,talk)
		delaywork(500,talk)
		delaywork(500,talk)
	end
	for i=1,3 do
		baishitong()
	end

	--风水宝地
	delayclick(1000,712,162)																	--点击当前据点活动712,162,0x20150c
	delayclick(1000,292,1489)																	--点击风水宝地活动616,1489,0xccb072
	blockgetsamelineclick(452,1267,1667,50,424,1477)
	delaywork(1000,function() moveup(1000) end)
	mSleep(3000*1000)																			--50分钟
end

--龙盘虎踞-沙水营
function longpanhujushashuiying()
	isInjudian = testrectgetpos(getposdiancicanjiajudianhuodong, 95, 456, 15, 717, 282)
	getposclick(getactivitypos)																	--点击活动
	delayclick(1000,626,1783)																	--点击限时任务
	delayclick(1000, getposdaily(getposlongpanhujushashuiying))									--龙盘虎踞-沙水营,寻路
	if isInjudian then
		mSleep(40*1000)																				--防止当前还在前一个据点没有退出
	end
	--参拜帮主
	blockrectgetposclick(getposdiancicanjiajudianhuodong, 95, 456, 15, 717, 282)				--点击当前据点活动712,162,0x20150c
	--delayclick(1000,712,162)																	--点击当前据点活动712,162,0x20150c
	delayclick(8000,768,1489)																	--点击参拜帮主活动768,1489,0xcbaf71
	delayclick(2000,424,1478)																	--参拜帮主424,1478,0x7da4da
	mSleep(10000)

	--划拳
	delayclick(1000,712,162)																	--点击当前据点活动712,162,0x20150c
	delayclick(1000,616,1489)																	--点击酒馆活动616,1489,0xccb072
	blockgetsamelineclick(452,1267,1667,50,424,1499)
	count = 0
	while count < 3 do
		delaytouchclick(1000,3000,408,965)
		if testrectgetpos(getposfu, 95, 652, 1070, 761, 1173) then			--负
			count = count + 1
		end
		if testrectgetpos(getpossheng, 95, 657, 1071, 758, 1175) then		--胜
			count = count + 1
		end
	end
	delayclick(1000,942,1627)												--关闭942,1627,0x391a18

	--赌坊
	delayclick(1000,712,162)																	--点击当前据点活动712,162,0x20150c
	delayclick(1000,460,1490)																	--点击赌坊活动616,1489,0xccb072
	blockgetsamelineclick(452,1267,1667,50,424,1499)
	count = 0
	while count < 3 do
		delaytouchclick(1000,3000,300,963)
		mSleep(5000)																--防遮挡
		if testrectgetpos(getposdufangfu, 95, 247, 1066, 375, 1181) then			--负
			count = count + 1
		end
		if testrectgetpos(getposdufangsheng, 95, 247, 1066, 375, 1184) then			--胜
			count = count + 1
		end
	end
	delayclick(1000,943,1625)												--关闭943,1625,0x381a18

	--江湖百事通
	baishitong=function()
		--百事通-宝图
		delayclick(1000,712,162)																	--点击当前据点活动712,162,0x20150c
		delaywork(1000,function() touchmovestepaccurate(386,793, 386 + 290,793) end)				--移动两格
		delayclick(1000,292,1489)																	--点击江湖百事通活动616,1489,0xccb072
		blockgetsamelineclick(452,1267,1667,50,424,1480)
		delayclick(1000,406,1178)																	--确定购买406,1178,0xddc07c)
		delaywork(500,talk)
		delaywork(500,talk)
		delaywork(500,talk)
	end
	for i=1,3 do
		baishitong()
	end

	--风水宝地
	delayclick(1000,712,162)																	--点击当前据点活动712,162,0x20150c
	delayclick(1000,292,1489)																	--点击风水宝地活动616,1489,0xccb072
	blockgetsamelineclick(452,1267,1667,50,424,1477)
	delaywork(1000,function() moveup(1000) end)
	mSleep(3000*1000)																			--50分钟
end
