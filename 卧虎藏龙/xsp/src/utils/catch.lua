require("utils/log")

function catchNPoint(n)
	points={}
	count=0
	sysLog("开始取点...")

	while count < n do
		--point={}
		x,y = catchTouchPoint()
		--point[0] = x
		--point[1] = y
		--points[count] = point
		count = count + 1
		sysLog("第"..count.."个点: x="..x.." ,y="..y)
	end
	sysLog("结束取点...")
	return points
end
