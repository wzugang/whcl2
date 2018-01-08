require("utils/click")
require("whcl/pos")

function talk()
	click(gettalkpos())
end

function getposbupaichu(degree, x1, y1, x2, y2) --回收装备，不排除
	return findMultiColorInRegionFuzzy(0xfff5bf,"0|-15|0xfdf3bd,-1|13|0xfff5bf,-13|7|0xfff5bf,-10|4|0xf0e7b4,-19|13|0xfdf3bd,-11|-5|0xf8eeba,-13|-7|0xfff5bf,-16|-10|0xfff5bf,-19|-15|0xfff5bf,1|24|0xfff5bf,-4|21|0xfff5bf,-4|27|0xfff5bf,-9|25|0xfff5bf,-15|24|0xfff5bf,-28|24|0xfaf0bb,-14|27|0xfaf1bb,-21|76|0xfbf1bc,-10|76|0xfdf3bd,-18|43|0xf7edb9", degree, x1, y1, x2, y2, 0, 0)
end

function huishouzhuangbei()
	getposclick(getbeibaopos)		--点击背包
	delayclick(1000,438,1784)		--点击回收
	delayclick(1000,948,1125)		--点击回收蓝装及以下
	delayonlyrectgetposclick(1000, getposbupaichu, 90, 349, 766, 399, 885)
	delayclick(1000,950,1510)   --点击回收按钮
	delayclick(1000,1014,1748)  --点击关闭
end

--退出帮会驻地
function tuichubanghuizhudi()
	delayclick(1000,714,1858)  --点击+号
	delayclick(1000,89,1554)   --点击帮会
	delayclick(1000,124,1549)  --退出驻地
	delayclick(1000,405,1178)  --确定退出驻地
	mSleep(10000)
end

--上马
function shangma()
	onlyrectgetposclick(getposshangma,90,201, 1292, 323, 1409)
end

--下马
function xiama()
	onlyrectgetposclick(getposxiama, 90, 205, 1301, 310, 1402)
end

--切换到任务
function switchtotask()
	onlyrectgetposclick(getpostask, 85, 814, 44, 860, 136)
end

--切换到组队
function switchtoteam()
	onlyrectgetposclick(getposteam, 85, 810, 186, 866, 365)
end


