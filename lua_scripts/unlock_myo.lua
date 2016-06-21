scriptId = 'com.thalmic.examples.test'
scriptTitle = "test"
scriptDetailsUrl = ""
myo.setLockingPolicy("none")

function onForegroundWindowChange(app, title)
    myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
end

