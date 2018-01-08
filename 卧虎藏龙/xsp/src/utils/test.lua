--HUD使用
--init("0",1)
id = createHUD()     --创建一个HUD
sysLog(id)
showHUD(id,"欢迎使用叉叉脚本！",48,"0xffff0000","0xffffffff",3,0,0,400,800)      --显示HUD内容
mSleep(2000)
--showHUD(id,"HelloWorld!",24,"0xffff0000","msgbox_click.png",400,600,0,400,80)     --变更显示的HUD内容
showHUD(id,"HelloWorld!",48,"0xff0000ff","0xffffffff",3,0,0,400,800)     --变更显示的HUD内容
mSleep(5000)
hideHUD(id)     --隐藏HUD
mSleep(3000)
--[[
参数	类型	说明
id	整数型	用于标示HUD
text	文本型	提示信息，将在屏幕上以HUD形式显示
size	整数型	表示提示信息的字体大小
color	文本型	表示提示信息的字体颜色，格式为ARGB
bg	文本型	表示提示信息的背景颜色，可以是ARGB，也可以是图片文件名称
pos	整数型	表示提示信息的原点位置，0 - 左上角，1 - 居中，2 - 水平居中， 3 - 垂直居中
x,y	整数型	表示提示信息相对原点的坐标偏移值
width,height	整数型	表示提示信息显示的宽高
--]]

--android只有横屏与竖屏，home键在哪里不区分
ret = getScreenDirection()
sysLog(ret)
if ret == 0 then
  sysLog("当前屏幕方向为竖屏")
elseif ret == 1 then
    sysLog("当前屏幕方向为横屏")
end


--分辨率操作，统一为竖直（Home 键在下方时）屏幕的宽度和高度。
width,height = getScreenSize()

setScreenScale(width, height, scale)
--假设一名作者在540*960分辨率的手机中开发了脚本，要在720*1280的设备中运行
--setScreenScale(540,960)     --或者setScreenScale(540,960,0)效果相同，0表示返回的坐标进行反向缩放，1不缩放

