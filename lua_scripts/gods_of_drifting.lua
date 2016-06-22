scriptId = 'com.thalmic.examples.gods_of_drifting'
scriptTitle = "Gods Of Drifting"
scriptDetailsUrl = ""

function onForegroundWindowChange(app, title)
    myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
    if title == "Gods of Drifting" then
      myo.setLockingPolicy("none")
    end

    return true
end

function onPoseEdge(pose, edge)
  myo.debug("onPoseEdge: " .. pose .. ": " .. edge)
  if edge == "on" then
    edge = "down"
  elseif edge == "off" then
    edge = "up"
  end

  if (pose == "fist") then
    onFist(edge)
  elseif (pose == "fingersSpread") then
    onFingerSpread(edge)
  elseif (pose == "waveOut") then
    onWaveOut(edge)
  elseif (pose == "waveIn") then
    onWaveIn(edge)
  end
end

function onFist(edge)
  myo.keyboard("up_arrow", edge)
end

function onFingerSpread(edge)
  myo.keyboard("down_arrow", edge)
end

function onWaveIn(edge)
  myo.keyboard("left_arrow", edge)
end

function onWaveOut(edge)
  myo.keyboard("right_arrow", edge)
end


