
--1. ctrl+alt+a开始取色
--2. ctrl+鼠标单击进行多点选色

function ocr()

local ocr, msg = createOCR({
	type = "tesseract", -- 指定tesseract引擎
	path = "[external]", -- 使用开发助手/叉叉助手的扩展字库
	--lang = "chi_sim" -- 使用中文字库
	lang = "eng_ext" -- 使用英文字库
})

local code, text = ocr:getText({
	--rect = {306,573,505,644},
	rect = {623,1415,731,1473},
	diff = {"0x193d8c-0xffffff"},
	--whitelist = "游戏中心"
	whitelist = "QQ"
})

sysLog("code:"..code..", text:"..text);

ocr:release()
end

function print_pairs(res)
  i = 1
	for k,v in pairs(res) do
		sysLog(string.format('{index=%d, text=%s}', i, v))
		i = i + 1
	end
end

--gettext(0,0,1080,1920)
--gettext(654,312,696,452) --OK
gettext(0,0,1080,1920)

--sysLog((function() return 1 end)())

--[[ 多行注释--]]


	touchmoveaccurate(378,360+(314*1),378,360)
	mSleep(1000)
	touchmoveaccurate(378,360+(314*1),378,360)
	mSleep(1000)
	touchmoveaccurate(378,360+(314*1),378,360)
	mSleep(1000)
	touchmoveaccurate(378,360+(314*1),378,360)
	mSleep(1000)
	touchmoveaccurate(378,360+(314*1),378,360)
	mSleep(1000)
	touchmoveaccurate(378,360+(314*1),378,360)
	mSleep(1000)
	touchmoveaccurate(378,360+(314*1),378,360)

	--touchmove2(378,360+(308*1),378,360)
	--mSleep(5000)
	--touchmoveaccurate(378,360+(305),378,360)
	--mSleep(1000)
	--delaymove(1000,1000,378,360+(314*1),378,360)

--截图有问题
function shortcut(name,x1,y1,x2,y2)
	snapshot(name, x1-1, y1-1, x2-1, y2-1)			--全屏截图（分辨率1080*1920）
end


--[[
  ret = uishow("whcl.json")
  sysLog(ret)
  if 1 == ret then
	sysLog(uigetstring("whcl.json"))
  end
--]]

--下面为自动挂机脚本
--restartwhcl()


--[[
	dict={{90,363,1296,410,1436},{95,384,1148,463,1804}}
	for i=1,#dict do
		for j=1,#dict[i] do
			sysLog(dict[i][j]..",")
		end
	end
--]]

