
function checkrectpos(x, y, x1, y1, x2, y2)
	minX=(((x1>x2) and x2) or x1)
	maxX=(((x1<x2) and x2) or x1)
	minY=(((y1>y2) and y2) or y1)
	maxY=(((y1<y2) and y2) or y1)
	
	if((minX < x) and (maxX > x)) then
		if((minY < y) and (maxY > y)) then
			return x,y
		end
	end
	return -1,-1
end

--检查一行的颜色是否一致,任务905,168,286
function checklinesamecolor(line,startpos,endpos,step)
	color = getColor(line,startpos)
	for i=startpos+1,endpos,step do
		color1 = getColor(line,i)
		if color1 ~= color then
			color1 = getColor(line,i)
			if color1 ~= color then
				return false
			end
		end
	end
	return true
end



