
function logcolor(x,y,color)
	sysLog("x:"..x..", y:"..y..", color:"..string.format("0x%06x",color))
end

function logpos(x,y)
	sysLog("x : "..x..", y : "..y)
end

function logrect(x1,y1,x2,y2)
	sysLog("x1:"..x1.." y1:"..y1..", x2:"..x2.." y2:"..y2)
end

