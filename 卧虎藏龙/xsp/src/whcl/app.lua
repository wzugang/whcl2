require("utils/app")
require("utils/pos")
require("utils/work")
require("utils/click")

function restartwhcl()
	restartapp("com.sqage.xtxj.huawei")

	delayonlyrectgetposclick(8000, getposjixushiyong, 90, 356, 1033, 397, 1199)	--点击继续使用

	blockrectgetposdelayclick(getposjinruyouxi, 90, 186, 876, 230, 1045, 10000)	--点击进入游戏，需要等待华为账号登录成功

	--click(116,1686)															--点击右边进入游戏, 116,1686,0x2e2e36
	blockrectgetposclick(getposjinruyouxiright, 90, 95, 1607, 138, 1775)

	mSleep(5000)
	click(816,1312)
	--onlycolorclick(816,1312,0x381a18)											--关闭回补经验对话框, 816,1312,0x381a18
	mSleep(5000)
end

