
function getpos1() --巡视捉拿青衣小贼
x, y = findMultiColorInRegionFuzzy(0xdab973,"303|70|0xd3ca9e,304|83|0x413e30,295|85|0x3e3b2d,293|75|0xd9d1a3,304|66|0x423f31,316|80|0x545135,307|94|0xfbd88b,305|110|0xd3cb9e,297|111|0x7a765c,289|113|0xf6c26b,308|114|0xa49e7b,305|89|0xcbc398,303|80|0x8c876a,303|74|0xfbf1bc,307|80|0xfdf3be,307|115|0xebe2b0,300|120|0x504c3b,300|98|0xa49f7c,300|81|0xc2bb91", 95, 362, 1293, 409, 1438, 0, 0)
	if x > -1 then
		return x,y
	end
end

function getpos2() --打坐秘籍70%相似度
	x, y = findMultiColorInRegionFuzzy(0xf4ca78,"10|3|0xffdb8c,2|12|0xecc77a,8|28|0xcbae70,2|32|0xeac67a,7|43|0xf0ce83,12|64|0x383324,10|71|0x69654e,18|73|0x4d482f,-2|79|0xeec373,6|82|0xf2cf81,13|77|0xffe091,-3|45|0xedc272,5|41|0x4f452d,6|58|0x878165,6|72|0x53492d,-1|49|0x7b663d,3|36|0x403c2e,8|30|0xf3d186,3|62|0xfff5bf", 70, 367, 1308, 404, 1416, 0, 0)
	if x > -1 then
		return x,y
	end
end

function getpos3()  --检查，巡视湖边
	return findMultiColorInRegionFuzzy(0xffd579,"428|46|0x391a18,1|-78|0x736e56,18|-62|0xfef4be,9|-48|0xb39962,9|-55|0x947d4f,7|-48|0xae945c,0|-28|0xfff5bf,-1|-41|0x59492a,1|-54|0xfbf1bc,15|-54|0x6f6b53,20|-41|0xfff5bf,15|-24|0xfbf1bc,4|-21|0xc4bc93,0|-34|0xfff5bf,-1|-51|0x9f824a,-1|-62|0x4b3e25,1|-68|0xf0c775,-4|-77|0xf7c971,18|-76|0x3b3a26", 70, 367, 1308, 406, 1417, 0, 0)
end

function getpos4() --挥洒，使用蜂蜜
	return findMultiColorInRegionFuzzy(0x312a1a,"0|-6|0xfff5bf,-6|-12|0x62512e,-1|-25|0xffd87a,18|-18|0xffffa0,14|-12|0x777147,7|7|0x2b2516,4|21|0xf9d380,14|25|0x65603c,18|8|0xa39c7a,8|11|0x65624c,4|31|0xfff5bf,-1|41|0x725d36,-5|34|0xede4b1,8|39|0x373326,3|46|0x575341,-4|37|0x989272,15|28|0x3e3c2d,13|57|0xfff095,11|61|0xffeb91", 70, 367, 1299, 405, 1430, 0, 0)
end

function getpos5() --巡视，捉拿门派叛徒
return findMultiColorInRegionFuzzy(0xffd677,"17|4|0xfff296,-1|13|0xffcc74,11|20|0x816e45,7|39|0xf0e7b4,-1|62|0xbdb68e,3|77|0x352f22,-1|86|0xfdcc74,1|96|0xffd276,19|92|0xfff399,20|76|0xb7ad6e,10|68|0x322f23,4|62|0xebc474,16|50|0xffe290,5|45|0x524f3d,7|35|0x3c3420,13|35|0x393222,15|62|0x2e2b20,14|76|0xccaf70,14|89|0xffe08d", 70, 367, 1301, 406, 1429, 0, 0)
end

function getpos6() --炼药，药炉
	return findMultiColorInRegionFuzzy(0xffd075,"20|-1|0xfffd9c,4|19|0xfef4be,-6|15|0x9f8045,9|14|0xe9e0af,12|28|0xf9efbb,9|61|0x7a755b,2|46|0x655331,2|31|0x3a372a,-6|19|0xffcc6e,2|19|0xfff5bf,0|38|0x29271d,20|38|0xfef4be,21|48|0xe2d9aa,12|67|0x312b1d,-1|81|0xffcd74,18|85|0xfff498,10|53|0xfdf3bd,-2|51|0xfcf2bc,21|47|0xbeb78f", 70, 367, 1300, 404, 1430, 0, 0)
end


function getpos8() --巡视，捉拿黑龙会奸细
	return findMultiColorInRegionFuzzy(0xffe977,"13|0|0xfff98d,8|-2|0xfff485,0|28|0xf1cc6c,26|32|0x4c4b30,24|20|0xffffa1,5|23|0x322e1f,1|55|0xffd976,6|79|0x353122,5|89|0xffd879,0|100|0xffe275,15|96|0xffe98d,15|66|0x4b4837,22|55|0x615d48,27|50|0xb7b089,19|40|0xfdf3bd,10|47|0xcec69a,10|33|0xede4b2,16|32|0xfff5bf,19|75|0xf8eeba", 70, 367, 1300, 407, 1434, 0, 0)
end

function getpos9() --财神降临，战
	return findMultiColorInRegionFuzzy(0x680000,"36|12|0x820000,65|68|0xe40000,63|115|0xf30000,15|91|0xf30000,0|55|0xc90000,-20|68|0x000000,-13|110|0x000000,-21|148|0xbc0000,-14|165|0x980000,-9|130|0xf30000,-24|121|0xd50000,-20|106|0x000000,-44|75|0x0c0000,-42|96|0x4a0000,22|122|0x000000,20|112|0xda0000,29|107|0x9b0000,47|107|0xd10000,28|87|0x550000", 70, 0, 0, 1079, 1919, 0, 0)
end

function getpos10() --右侧蓝色任务框
	return findMultiColorInRegionFuzzy(0x7aa2d8,"5|-7|0x7da4db,5|2|0x7da4db,-8|28|0x769ed4,2|27|0x7ba3d9,-1|10|0x79a1d7,-1|-5|0x79a1d7,8|1|0x7fa6dc,8|22|0x7fa6dc,2|1|0x7ba3d9,-7|9|0x769ed4,2|35|0x7ba3d9,3|23|0x7ca3d9,12|10|0x81a8de,12|2|0x81a8de,7|18|0x7fa6dc,6|33|0x7ea5db,-2|29|0x79a1d7,-7|18|0x769ed4,2|2|0x7ba3d9", 70, 95, 1138, 985, 1900, 0, 0)
end

function getpos11() --财神中间确认框
	return findMultiColorInRegionFuzzy(0xead08d,"6|2|0xf0d591,0|12|0xead08d,-4|11|0xe5cb88,0|4|0xead08d,0|12|0xead08d,-5|4|0xe6ca87,0|1|0xead08d,-6|12|0xe7c986,4|14|0xeed490,-3|2|0xe6cc89,2|2|0xecd28e,-8|19|0xe5c784,2|12|0xecd28e,-1|2|0xe9cf8c,-8|7|0xe5c784,2|14|0xecd28e,2|5|0xecd28e,0|5|0xead08d,-5|4|0xe6ca87", 70, 36, 414, 938, 1314, 0, 0)
end

function getcommpos()
	return findMultiColorInRegionFuzzy(0xf3c573,"7|1|0xf2cc7e,12|1|0xfdd989,7|1|0xf2cc7e,3|5|0xf5ca78,20|6|0xfff39a,15|4|0xffe390,5|7|0xf7cf7b,3|4|0xf4c977,17|3|0xffe994,19|1|0xffec97,10|2|0xf9d484,3|9|0xface79,9|13|0xffdc84,2|16|0xffd379,0|14|0xffd075,12|8|0xffde8b,16|13|0xffee94,12|12|0xffe28c,24|5|0xffffa2", 50, 365, 1295, 409, 1436, 0, 0)
end


function delayclicknext(delay)
  mSleep(delay)
	click(116,1343) --副本对话，116,1343,0xd7dde3
end


--不断点击财神，直到点击OK后进入
function caishenjianglin(x,y)
	while not delayrectposclick(60,getbluepos,42,1434,771,1910) do 		--接取任务
		click(x,y)																											--点击财神
	end
	sysLog("接取任务成功...")
	while not delayrectposclick(60,getyellowpos,366,1297,408,1434) do  --确认进入
		mSleep(60)
	end
	sysLog("成功进入副本...")
end

--财神扩展
function caishenjianglin2(x,y)
	x2,y2=getpos9()
	while x2 > -1 do
		mSleep(120)
		x2,y2=getpos9()
	end
end

--多采集，匹配度要高
function getposlow1(x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0x5ff41c,"-3|-1|0x5ae91a,-7|-2|0x60f71c,-12|-4|0x5ff51c,-9|-2|0x60f71c,-14|-1|0x60f71c,-21|-1|0x60f71c,-25|-2|0x60f61c,-24|5|0x60f61c,-23|12|0x60f61c,-26|14|0x60f61c,-18|5|0x60f61c,-12|5|0x60f61c,-3|5|0x60f61c,-2|14|0x60f71c,-1|20|0x60f71c,-11|15|0x60f71c,-12|10|0x60f71c,-12|22|0x60f71c,-26|21|0x60f71c", 40, x1, y1, x2, y2, 0, 0)
end
function getposlow2(x1,y1,x2,y2)
	return findMultiColorInRegionFuzzy(0x5ff41c,"-5|-1|0x60f61c,-9|-2|0x60f71c,-12|-4|0x5ff51c,-13|-2|0x60f71c,-18|-1|0x60f71c,-26|-1|0x60f71c,-27|15|0x60f61c,-23|12|0x60f61c,-25|5|0x60f61c,-12|5|0x60f61c,-2|5|0x5dee1b,-2|14|0x60f71c,-12|16|0x60f71c,-12|21|0x60f71c,-1|21|0x60f71c,-24|23|0x60f71c,-7|10|0x151921,-18|11|0x151921,-12|2|0x060709", 40, x1, y1, x2, y2, 0, 0)
end
function getposlow3(x1,y1,x2,y2)
	return findMultiColorInRegionFuzzy(0x60f61c,"4|2|0x60f71c,12|4|0x5ff51c,-2|3|0x5ff41c,-15|3|0x5ef31c,-14|11|0x59e51a,-10|15|0x5dee1b,-15|19|0x5ff51c,0|11|0x60f71c,9|10|0x5ff41c,9|18|0x5ff51c,11|25|0x5ff41c,-1|21|0x5df11b,0|26|0x60f71c,-14|27|0x5ced1b,-8|27|0x5be91a,7|13|0x070b07,11|7|0x040904,2|11|0x46b414,-2|11|0x44ae14", 40, x1, y1, x2, y2, 0, 0)
end
function getposlow4(x1,y1,x2,y2)
	return findMultiColorInRegionFuzzy(0x5ff41c,"0|-1|0x58e31a,2|0|0x60f71c,3|0|0x60f71c,5|0|0x60f71c,7|0|0x60f71c,10|0|0x60f71c,12|0|0x60f71c,15|0|0x60f71c,18|0|0x60f71c,22|-1|0x5def1b,23|1|0x60f61c,25|1|0x60f71c,26|1|0x60f71c,16|-2|0x60f71c,15|-3|0x5ff51c,15|17|0x60f71c,15|6|0x60f61c,1|22|0x60f71c,26|22|0x60f71c", 40, x1, y1, x2, y2, 0, 0)
end
function getposlow5(x1,y1,x2,y2)
	return findMultiColorInRegionFuzzy(0x5be91a,"10|0|0x60f71c,21|0|0x60f71c,-1|7|0x5ef21b,11|7|0x5ef31c,21|7|0x5ef31c,23|21|0x5ff61c,11|21|0x60f71c,10|14|0x60f71c,4|17|0x60f71c,17|14|0x5ff31c,14|32|0x60f71c,0|33|0x60f71c,0|40|0x60f71c,13|40|0x60f71c,23|39|0x5dee1b,23|49|0x60f71c,13|50|0x60f71c,-1|55|0x60f71c,2|46|0x60f61c", 40, x1, y1, x2, y2, 0, 0)
end
function getposlow6(x1,y1,x2,y2)
	return findMultiColorInRegionFuzzy(0x60f71c,"12|0|0x5df01b,0|7|0x5ef31c,1|21|0x60f71c,4|33|0x60f71c,3|49|0x60f71c,-11|55|0x60f71c,13|49|0x60f71c,-4|10|0x080b0a,-9|3|0x080a0d,-4|43|0x0e1016,7|43|0x0b0c10,-4|54|0x050708,-7|58|0x5ae81a,4|55|0x60f71c,-2|17|0x133006,4|14|0x050708,10|3|0x070a0a,-2|3|0x080a0d,-5|48|0x080c0d", 40, x1, y1, x2, y2, 0, 0)
end
function getposlow7(x1,y1,x2,y2)
	return findMultiColorInRegionFuzzy(0x5ef31c,"0|4|0x59e41a,-11|4|0x55db19,3|4|0x5beb1b,8|6|0x5ae71a,8|7|0x378e10,12|5|0x368b10,13|5|0x4fcb17,14|5|0x5def1b,8|17|0x5ff31c,1|17|0x60f71c,1|24|0x60f71c,-10|10|0x5ef21b,8|24|0x60f71c,5|35|0x60f71c,3|52|0x5ff41c,2|52|0x59e61a,1|52|0x4fcb17,0|52|0x46b314,-1|52|0x3c9a11", 40, x1, y1, x2, y2, 0, 0)
end
function getposlow8(x1,y1,x2,y2)
	return findMultiColorInRegionFuzzy(0x5ef31c,"0|4|0x59e41a,-11|4|0x55db19,3|4|0x5beb1b,8|6|0x5ae71a,8|7|0x378e10,12|5|0x368b10,13|5|0x4fcb17,14|5|0x5def1b,8|17|0x5ff31c,1|17|0x60f71c,1|24|0x60f71c,-10|10|0x5ef21b,8|24|0x60f71c,5|35|0x60f71c,3|52|0x5ff41c,2|52|0x59e61a,1|52|0x4fcb17,0|52|0x46b314,-1|52|0x3c9a11", 40, x1, y1, x2, y2, 0, 0)
end
function getposlow9(x1,y1,x2,y2)
	return findMultiColorInRegionFuzzy(0x040704,"-1|-4|0x050d04,4|-4|0x070a08,7|-6|0x60f71c,-5|-7|0x5ef01b,20|-7|0x5df01b,20|8|0x5cee1b,11|4|0x030504,17|-4|0x070f04,16|-11|0x0c1809,-5|-14|0x5ae71a,18|-14|0x60f71c,10|16|0x5ff51c,10|44|0x348710,10|43|0x53d418,22|43|0x1b4608,21|42|0x50ce17,-5|44|0x2f790e,-4|43|0x5ef11b,15|-18|0x399211", 40, x1, y1, x2, y2, 0, 0)
end

function getposlow10(x1,y1,x2,y2)
	return findMultiColorInRegionFuzzy(0x60f61c,"-15|-2|0x60f71c,-23|-2|0x5be91a,-7|12|0x5ff31c,-25|20|0x5ff51c,-15|12|0x5ff41c,-24|9|0x5ef31c,-23|10|0x56de19,-25|5|0x5ef21b,-4|-2|0x5ff61c,-3|-1|0x5bea1b,-1|-1|0x5ef11b,-1|0|0x5def1b,-17|-2|0x5cec1b,-24|18|0x59e61a,-16|18|0x57df19,-24|46|0x59e51a,0|42|0x56dd19", 35, x1, y1, x2, y2, 0, 0)
end

function getposmiddle(x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xf9f0bb,"0|2|0xfff5bf,0|5|0xfff5bf,0|9|0xfff5bf,0|11|0xfff5bf,0|13|0xfff5bf,0|18|0xfff5bf,0|20|0xfff5bf,0|23|0xfff5bf,-6|13|0xfff5bf,-7|13|0xfff5bf,-11|13|0xfff5bf,-11|18|0xfff5bf,-18|13|0xfff5bf,-23|14|0xfff5bf,-23|4|0xfff5bf,-10|4|0xfff5bf,-24|24|0xf6edb9,-11|23|0xfff5bf,-24|0|0xf6edb8", 50, x1, y1, x2, y2, 0, 0)
end

function getposhigh(x1, y1, x2, y2)
	return findMultiColorInRegionFuzzy(0xff0000,"-6|1|0xf70000,-11|1|0xf70000,5|3|0xf30000,9|-2|0xff0000,13|2|0xfe0000,12|8|0xff0000,7|8|0xff0000,0|8|0xff0000,-10|8|0xff0000,0|14|0xff0000,0|22|0xff0000,13|21|0xff0000,13|15|0xff0000,13|44|0xff0000,12|35|0xf40000,12|53|0xf40000,8|45|0xef0000,4|44|0xf60000,-1|44|0xff0000", 25, x1, y1, x2, y2, 0, 0)
end





