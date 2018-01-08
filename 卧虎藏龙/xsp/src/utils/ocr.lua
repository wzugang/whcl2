

function gettext(x1,y1,x2,y2)
local ocr, msg = createOCR({
	type = "tesseract", -- 指定tesseract引擎
	path = "res/", -- 使用开发助手/叉叉助手的扩展字库
	lang = "whcl" -- 使用英文增强字库(注意需要提前下载好)
})

local code, text = ocr:getText({
	rect = {x1,y1,x2,y2},
	--psm  = 6,
	--diff = {"0xfff5bf-0x131313", "0x212731-0x202020"}, -- "0x212121-0x212121"  "0x444132-0x101010" 
	diff = {"0xe2daaa-0x1d1d1d", "0x1d222a-0x050405"}, -- "0x212121-0x212121"  "0x444132-0x101010" 
	lang = "chi_sim"
})
sysLog("code:"..tostring(code)..", text:"..text)
--sysLog(string.format('text=%s', text))
ocr:release()
end
