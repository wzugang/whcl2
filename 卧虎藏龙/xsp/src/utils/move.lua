require("utils/work")

function touchmove(x1,y1,x2,y2)
	touchDown(0, x1, y1)
	mSleep(50)
	touchMove(0, x2, y2)
	mSleep(50)
	touchUp(0, x2, y2)
end

function delaymove(delay,x1,y1,x2,y2)
	delaywork(delay, function() touchmove(x1,y1,x2,y2) end)
end

function touchmoveaccurate(x1,y1,x2,y2)
	tx=x1+(((x2-x1)*(5000-160))/5050)
	ty=y1+(((y2-y1)*(5000-160))/5050)
	touchDown(0, x1, y1)
	mSleep(5000)
	touchMove(0, tx, ty)
	mSleep(50)
	touchUp(0, tx, ty)
	mSleep(1000)
end

--缓慢一步一步移动
function touchmovestepaccurate(x1,y1,x2,y2)
	tx=x2-x1
	ty=y2-y1
	touchDown(0, x1, y1)
	if tx > 0 then
		tx=math.ceil(tx)
		for i=1,tx do
			mSleep(1)
			touchMove(0, x1+i, y1)
		end
	else
		tx=math.ceil(math.abs(tx))
		for i=1,tx do
			mSleep(1)
			touchMove(0, x1-i, y1)
		end
	end
	
	if ty > 0 then
		ty=math.ceil(ty)
		for i=1,ty do
			mSleep(1)
			touchMove(0, x2, y1+i)
		end
	else
		ty=math.ceil(math.abs(ty))
		for i=1,ty do
			mSleep(1)
			touchMove(0, x2, y1-i)
		end
	end

	--弹起的时候要慢一点
	mSleep(2000)
	touchUp(0, x2,y2)
end

function delaymoveaccurate(delay,x1,y1,x2,y2)
	delaywork(delay, function() touchmoveaccurate(x1,y1,x2,y2) end)
end
