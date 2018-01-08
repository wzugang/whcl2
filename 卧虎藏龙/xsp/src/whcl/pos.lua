require("utils/log")
require("utils/color")

function getactivitypos()
	return 1020,1394
end

function getbeibaopos()
	return 1010,1514
end

function getautopos()
	return 565,1700
end

function getbeatpos()
	return 165,1752
end

function gettaskpos()
	return 838,90
end

function getteampos()
	return 835,275
end

function getcurrenttaskpos()
	return 735,160
end

--737,143,0x272a33
--904,925,0x282a33
function linecolumntorect(x,y)
	x1 = 737 - (x-1)*172.5
	x2 = 904 - (x-1)*172.5
	y1 = 143 + (y-1)*792
	y2 = 925 + (y-1)*792
	sysLog("linecolumntorect, x1:"..x1..", y1:"..y1..", x2:"..x2..", y2:"..y2)
	--logrect(x1,y1,x2,y2)
	return x1,y1,x2,y2
end

--737,143,0x272a33
--904,925,0x282a33
function linecolumntorectlittle(x,y)
	x1 = 823 - (x-1)*172.5
	x2 = 888 - (x-1)*172.5
	y1 = 746 + (y-1)*792
	y2 = 910 + (y-1)*792
	sysLog("linecolumntorectlittle, x1:"..x1..", y1:"..y1..", x2:"..x2..", y2:"..y2)
	--logrect(x1,y1,x2,y2)
	return x1,y1,x2,y2
end

--获取日常任务坐标，基础坐标823,746,888,910,能计算就不要查找，后续需要添加滑动
--每一行相差172.5距离
function getdailypos(x,y)
	moveX=0
	x1,y1,x2,y2=linecolumntorectlittle(x,y)
	--logrect(x1,y1,x2,y2)
	x3 = math.ceil((x1+x2)/2)
	y3 = math.ceil((y1+y2)/2)

	while ((x3 + moveX) < 316) do		--543改为316
		moveX = moveX + 172.5
	end

	if moveX > 0 then
		moveX = math.ceil(moveX)
		sysLog("getdailypos move...")
		--touchmoveaccurate(480, 520, 480 + moveX, 520)
		touchmovestepaccurate(480, 520, 480 + moveX, 520)
	end
	sysLog("getdailypos, x:"..x3+moveX.." ,y:"..y3)
	return x3+moveX,y3
end
--x:392-900,508,
--y:143-1717,1574,787
--392,143,900,1713
function getdailylinecolumn(x,y)
	rline = math.ceil((900-x)/172)
	rcolumn = math.ceil((y-143)/792)
	sysLog("getdailylinecolumn, ".."line:"..rline.." ,column:"..rcolumn)
	--logpos(rline,rcolumn)
	return rline,rcolumn
end

function getposdaily(func)
	sysLog("getposdaily...")
	down=true
	count=0
	movecount=5 --这里设置的大，过大的话内部会进行调整
	degree=100
	line=0
	column=0
	adjust=false
	mSleep(500)		--等待稳定再移动
	_,x,y = testrectgetpos(func,degree,316,143,903,1713)
	if _ then
		--大范围找到后再小范围查找，确认
		line,column = getdailylinecolumn(x,y)
		if (line > 0 and column > 0) then
			_,x,y=testrectgetpos(func,degree,linecolumntorect(line,column))
		else
			_ = false
		end
	end
	while not _ do
		sysLog("count :"..count)
		sysLog("degree:"..degree)
		if not adjust then
			if(down) then
				--touchmoveaccurate(480, 520, 480 + 172.5, 520)		--必须精确到小数，不然找点会出错
				if (movecount - count - 2) > 0 then
					touchmovestepaccurate(480, 520, 480 + 345, 520)
					count = count + 2
				else
					touchmovestepaccurate(480, 520, 480 + 172.5, 520)
					count = count + 1
				end
				if not checklinesamecolor(905,200,256,7) then
				--if not checkcolor(879,749,0xddbb77, 100) then 	--颜色不对，移动差79像素一行，需要回调93，需要进行调整905,454,0x2c2e38|826,233,0x18181a|<879,749,0xddbb77
					mSleep(1000)
					if not checklinesamecolor(905,200,256,7) then
					--if not checkcolor(879,749,0xddbb77, 100) then 	--颜色不对，移动差79像素一行，需要回调93，需要进行调整905,454,0x2c2e38|826,233,0x18181a|<879,749,0xddbb77
						sysLog("start adjust...")
						--touchmoveaccurate(480 + 93, 520, 480, 520)
						touchmovestepaccurate(480 + 93, 520, 480, 520)
						sysLog("start finish...")
						count = count - 1
						down = false
						adjust = true
						degree = degree - 5
						mSleep(1000)
					end
				end
				if not adjust then
					sysLog("move down...")
					if(count == movecount) then
						down = false
						degree = degree - 5
					end
				end
			else
				--touchmoveaccurate(480 + 172.5, 520, 480, 520)
				if (count - 2) >= 0 then
					touchmovestepaccurate(480 + 345, 520, 480, 520)
					count = count -2
				else
					touchmovestepaccurate(480 + 172.5, 520, 480, 520)
					count = count -1
				end
				sysLog("move up...")
				if(count == 0) then
					down = true
					degree = degree - 5
				end
			end
		else
			adjust = false
		end
		if not adjust then 
			mSleep(1000)
			_,x,y = testrectgetpos(func,degree,316,143,903,1713) --392,143
			if _ then
				--大范围找到后再小范围查找，确认
				line,column = getdailylinecolumn(x,y)
				if (line > 0 and column > 0) then
					_,x,y=testrectgetpos(func,degree,linecolumntorect(line,column))
				else
					_ = false
				end
			end
		end
	end
	return getdailypos(line, column)
end

--660,270,689,333, y距离+315
--点击点距离查找点x-75
function getpaoshangpos(index)
	x1 = 655
	x2 = 695
	y1 = 265 + (index*315)
	y2 = 338 + (index*315)
	return x1,y1,x2,y2
end

--自动对话坐标
function gettalkpos()
	return 115,1345
end

function getlittlepos(degree, x1, y1, x2, y2) --任务巡视等...
	return findMultiColorInRegionFuzzy(0xfff99c,"-14|2|0xf7d07f,-14|-2|0xf5cf7f,-5|4|0xffea93,-2|9|0xfff99a,-11|10|0xffdf86,-18|5|0xfbcf79,-20|-1|0xf8ca74,-23|2|0xfccb73,-23|9|0xffcf74,-13|12|0xffdd83,-6|14|0xfff293,2|12|0xffffa3,2|2|0xffffa1,-9|0|0xffdb8a,-6|11|0xffee92,-2|14|0xfffe9b,-2|20|0xffff9e,2|20|0xffffa7,2|6|0xffffa1", degree, x1, y1, x2, y2, 0, 0)
end

function gethandinpos(degree, x1, y1, x2, y2) --上交，选择物品
	return findMultiColorInRegionFuzzy(0xcead6a,"12|0|0xdabc78,18|4|0xe2c480,16|19|0xdfc17d,2|34|0x393425,25|33|0xe7cd8a,6|43|0x7b755b,5|64|0x817c60,18|80|0x8d886a,13|95|0xcdb172,-5|99|0xc9a763,11|127|0xd8ba76,34|107|0xf3d792,33|90|0xf1d591,18|101|0x978357,15|125|0xdec07c,40|129|0xf7df9a,-2|129|0xccaa66,22|86|0xdfc281,12|59|0xdabc78", degree, x1, y1, x2, y2, 0, 0)
end

function getmakedrugpos() --炼药，药炉
	return findMultiColorInRegionFuzzy(0xffd075,"20|-1|0xfffd9c,4|19|0xfef4be,-6|15|0x9f8045,9|14|0xe9e0af,12|28|0xf9efbb,9|61|0x7a755b,2|46|0x655331,2|31|0x3a372a,-6|19|0xffcc6e,2|19|0xfff5bf,0|38|0x29271d,20|38|0xfef4be,21|48|0xe2d9aa,12|67|0x312b1d,-1|81|0xffcd74,18|85|0xfff498,10|53|0xfdf3bd,-2|51|0xfcf2bc,21|47|0xbeb78f", 70, 367, 1300, 404, 1430, 0, 0)
end

function getpaoshangposlow(degree,x1,y1,x2,y2)
	return findMultiColorInRegionFuzzy(0x60f61c,"-15|-2|0x60f71c,-23|-2|0x5be91a,-7|12|0x5ff31c,-25|20|0x5ff51c,-15|12|0x5ff41c,-24|9|0x5ef31c,-23|10|0x56de19,-25|5|0x5ef21b,-4|-2|0x5ff61c,-3|-1|0x5bea1b,-1|-1|0x5ef11b,-1|0|0x5def1b,-17|-2|0x5cec1b,-24|18|0x59e61a,-16|18|0x57df19,-24|46|0x59e51a,0|42|0x56dd19", degree, x1, y1, x2, y2, 0, 0)
end

function getpaoshangposlowbak(degree,x1,y1,x2,y2)
	return findMultiColorInRegionFuzzy(0x60f61c,"-15|-2|0x60f71c,-23|-2|0x5be91a,-7|12|0x5ff31c,-25|20|0x5ff51c,-15|12|0x5ff41c,-24|9|0x5ef31c,-23|10|0x56de19,-25|5|0x5ef21b,-4|-2|0x5ff61c,-3|-1|0x5bea1b,-1|-1|0x5ef11b,-1|0|0x5def1b,-17|-2|0x5cec1b,-24|18|0x59e61a,-16|18|0x57df19,-24|46|0x59e51a,0|42|0x56dd19", degree, x1, y1, x2, y2, 0, 0)
end

function getpaoshangposlowbb(degree,x1,y1,x2,y2)
	return findMultiColorInRegionFuzzy(0x60f71c,"9|-31|0x5ff31c,11|-30|0x60f61c,5|-35|0x60f71c,5|-34|0x5ff51c,9|-30|0x57e119,8|-31|0x58e21a,9|-31|0x5ff31c,7|-31|0x48ba15,-3|-16|0x60f71c,-16|-8|0x5ef31c,-17|-8|0x50cd17,-16|-7|0x368c10,-15|-8|0x59e61a,-15|0|0x60f71c,-16|0|0x5def1b,-17|0|0x35880f,-16|-1|0x4fcb17,-17|2|0x132f06,-16|25|0x399210", degree, x1, y1, x2, y2, 0, 0)
end

--黄色任务触发按钮
function getyellowpos(same,x1,y1,x2,y2) --查找黄色坐标
	return findMultiColorInRegionFuzzy(0xffffff,"0|-7|0xfffff2,-6|0|0xffffe8,-3|-4|0xffffeb,0|-136|0xfffff5,-6|-136|0xffffec,0|-129|0xfffff4,-3|-132|0xffffeb,2|-138|0xffddaa,5|-140|0xcdc9ba,5|4|0xceccbd,2|2|0xffe191,-44|-140|0xa1a47d,-43|-139|0xb29e59,-42|-138|0xffef92,-41|-137|0xfad671,-44|4|0xa6a683,-43|3|0xc4a66b,-42|2|0xfff69c,-41|2|0xffc770", same, x1, y1, x2, y2, 0, 0)
end

function getposyellow(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xe1c380,"2|0|0xe3c581,5|0|0xe4c683,8|0|0xe6c885,13|1|0xe5cb88,13|4|0xe5cb88,13|7|0xe5cb88,13|10|0xe5cb88,13|12|0xe5cb88,13|13|0xe5cb88,13|15|0xe5cb88,13|17|0xe5cb88,10|17|0xe7c986,8|17|0xe6c885,5|17|0xe4c683,4|17|0xe4c683,4|12|0xe4c683,5|8|0xe4c683,5|4|0xe4c683,5|0|0xe4c683", degree, x1, y1, x2, y2, 0, 0)
end

--黄色任务对话框
function getyellowposbig(same,x1,y1,x2,y2)
	return findMultiColorInRegionFuzzy(0xfff2c2,"-5|5|0xfcf9d0,-4|4|0xfff5c9,-3|3|0xffe09c,-2|2|0xffe09c,0|10|0xfdf1c0,-2|5|0xfffedd,-76|-2|0xbb9353,-76|-3|0xbd8a57,-78|0|0xebdaa7,0|652|0xf9f1cb,0|651|0xfdfada,-3|647|0xfffede,-10|652|0xf6e2a7,-3|649|0xffe09c,3|646|0xb08e5b,3|654|0xbd9c58,2|658|0x323132,-77|655|0xc59360,-78|655|0xe5b784", same,x1,y1,x2,y2, 0, 0)
end

function getbluepos(degree,x1,y1,x2,y2) --查找蓝色坐标
	return findMultiColorInRegionFuzzy(0x79a1d7,"8|-1|0x7fa6dc,14|1|0x82a9df,9|9|0x7fa6dc,5|9|0x7da4da,-1|10|0x79a1d7,-1|20|0x79a1d7,-5|24|0x779fd5,1|32|0x7aa2d8,16|31|0x83aae0,5|27|0x7da4da,5|46|0x7da4da,5|56|0x7da4da,8|53|0x7fa6dc,2|58|0x7aa2d8,8|66|0x7fa6dc,6|45|0x7da4db,-2|22|0x78a0d6,-4|6|0x779fd5,-8|-1|0x759dd3", degree, x1, y1, x2, y2, 0, 0)
end

function getpaoshangstartpos()
	return findMultiColorInRegionFuzzy(0xfff5bf,"12|-9|0xf7edb9,13|-9|0xfdf3be,14|-8|0xc1ba91,0|-7|0xf5ecb8,-1|-7|0xe8dfae,1|-6|0xd1c99c,-2|-6|0x938e6e,3|32|0xf3eab6,4|32|0xc8c096,3|73|0xe1d8a8,-3|69|0xf8eeba,-3|65|0xfef4be,-5|102|0xf1e8b5,-9|93|0xece3b1,-10|87|0xfcf2bd,-8|86|0xede3b1,6|71|0xf6ecb8,3|72|0xf6edb9,3|73|0xe1d8a8", 60, 406, 1406, 444, 1551, 0, 0)
end

function getpaoshangbuy()
	return 399,1097
end

function getpaoshangshoppos(degree,x1,y1,x2,y2)
	return findMultiColorInRegionFuzzy(0xaccefa,"0|10|0xa9cefa,-4|5|0xb7d9fc,-74|0|0x7ea8d9,-71|5|0x87b0ea,-69|5|0x80a9e3,-71|2|0x648dc6,-2|2|0x9cbef1,-78|654|0x86a9dc,-76|654|0x537db0,-75|653|0x729cd5,-74|652|0x7fa7e1,-74|651|0x85aee7,-71|650|0x658ec8,-69|647|0x82abe5,-5|647|0xb2d5fb,-4|649|0xaaccf6,-3|650|0x9dbff1,-2|651|0xafd1fb,0|652|0xabcefa", degree, x1, y1, x2, y2, 0, 0)
end

function getpaoshanggreypos(degree,x1,y1,x2,y2)
	return findMultiColorInRegionFuzzy(0xc9c9c0,"-5|5|0xc7c7bf,0|10|0xd0c9c0,-9|0|0xc7c7bf,-56|1|0xafafa6,-48|0|0xababa2,-51|4|0xb6b1a9,-56|8|0xb0b0a8,-51|191|0xb7b7ae,-54|189|0x94948b,-51|188|0xb9b1a9,-51|187|0xb9b1a9,0|191|0xd1d1c0,0|187|0xd7cfc6,-4|187|0xd2cfc6,-5|186|0xc4c4bc,-30|153|0xa4a198,-7|112|0xbcb7b0,-49|87|0x928f86,-29|43|0xa5a299", degree, x1, y1, x2, y2, 0, 0)
end

function getpaoshang21(degree,x1,y1,x2,y2)
	return findMultiColorInRegionFuzzy(0xfdfadc,"0|-1|0xfffcdd,-4|-5|0xfdfad2,-2|-3|0xffe09c,-1|-2|0xffe5a7,-54|-2|0xd4bb5d,-53|-2|0xcdb45a,-52|-2|0xd2bb5f,-58|3|0xb88552,-57|2|0xc89c54,-57|1|0xdeb95b,-59|3|0xd7a875,-60|3|0xddb58a,-60|4|0xc2966b,-5|-80|0xf6df99,-51|-103|0xcaa862,-36|-172|0xd6b773,0|-191|0xfffad2,2|-193|0xceae6e,-58|-191|0xa99658", degree, x1, y1, x2, y2, 0, 0)
end

function getpaoshangkui(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfe0000,"-9|-3|0xf80000,-14|10|0xff0000,-18|9|0xef0000,-17|8|0xef0000,-17|0|0xea0000,-17|-1|0xfb0000,-8|-3|0xff0000,-18|1|0xfe0000,-19|3|0xfe0000,-17|0|0xea0000,-18|8|0xff0000,-15|9|0xe20000,-11|7|0xfe0000,-11|3|0xfe0000,-9|-3|0xf80000,-8|-3|0xff0000,-7|-3|0xff0000,-6|-3|0xff0000,-6|2|0xff0000", degree, x1, y1, x2, y2, 0, 0)
end

function getpaoshangkuihalf(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfe0000,"-13|7|0xff0000,-11|18|0xfd0000,-5|29|0xff0000,-2|36|0xfe0000,-17|32|0xf40000,-17|30|0xf00000,-16|27|0xc90000,-9|51|0xff0000,-17|45|0xf80000,-9|41|0xff0000,-2|46|0xff0000,-6|57|0xfc0000,-9|61|0xfe0000,-10|61|0xe10000,-16|63|0xf90000,-12|63|0xfc0000,-12|63|0xfc0000,-11|64|0xf50000,-14|63|0xe50000", degree, x1, y1, x2, y2, 0, 0)
end

function getpaoshangping(degree, x1, y1, x2, y2)
	--348,600,370,688
	--348,600,370,632
	return findMultiColorInRegionFuzzy(0x60f71c,"5|13|0x60f61c,3|13|0x45b214,6|17|0x4cc216,8|16|0x60f61c,-4|17|0x5be91a,-6|17|0x5ae71a,-5|17|0x60f71c,8|24|0x5cec1b,-2|24|0x5ff41c,-7|22|0x5ef31c,-6|22|0x5beb1b,-5|22|0x4abf16,-7|26|0x57df19,-7|25|0x5ff51c,-8|25|0x49bb15,-5|26|0x58e41a,-4|26|0x60f61c,-7|26|0x57df19,5|9|0x60f61c", degree, x1, y1, x2, y2, 0, 0)
end

--师门环跑
function getshimenpos(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"8|31|0xfbf1bc,9|31|0xf2e9b6,9|12|0xf7edb9,9|41|0xede4b2,8|41|0xf9efbb,7|32|0xeae1af,9|29|0xf6ecb8,2|76|0xfdf3bd,9|30|0xfdf3be,10|30|0xfef5bf,-1|80|0xf7eeb9,-9|110|0xfef4be,-6|105|0xe8dfae,-5|104|0xdfd6a7,1|79|0xfcf2bd,-6|103|0xd7cfa1,9|93|0xe7dead,8|92|0xebe1b0,-2|73|0xf3e9b6", degree, x1, y1, x2, y2, 0, 0)
end

--重温剧情
function getchongwenpos(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"-4|96|0xfef4be,-5|95|0xcac297,0|101|0xdad2a4,-8|103|0xeae1af,-4|103|0xdcd4a5,4|104|0xece3b1,8|109|0xfaf0bb,13|61|0xf2e9b5,13|37|0xede4b2,-4|-4|0xfdf3bd,0|-4|0xf1e7b4,4|6|0xdfd6a7,4|23|0xf8eeba,-12|63|0xfef5bf,-3|62|0xf8efba,-12|53|0xf5ecb8,-12|52|0xf4eab7,-11|52|0xf4ebb7,6|93|0xded5a6", degree, x1, y1, x2, y2, 0, 0)
end

--江湖酒仙
function getjiuxianpos(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"-24|66|0xdfd6a7,-18|66|0xfcf2bd,-22|98|0xfff5bf,-2|90|0xfff5bf,-2|106|0xfff5bf,2|99|0xf8eeba,-7|84|0xfff5bf,1|62|0xfff5bf,1|74|0xfcf2bd,0|50|0xfef4be,-8|50|0xfbf1bc,-18|50|0xfff5bf,-18|65|0xfcf2bd,-13|60|0xfef5bf,2|49|0xfaf0bb,-19|41|0xf2e8b5,-6|26|0xf6ecb8,-2|22|0xf5ecb8,-1|23|0xdad1a3", degree, x1, y1, x2, y2, 0, 0)
end

--帮会环跑
function getbanghuihuanpaopos(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"-6|8|0xfef5bf,-13|42|0xd5cd9f,-14|42|0xfaf0bb,12|41|0xfff5bf,10|-2|0xe3daaa,5|5|0xe6ddac,-6|12|0xede3b1,-14|111|0xfef4be,-5|105|0xf2e9b5,-4|105|0xf7edb9,-3|106|0xfef4be,-4|107|0xaca681,-14|92|0xf5ebb7,10|121|0xa9a27e,10|65|0xebe2b0,4|78|0xfdf3bd,0|81|0xf7eeb9,-4|79|0xfcf2bd,-14|40|0xfbf1bc", degree, x1, y1, x2, y2, 0, 0)
end

--侠客岛
function getxiakedaopos(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"-3|0|0xf5ebb7,-7|-1|0xfdf3be,-8|1|0xfcf2bc,-26|13|0xfef5bf,-9|-9|0xfef4be,-10|10|0xfef5bf,-17|2|0xe4dbab,-16|-3|0xe2d9a9,-17|-6|0xe6ddad,-16|-6|0xe7dead,-12|8|0xf9efba,-20|-31|0xf0e6b3,-17|-19|0xede4b1,-26|-22|0xfdf3bd,0|-32|0xfff5bf,-3|-44|0xfef4be,-14|-32|0xfff5bf,-7|-31|0xfff5bf,-21|-11|0x908a6c", degree, x1, y1, x2, y2, 0, 0)
end

--江湖跑商
function getjianghupaoshangpos(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"-23|-7|0xfef4be,0|-15|0xf7eeb9,1|17|0xfaf0bb,-5|65|0xf8eeba,-13|66|0xf1e8b5,-24|69|0xfef4bf,-5|26|0xf5ecb8,3|26|0xf9efba,-1|21|0xf6ecb8,-21|95|0xd6cea0,3|94|0xfff5bf,-3|89|0xf8eeb9,-22|107|0xfff5bf,0|107|0xf8eeba,-20|41|0xf2e8b5,-17|41|0xf5ebb7,-7|14|0xefe6b3,-9|18|0xf3e9b6,-20|35|0xd5cc9f", degree, x1, y1, x2, y2, 0, 0)
end

--镖行天下
function getbiaoxingtianxia(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"-6|2|0xc9c197,-2|0|0xf7eeb9,-4|0|0xf7edb9,-3|0|0xf1e7b4,-10|1|0xeae1af,-6|-13|0xfcf2bd,4|0|0xfef4be,5|1|0xc9c196,2|0|0xf4ebb7,2|5|0xf4eab7,3|5|0xfaf1bb,3|0|0xfbf1bc,-10|18|0xfaf0bb,-21|77|0xf7eeb9,5|22|0xeee5b2,-22|21|0xede4b1,-19|21|0xfff5bf,-4|39|0xfff5bf,-10|64|0xfff5bf", degree, x1, y1, x2, y2, 0, 0)
end

--宝图任务
function getbaoturenwupos(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"-10|-1|0xf1e8b5,7|-7|0xf7edb9,-10|33|0xe7dead,15|32|0xf5ecb8,16|32|0x8d886a,15|66|0xbbb48c,15|67|0xcdc59a,15|68|0xded6a6,15|69|0xeee5b3,3|69|0xfff5bf,-1|102|0xfff5bf,-8|91|0xfbf1bc,-9|91|0xefe6b3,10|95|0xf9efba,14|108|0xfff5bf,2|86|0xfef4be,4|96|0xede3b1,-6|93|0xf0e6b4,-10|13|0xbfb78f", degree, x1, y1, x2, y2, 0, 0)
end

--95, 830, 1108, 866, 1242
--江湖行侠
function getjianghuxingxiapos(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"9|-15|0xfff5bf,1|-16|0xfff5bf,-15|-16|0xf6edb8,7|-12|0xf1e8b5,-14|-7|0xf4eab7,-15|-7|0xddd4a5,7|27|0xfff5bf,-13|27|0xe5dcac,-7|30|0xfff5bf,-7|23|0xf4ebb7,-5|41|0xfef4be,2|41|0xfff5bf,9|39|0xfff5bf,-3|51|0xfff5bf,2|71|0xfff5bf,-11|71|0xf5ebb7,9|68|0xfff5bf,-6|98|0xfff5bf,0|84|0xfff5bf", degree, x1, y1, x2, y2, 0, 0)
end

--药园，95, 402, 1332, 450, 1433
function getyaoyuanpos(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"3|85|0xfff5bf,13|60|0xfff5bf,6|62|0xe9e0ae,-3|54|0xfbf1bc,-3|65|0xfef4be,18|60|0xfdf3be,-10|62|0xbeb78f,-1|57|0xfaf0bb,0|29|0xf7edb9,18|18|0xfff5bf,17|31|0xfff5bf,7|12|0xfef4be,-2|12|0xfff5bf,-8|17|0xfff5bf,7|26|0xfdf3be,-6|5|0x759dd3,9|6|0x80a7dd,-2|80|0x79a1d7,6|79|0x6e90bf", degree, x1, y1, x2, y2, 0, 0)
end

--抓贼，南宫秋95, 32, 221, 82, 345
function getyaoyuanzhuazeipos(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"-13|1|0xf0e6b4,-14|0|0xd3cb9e,-12|0|0xc8c096,16|-1|0xfef4be,16|-2|0xeee5b2,0|26|0xfff5bf,6|26|0xfff5bf,14|25|0xfef4be,7|34|0xfff5bf,-2|42|0xfff5bf,-12|49|0xfff5bf,-14|33|0xfff5bf,15|41|0xfef4be,10|49|0xfff5bf,-7|-37|0xfff5bf,-7|-33|0xece3b1,-1|-37|0xfff5bf,1|-41|0xfef5bf,2|-33|0xfff5bf", degree, x1, y1, x2, y2, 0, 0)
end

function getputong(degree) --普通重温剧情，任务对话框(普通两个字)
	return findMultiColorInRegionFuzzy(0x0a1112,"2|0|0x9b680f,3|0|0xf3a317,5|0|0x261a04,6|0|0x452f07,7|0|0x97650e,10|0|0x3a2606,12|0|0xdf9515,14|0|0x9e6a0f,22|0|0x121e1e,24|2|0xcc8913,20|-9|0xee9f16,22|44|0xec9e16,28|43|0xf3a317,15|40|0x1a1203,3|19|0xe39916,3|34|0xf3a317,6|36|0x82570c,5|36|0x4f3507,28|21|0xf1a217", degree, 454, 203, 796, 353, 0, 0)
end

function getdrinkover(degree)	--点此选酒
	x,y=findMultiColorInRegionFuzzy(0x60f71c,"-7|1|0x59e51a,6|13|0x5ef21b,-18|15|0x55dc19,-17|14|0x5ef21b,-17|6|0x60f71c,-16|6|0x60f71c,-13|-2|0x5ced1b,-13|-8|0x60f71c,-15|-9|0x60f61c,-7|2|0x59e51a,6|13|0x5ef21b,8|0|0x5ff41c,-4|-9|0x5ced1b,0|-8|0x60f71c,-5|106|0x60f61c,7|113|0x5ef31c,-12|95|0x60f71c,-17|89|0x60f71c,-2|72|0x60f71c", degree, 454, 203, 796, 353, 0, 0)
	if x <= -1 then
		sysLog("is drinking")
		return false
	end
	sysLog("drink wine")
	return true
end

function gethuzhongjiu(degree) --壶中酒
	x,y=findMultiColorInRegionFuzzy(0xffffff,"4|0|0xfefefe,-18|0|0xfefefe,-10|-10|0xffffff,-1|-10|0xffffff,-11|10|0xffffff,-1|11|0xffffff,-11|11|0xeaeaea,-1|-4|0xe9e9e9,-17|30|0xdbdbdb,-18|29|0xcecece,-13|31|0xf5f5f5,-8|27|0xffffff,-5|28|0xffffff,-8|32|0xfcfcfc,-9|33|0xf2f2f2,-2|32|0xffffff,3|31|0xf7f7f7,-12|-33|0xfefefe,-11|-18|0xfcfcfc", degree, 626, 107, 655, 197, 0, 0)
	if x <= -1 then
		sysLog("not found")
		return true  --找不到时结束，返回true
	end
	sysLog("found")
	return false
end

function getposyellowbig(degree, x1, y1, x2, y2) --师门环跑，索要账目
	return findMultiColorInRegionFuzzy(0xc9a763,"54|4|0xf1d691,22|65|0xdcbe7a,18|152|0xdabc78,29|190|0xe0c27e,28|230|0xdfc17d,24|415|0xddbf7b,29|386|0xe0c27e,30|434|0xe0c27f,30|449|0xe0c27f,28|487|0xdfc17d,25|531|0xdec07c,28|580|0xdfc17d,23|603|0xddbf7b,10|580|0xd5b571,13|500|0xd7b975,3|421|0xcdad6a,41|425|0xe6c885,45|543|0xe5cb88,51|316|0xedd38f", degree, x1, y1, x2, y2, 0, 0)
end

--95, 334, 1139, 599, 1692
function getposcaishenblue(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0x7ba3d9,"10|3|0x81a8de,3|12|0x7da4db,-8|11|0x779fd5,9|19|0x81a8de,1|27|0x7ca3d9,-12|14|0x749dd2,-4|4|0x79a1d7,13|5|0x83aae0,8|23|0x80a7dd,-7|23|0x779fd5,-7|4|0x779fd5,17|2|0x85ace2,0|24|0x7ba3d9,8|27|0x80a7dd,15|13|0x84abe1,10|2|0x81a8de,2|6|0x7da4da,6|23|0x7fa6dc,17|23|0x85ace2", degree, x1, y1, x2, y2, 0, 0)
end

--95, 260, 854, 550, 1413
function getposcaishenyellow(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xe1c37f,"-4|7|0xdbbd79,-4|-4|0xdbbd79,0|5|0xe1c37f,1|10|0xe2c480,-4|14|0xdbbd79,-1|11|0xdfc17d,-1|17|0xdfc17d,0|6|0xe1c37f,3|0|0xe5c784,7|8|0xe6cc89,4|19|0xe6c885,3|24|0xe5c784,-6|0|0xd9bb77,-7|-2|0xd7b975,-4|15|0xdbbd79,7|15|0xe6cc89,7|-2|0xe6cc89,-1|11|0xdfc17d,4|17|0xe6c885", degree, x1, y1, x2, y2, 0, 0)
end

function getposbanghuiyanwu(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfef4be,"1|-1|0xeee5b2,-6|-5|0xfff5bf,1|-5|0xfdf3be,-22|-3|0xf6ecb8,-21|-2|0xeae1af,-21|-3|0xfff5bf,-17|2|0xfbf1bc,-25|1|0xfff5bf,0|-15|0xfff5bf,-22|-10|0xfff5bf,-12|-21|0xfff5bf,-25|-24|0xfcf2bd,-4|-26|0x373529,2|-24|0x1e1e19,2|-42|0xfff5bf,4|-44|0x121313,4|-43|0x3b392d,-15|-41|0xfff5bf,-25|-31|0xfbf1bc", degree, x1, y1, x2, y2, 0, 0)
end

--黑风寨据点环跑95, 487, 316, 519, 549
function getposheifengzhaijudianhuanpao(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"9|0|0xfff5bf,5|-11|0xfff5bf,-4|0|0xfff5bf,-9|0|0xebe2b0,-17|-14|0xfbf1bc,-16|14|0xf0e7b4,9|12|0xf7eeb9,10|13|0x4a4738,-5|33|0xfff5bf,-5|22|0xfff5bf,-6|43|0xfff5bf,9|33|0xfdf3bd,-9|105|0xf1e7b4,-13|111|0xfef4be,3|104|0xfff5bf,-6|85|0xf5ecb8,7|144|0xede2b1,-16|145|0xf3eab6,-17|137|0xfaf0bb", degree, x1, y1, x2, y2, 0, 0)
	--return  findMultiColorInRegionFuzzy(0xf9f0bb,"10|0|0xdcd4a5,10|23|0xcec69a,0|23|0xf5ecb8,0|12|0xfff5bf,9|11|0xfff5bf,5|5|0xf5ecb8,6|18|0xfef4be,0|6|0xfff5bf,0|18|0xfff5bf,-4|11|0xfff5bf,-4|1|0xfff5bf,-4|20|0xfff5bf,-9|24|0xebe2b0,-9|11|0xebe2b0,-9|-1|0xebe2b0,-14|0|0xfef5bf,-15|7|0xfaf0bb,-15|15|0xfff5bf,-15|24|0xfef4be", degree, x1, y1, x2, y2, 0, 0)
	--return findMultiColorInRegionFuzzy(0xfff5bf,"0|1|0xfff5bf,10|-10|0xefe5b3,10|-11|0xdcd4a5,10|-12|0x757158,-17|-15|0x53503e,-17|-14|0xfbf1bc,-18|-14|0x837d62,-9|0|0xebe2b0,-8|1|0xfef4be,-8|-1|0xf2e9b5,-8|-2|0xdfd6a7,-8|-3|0xd8d0a2,-17|14|0xccc499,-16|14|0xf0e7b4,-15|14|0xcec69a,-16|15|0x8c8769,-12|6|0x1d1c17,-13|5|0xfff5bf,-11|47|0xfdf3be", degree, x1, y1, x2, y2, 0, 0)
	--return findMultiColorInRegionFuzzy(0xfff5bf,"-9|1|0xfff5bf,-16|-3|0xf5ebb7,-9|-5|0xfcf2bc,9|3|0xfcf2bd,4|6|0xfbf1bc,5|-5|0xfdf3be,5|-6|0xf6edb8,4|-5|0xfdf3bd,-16|14|0xfaf0bb,9|32|0xf2e9b5,-5|33|0xfff5bf,-11|47|0xfdf3bd,-17|46|0xfef4be,10|67|0xf9efba,-17|67|0xf4ebb7,0|66|0xccc499,4|66|0xccc499,-17|106|0xf7eeb9,-17|129|0xf6ecb8", degree, x1, y1, x2, y2, 0, 0)
end

--五仙寨据点环跑95, 487, 1110, 519, 1340
function getposwuxianzhaijudianhuanpao(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"9|-8|0xfff5bf,9|15|0xfdf3be,-1|12|0xfff5bf,-6|12|0xf7edb9,-4|13|0xe9e0ae,-15|-8|0xf6edb9,-15|15|0xf6edb9,10|27|0xfcf2bd,-1|23|0xfcf2bd,-16|26|0xfff5bf,6|32|0xfff5bf,-14|32|0xfdf3be,-14|40|0xfff5bf,10|40|0xfef4be,6|48|0xfff5bf,-14|48|0xfef5bf,0|205|0xfff5bf,-5|168|0xfff5bf,-5|135|0xf4ebb7", degree, x1, y1, x2, y2, 0, 0)
end

--进入游戏90, 186, 876, 230, 1045
function getposjinruyouxi(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"13|11|0xfff5bf,13|5|0xf7edb9,7|11|0xfbf1bc,16|-15|0xfef4be,-15|4|0xefe6b3,-15|-3|0xd9d1a3,-14|-6|0xfaf0bb,-14|-7|0xfef4be,-13|-8|0xfef4be,-13|-9|0xf2e9b6,10|42|0xfff5bf,-16|25|0xfdf3bd,-16|58|0xfcf2bd,-15|141|0xfff5bf,9|130|0xfff5bf,-7|133|0xfff5bf,-3|117|0xfff5bf,-5|96|0xfff5bf,4|79|0xfff5bf", degree, x1, y1, x2, y2, 0, 0)
end

--右侧进入游戏90, 95, 1607, 138, 1775
function getposjinruyouxiright(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"0|-6|0xfaf0bb,-6|0|0xeee5b3,-18|-13|0xfef5bf,-28|-7|0xf4eab7,-26|-20|0xfdf3be,-27|-17|0xf2e9b6,-28|-14|0xe7dead,5|21|0xfef5bf,-29|14|0xf6ecb8,-28|47|0xf1e8b5,-4|31|0xfff5bf,3|58|0xfcf2bc,-9|58|0xfef4be,-23|57|0xfcf2bc,0|70|0xfff5bf,-18|85|0xfff5bf,-16|106|0xfff5bf,-4|119|0xfff5bf,-19|122|0xfff5bf", degree, x1, y1, x2, y2, 0, 0)
end

--95, 832, 317, 864, 514
function getposjieri(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfef4be,"-8|0|0xfff5bf,-4|0|0xfff5bf,-5|-6|0xfdf3bd,-4|19|0xfff5bf,-12|2|0xfff5bf,-26|2|0xfff5bf,-24|16|0xfcf2bc,-12|17|0xfbf1bc,0|31|0xfff5bf,-12|26|0xfcf2bd,-12|30|0xfff5bf,-27|29|0xfdf3bd,-2|44|0xfef4be,-13|44|0xfff5bf,-25|43|0xfff5bf,-27|60|0xfff5bf,-2|72|0xfff5bf,-17|62|0xfff5bf,-23|83|0xfef4be", degree, x1, y1, x2, y2, 0, 0)
end

--95, 404, 1384, 445, 1573,领取奖励（圣诞节）
function getposlinqujiangli(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"29|0|0xfff5bf,14|-1|0xf5ebb7,28|25|0xfdf3be,23|23|0xfdf3bd,22|23|0xf5ebb7,13|26|0xf3eab6,3|26|0xfff5bf,20|27|0xf7edb9,19|27|0xefe6b3,9|30|0xe3daaa,8|29|0xfcf2bd,6|69|0xfef4be,11|79|0xfff5bf,27|59|0xfff5bf,9|108|0xfff5bf,24|102|0xfff5bf,16|139|0xfff5bf,2|143|0xfff5bf,25|151|0xfff5bf", degree, x1, y1, x2, y2, 0, 0)
end

--95, 356, 1033, 397, 1199
function getposjixushiyong(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0x252525,"-20|-13|0x252525,12|-13|0x252525,-21|7|0x252525,-8|-27|0x252525,-18|-27|0x252525,2|-27|0x252525,12|-23|0x252525,4|-18|0x252525,-9|-19|0x252525,-13|39|0x252525,10|39|0x252525,1|20|0x252525,0|60|0x252525,3|80|0x252525,-7|79|0x252525,-9|117|0x252525,2|117|0x252525,12|117|0x252525,-9|132|0x252525", degree, x1, y1, x2, y2, 0, 0)
end

--95, 201, 1292, 323, 1409
function getposshangma(degree, x1, y1, x2, y2)
	findMultiColorInRegionFuzzy(0x35a81c,"18|6|0x41c414,30|6|0x51f914,44|7|0x95ff48,30|-11|0x4aff0e,29|21|0x47f510,40|16|0x66dc26,47|11|0x456f26,47|7|0xa5f949,40|-5|0x346e1d,34|-43|0xc0bb9b,29|-56|0x3b3d30,18|-43|0x26271f,18|-27|0x9a8b53,44|-49|0x494838,30|-61|0x3c3e31,50|-57|0x7d713b,54|-36|0xcfc593,70|-5|0x968951,51|12|0x6a643f", degree, x1, y1, x2, y2, 0, 0)
end

--95, 205, 1301, 310, 1402
function getposxiama(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xd74029,"2|0|0xc33b2a,30|-2|0xd84614,36|-3|0xf35014,32|-15|0x4f4b33,18|-13|0xad3716,28|-34|0xafa269,19|11|0xa63513,17|17|0xca3512,35|-7|0xf14b0e,22|-5|0xaf3b14,42|-7|0xff5c12,38|0|0xf95313,43|-29|0xc1b67c,20|-48|0x313123,33|-74|0x3a3c30,55|-73|0xaa9e63,65|-31|0xd4cb96,66|-18|0xfbf7e5,74|-25|0xfffffe", degree, x1, y1, x2, y2, 0, 0)
end

--95, 814, 44, 860, 136
function getpostask(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"-12|45|0xf8efba,0|45|0xe8dfae,5|48|0xfef4be,11|44|0xfef4be,11|52|0xfff5bf,-8|28|0x403543,7|30|0x30272d,-8|9|0x423744,5|10|0x322a30,-14|-5|0x453f50,-5|-4|0x3d323f,-11|55|0x453b47,-3|53|0x24231c,7|52|0x1f1a1d,-11|62|0xf6ecb8,-2|66|0xf4eab7,11|61|0xfff5bf,-16|37|0xfef4be,5|37|0xf5ebb7", degree, x1, y1, x2, y2, 0, 0)
end

--95, 810, 186, 866, 365
function getposteam(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfaf0bb,"0|1|0xfaf0bb,9|1|0xfff5bf,4|-6|0xfff5bf,3|7|0xfbf1bc,-9|1|0xe8dfae,7|27|0xfdf3bd,6|28|0xefe6b3,-1|43|0xf5ebb7,-3|33|0xfbf1bc,0|0|0xfaf0bb,9|1|0xfff5bf,18|1|0xfff5bf,-7|-18|0xeee5b3,-22|-42|0x72a9d4,-22|-59|0x72a9d4,-22|-71|0x72a9c6,-22|19|0x72a9d4,-22|52|0x72a9d4,-22|80|0x72a9c7", degree, x1, y1, x2, y2, 0, 0)
end


--95, 390, 1198, 456, 1734
function getposjieriblue(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0x78a0d6,"17|4|0x82a9df,-11|-10|0x6f99cd,-10|-37|0x709ace,-16|86|0x6892c6,-14|158|0x6b95c9,27|152|0x8ab1e7,28|177|0x8bb3e8,0|196|0x78a0d6,4|213|0x7aa2d8,7|302|0x7ca3d9,15|310|0x81a8de,-7|307|0x749cd2,30|340|0x8cb4e9,29|372|0x8bb3e8,28|118|0x8bb3e8,-7|302|0x749cd2,1|435|0x78a0d6,19|433|0x83aae0,5|427|0x7aa2d8", degree, x1, y1, x2, y2, 0, 0)
end

--继续匹配95, 387, 667, 428, 816
function getposjixupipei(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfef4be,"9|-11|0xfff5bf,16|9|0xfff5bf,13|0|0xf3eab6,5|42|0xfff5bf,20|43|0xfff5bf,27|43|0xfdf3bd,19|24|0xfff5bf,10|26|0xfff5bf,1|25|0xfff5bf,7|51|0xf7edb9,2|61|0xfff5bf,25|70|0xfcf2bd,25|79|0xfff5bf,9|79|0xfcf2bc,5|108|0xfff5bf,14|114|0xfaf0bb,21|115|0x88afe5,5|20|0x729bd0,25|-4|0x87ade0", degree, x1, y1, x2, y2, 0, 0)
end


--击杀等级不超过10的小怪95, 458, 7, 808, 216
function getposkillwildmonster(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0x60f71c,"-14|0|0x60f71c,-3|33|0x60f71c,7|34|0x60f71c,7|58|0x60f71c,-2|78|0x60f61c,-10|63|0x60f71c,-2|88|0x60f71c,6|104|0x5ef21b,7|97|0x60f71c,-13|105|0x60f71c,-7|140|0x60f71c,-2|133|0x60f71c,9|136|0x60f71c,9|124|0x5ff41c,1|166|0x60f71c,10|175|0x60f71c,-10|173|0x60f71c,-5|154|0x60f71c,-15|179|0x5def1b", degree, x1, y1, x2, y2, 0, 0)
end

--任务已完成95, 460, 795, 546, 921
function getposyiwancheng(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0x22dd22,"34|13|0x22d322,14|69|0x33d733,-22|52|0x3ae23a,-12|25|0x2bc22d,-39|108|0x2dc62d,-15|119|0x29c229,-39|94|0x18c118,-9|18|0x1fa11f,-7|8|0x118b12,27|39|0x27d12b,-25|114|0x2fd92f,8|38|0x43fe54,-5|61|0x40fa51,9|64|0x33ff55,-25|94|0x33ff44,-10|82|0x33ff44,-9|103|0x33ff44,-18|66|0x36f158,-6|32|0x31dd42", degree, x1, y1, x2, y2, 0, 0)
end

--[[
--龙盘虎踞(开放日)95, 842, 1360, 877, 1474
function getposlongpanhujukaifangri(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0x5ff41c,"-13|-3|0x60f71c,-25|0|0x60f71c,-11|20|0x5df01b,1|19|0x5ef31c,-11|14|0x60f71c,-24|7|0x5dee1b,-11|6|0x5def1b,-24|25|0x60f61c,-1|45|0x5ff61c,-3|42|0x60f71c,-23|39|0x5ced1b,-9|53|0x60f71c,-18|59|0x60f71c,-2|66|0x5ae61a,-10|74|0x60f71c,-10|96|0x60f71c,-23|96|0x5ae81a,1|74|0x5be91a,-13|106|0x60f71c", degree, x1, y1, x2, y2, 0, 0)
end
--]]

--龙盘虎踞(开放日)95, 843, 1360, 877, 1475
function getposlongpanhujukaifangri(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0x45b114,"1|14|0x60f71c,1|27|0x60f71c,1|43|0x60f71c,2|53|0x60f71c,2|64|0x60f71c,2|74|0x59e41a,2|85|0x60f71c,2|97|0x60f71c,1|107|0x60f71c,-13|105|0x5dee1b,-11|97|0x5ae81a,-12|66|0x5ef21b,-11|46|0x5bea1b,-11|39|0x58e21a,-12|8|0x5dee1b,-14|0|0x55d919,14|18|0x52d318,13|19|0x5ef31c,15|19|0x33820f", degree, x1, y1, x2, y2, 0, 0)
end

--95, 349, 0, 546, 179
function getposgenshuiduizhang(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"-6|-5|0xfef4be,-15|-5|0xfff5bf,9|-1|0xece3b1,5|-4|0xfcf2bd,3|14|0xfff5bf,9|13|0xf4ebb7,-7|20|0xf5ecb8,-16|21|0xf7edb9,7|29|0xfff5bf,-10|29|0xfff5bf,-6|34|0xfef4be,-14|38|0xfbf1bd,8|46|0xfff5bf,-7|43|0xfff5bf,8|61|0xfef4bf,-16|62|0xfff5bf,-2|79|0xfff5bf,-2|98|0xfff5bf,-16|119|0xfaf0bb", degree, x1, y1, x2, y2, 0, 0)
end

--龙盘虎踞-五仙寨95, 664, 1107, 699, 1365
function getposlongpanhujuwuxianzhai(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"-13|7|0xfff5bf,-13|38|0xfff5bf,-5|68|0xfff5bf,-7|103|0xfff5bf,-11|130|0xfff5bf,3|148|0xa19c79,4|148|0xfff5bf,5|148|0xe9e0ae,2|181|0x38362a,3|181|0x605d48,4|181|0x898467,5|181|0xa59e7b,5|180|0xe6ddac,5|191|0x8f896b,6|191|0x5e5a47,6|190|0x171816,5|190|0x26251e,5|192|0xfef4be,-13|222|0xfff5bf", degree, x1, y1, x2, y2, 0, 0)
end


--点此参加据点活动95, 627, 13, 667, 280;456,15,717,282
function getposdiancicanjiajudianhuodong(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0x59e51a,"1|28|0x57e01a,7|65|0x60f71c,1|103|0x60f71c,3|138|0x60f71c,-1|166|0x51d018,1|202|0x60f71c,1|237|0x5def1b,-11|-12|0x5ff51c,-11|-3|0x5df01b,-11|5|0x5def1b,-10|13|0x5ff31c,-10|243|0x60f71c,10|244|0x5ef21b,16|237|0x5ae91a,5|223|0x60f71c,15|186|0x5ef31c,-11|186|0x60f61c,-1|119|0x5beb1b,11|86|0x51d018", degree, x1, y1, x2, y2, 0, 0)
end

--负(划拳)95, 652, 1070, 761, 1173
function getposfu(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xffd02c,"22|10|0xfbc132,14|-14|0xfdc42f,10|26|0xffc82c,-17|40|0xfddb34,-43|31|0xfbe57d,-42|-7|0xfbe57a,-1|4|0xffd12c,-29|-18|0xfbe051,-24|41|0xfddf45,-21|8|0xfddc3f,-39|-3|0xfbe571,-43|-10|0xffe882,-28|5|0xfcda52,-34|2|0xfbe260,-38|24|0xfee06b,-35|19|0xfae264,-2|39|0xfcd32e,-9|40|0xffd833,20|-6|0xffc12c", degree, x1, y1, x2, y2, 0, 0)
end


--胜(划拳)95, 657, 1071, 758, 1175
function getpossheng(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfbe583,"14|1|0xfbe156,26|3|0xfddc37,45|2|0xffd02c,54|2|0xffc92c,68|8|0xffc02c,59|16|0xfdc42f,46|17|0xffd02c,26|15|0xfddc37,9|17|0xfbe366,36|1|0xfed832,36|16|0xfed832,-2|28|0xfceb85,-1|46|0xfae983,-2|69|0xfeed87,27|49|0xfddc37,53|51|0xffca2c,75|49|0xca9127,28|69|0xfcda35,26|30|0xffe138", degree, x1, y1, x2, y2, 0, 0)
end


--赌坊，负95, 247, 1066, 375, 1181
function getposdufangfu(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xffd12c,"26|-1|0xfcc22e,-23|-33|0xfddc3c,-21|38|0xfddc37,-14|39|0xfcda30,-2|38|0xfdd42f,-22|2|0xfddc38,-35|-5|0xfee058,-43|-11|0xfedf68,-54|-27|0xf9e891,-59|-40|0xfbe790,-59|47|0xfbe790,-54|39|0xffe38e,-48|28|0xfbe578,-45|18|0xfde46f,-35|38|0xfce155,-35|-32|0xfbe056,15|23|0xfec72e,11|16|0xffca2c,25|-18|0xfec12c", degree, x1, y1, x2, y2, 0, 0)
end

--赌坊，胜95, 258, 734, 370, 846
function getposdufangsheng(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xffc02c,"-24|1|0xffcf2c,-48|0|0xfddc37,-66|-11|0xfbe25e,-36|-8|0xffd833,-18|-10|0xffcb2c,-23|-10|0xffcf2c,-24|9|0xffcf2c,-5|8|0xfcc22e,-11|9|0xfec52d,-61|11|0xfbe051,-67|11|0xfbe261,-80|9|0xfbe582,-79|-12|0xf9e57f,-47|48|0xfddc37,-15|50|0xffc92c,-82|47|0xfceb85,-65|48|0xfbe15b,-73|49|0xfbe571,-40|10|0xfcda30", degree, x1, y1, x2, y2, 0, 0)
end

--龙盘虎踞-沙水营95, 663, 316, 698, 568
function getposlongpanhujushashuiying(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"-15|6|0xfef5bf,-13|37|0xfff5bf,-15|71|0xfdf3be,-7|111|0xfff5bf,-12|129|0xfff5bf,-9|159|0xfff5bf,-9|189|0xf7edb9,-11|222|0xfff5bf,3|234|0xf3eab6,5|216|0xfef4be,-19|202|0xf6ecb8,-19|176|0xfff5bf,-22|150|0xfaf0bb,2|154|0xf6ecb8,-21|100|0xfbf1bc,5|69|0xfff5bf,-13|183|0x4e4b3b,-12|183|0x8f896b,-11|183|0xccc499", degree, x1, y1, x2, y2, 0, 0)
end

--安锋营据点跑环95, 651, 317, 685, 550
function getposanfengyinghuanpao(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"-1|39|0xfff5bf,0|67|0xf6ecb8,0|105|0xfff5bf,4|134|0xfff5bf,3|165|0xfff5bf,4|202|0xfff5bf,-10|2|0xfff5bf,-14|67|0xfff5bf,-15|39|0xe6ddac,-14|129|0xf6edb9,-14|120|0xfcf2bd,-14|145|0xe3daaa,-14|170|0xfff5bf,-14|203|0xfdf3be,11|212|0xfcf2bd,13|72|0xf9efba,4|31|0x4f4c3b,4|32|0x69654e,4|33|0x857f63", degree, x1, y1, x2, y2, 0, 0)
end

--沙水营据点跑环95, 651, 1109, 685, 1342
function getposshashuiyinghuanpao(degree, x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xfff5bf,"-1|30|0xfef4be,-1|63|0xf6ecb8,-2|101|0xfff5bf,3|130|0xfff5bf,0|161|0xfff5bf,1|198|0xfff5bf,10|208|0xfcf2bd,-15|199|0xfdf3be,-10|208|0xfdf3bd,-14|182|0xfdf3be,-15|25|0xfef4be,12|30|0xf4eab7,-12|17|0xfff5bf,5|17|0xfaf0bb,-12|42|0xfff5bf,-15|-17|0xfcf2bd,10|-15|0xd1c89c,10|-16|0x7e795f,10|-17|0x2d2b22", degree, x1, y1, x2, y2, 0, 0)
end
