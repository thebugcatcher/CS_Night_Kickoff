scriptId = 'com.thalmic.examples.test'
scriptTitle = "test"
scriptDetailsUrl = ""

function onForegroundWindowChange(app, title)
    myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
    local titleMatch = string.match(title, "Race The Sun") ~= nil or string.match(title, "RaceTheSun") ~= nil;
    myo.debug("Race the Sun: "  .. tostring(titleMatch))
    if (titleMatch) then
        myo.setLockingPolicy("none")
    end
end
