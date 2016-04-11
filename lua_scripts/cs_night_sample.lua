scriptId = 'com.thalmic.examples.csnight'
scriptTitle = "csnight"
scriptDetailsUrl = ""

centreYaw = 0
centreRoll = 0

deltaRoll = 0

YAW_DEADZONE = .1
ROLL_DEADZONE = .2
MOUSE_CONTROL_TOGGLE_DURATION = 1000

PI = 3.1416
TWOPI = PI * 2

flyingLeft = false
flyingRight = false

togglingMouseControl = 0
mouseEnabled = true

printCount = 0

function onForegroundWindowChange(app, title)
    myo.controlMouse(titleMatch and mouseEnabled);
    if (titleMatch) then
        myo.setLockingPolicy("none")
    end
    return titleMatch;
end

function onPoseEdge(pose, edge)
    if (edge == "on") then
        if (pose == "fist") then
            centre()
            if (mouseEnabled) then
                toggleMouseControl()
            end
        elseif (pose == "fingersSpread") then
            escape();
        elseif (pose == "waveIn" or pose == "waveOut") then
            if (math.abs(deltaRoll) > ROLL_DEADZONE) then
                jump()
            elseif (pose == "waveIn") then
                leftClick()
            else
                if (mouseEnabled) then
                    toggleMouseControl();
                else
                    togglingMouseControl = myo.getTimeMilliseconds();
                end
            end
        end
    else
        togglingMouseControl = 0
    end
end

function activeAppName()
    return "csnight"
end

function centre()
    centreYaw = myo.getYaw()
    centreRoll = myo.getRoll()
    myo.controlMouse(false);
    myo.vibrate("short")
    myo.keyboard("return", "press")
end

function onPeriodic()
    if (togglingMouseControl > 0 and myo.getTimeMilliseconds() > (togglingMouseControl + MOUSE_CONTROL_TOGGLE_DURATION)) then
        togglingMouseControl = 0
        toggleMouseControl()
    end

    if (centreYaw == 0) then
        return
    end
    local currentYaw = myo.getYaw()
    local currentRoll = myo.getRoll()
    local deltaYaw = calculateDeltaRadians(currentYaw, centreYaw)
    deltaRoll = calculateDeltaRadians(currentRoll, centreRoll);
    printCount = printCount + 1
    if printCount >= 200 then
        printCount = 0
    end
    if (deltaYaw < -YAW_DEADZONE) then
        flyLeft()
    elseif (deltaYaw > YAW_DEADZONE) then
        flyRight()
    else
        flyNeutral()
    end
end

function flyLeft()
    if (flyingRight) then
        myo.keyboard("right_arrow","up")
        flyingRight = false
    end
    if (not flyingLeft) then
        myo.keyboard("left_arrow","down")
        flyingLeft = true;
    end
end

function flyRight()
    if (flyingLeft) then
        myo.keyboard("left_arrow","up")
        flyingLeft = false
    end
    if (not flyingRight) then
        myo.keyboard("right_arrow","down")
        flyingRight = true
    end
end

function jump()
    myo.keyboard("space","press")
end

function flyNeutral()
    if  (flyingLeft) then
        myo.keyboard("left_arrow","up")
        flyingLeft = false
    end
    if (flyingRight) then
        myo.keyboard("right_arrow","up")
        flyingRight = false
    end
end

function calculateDeltaRadians(currentYaw, centreYaw)
    local deltaYaw = currentYaw - centreYaw

    if (deltaYaw > PI) then
        deltaYaw = deltaYaw - TWOPI
    elseif(deltaYaw < -PI) then
        deltaYaw = deltaYaw + TWOPI
    end
    return deltaYaw
end

function toggleMouseControl()
    mouseEnabled = not mouseEnabled
    myo.vibrate("medium")
    if (mouseEnabled) then
        centreYaw = 0
        flyNeutral()
    else
    end
    myo.controlMouse(mouseEnabled);
end

function leftClick()
    myo.mouse("left", "click")
end

function escape()
    centreYaw = 0
    myo.keyboard("escape","press")
end
