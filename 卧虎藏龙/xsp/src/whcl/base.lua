
function moveup(delay)
touchDown(0,248,242)
mSleep(50)
touchMove(0,336,242)
mSleep(delay)
touchUp(0,336,242)
end

function movedown(delay)
touchDown(0,248,242)
mSleep(50)
touchMove(0,160,242)
mSleep(delay)
touchUp(0,160,242)
end

function moveleft(delay)
touchDown(0,248,242)
mSleep(50)
touchMove(0,248,154)
mSleep(delay)
touchUp(0,248,154)
end

function moveright(delay)
touchDown(0,248,242)
mSleep(50)
touchMove(0,248,330)
mSleep(delay)
touchUp(0,248,330)
end

