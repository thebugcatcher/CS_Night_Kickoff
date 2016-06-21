scriptId = 'com.thalmic.examples.gods_of_drifting'
scriptTitle = "Gods of Drifting"
scriptDetailsUrl = ""

function onForegroundWindowChange(app, title)
  -- myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
  -- local titleMatch = string.match(title, "Gods of Drifting") ~= nil or string.match(title, "GodsOfDrifting") ~= nil;
  -- myo.debug("Gods of Drifting: "  .. tostring(titleMatch))
  -- if (titleMatch) then
  --     myo.setLockingPolicy("none")
  -- end

  myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
  myo.setLockingPolicy("none")
  return true
end

function onPoseEdge(pose, edge)
  myo.debug("onPoseEdge: " .. pose .. ": " .. edge)
  local keyEdge = edge == "off" and "up" or "down"

  if (pose == "waveOut") then
      onWaveOut(keyEdge)
  elseif (pose == "waveIn") then
      onWaveIn(keyEdge)
  elseif (pose == "fist") then
      onFist(keyEdge)
  elseif (pose == "fingersSpread") then
      onFingersSpread(keyEdge)
  end
end

function onWaveOut(keyEdge)
  myo.debug("right_arrow")
  --myo.vibrate("short")
  myo.keyboard("right_arrow", keyEdge)
end

function onWaveIn(keyEdge)
  myo.debug("left_arrow")
  --myo.vibrate("short")
  --myo.vibrate("short")
  myo.keyboard("left_arrow", keyEdge)
end

function onFist(keyEdge)
  myo.debug("up_arrow")
  --myo.vibrate("medium")
  myo.keyboard("up_arrow", keyEdge)
end

function onFingersSpread(keyEdge)
  myo.debug("down_arrow")
  --myo.vibrate("long")
  myo.keyboard("down_arrow", keyEdge)
end
