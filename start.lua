-- start.lua
local relay = peripheral.wrap("redstone_relay_0")
local spk = peripheral.wrap("speaker_1")
local mon = peripheral.wrap("monitor_1")
local relay2 = peripheral.wrap("redstone_relay_1")

local mode = "none" -- başlangıçta sistem kapalı

print("Start.lua is running...")

while true do
    -- Toggle kontrolü
    if relay.getInput("back") then
        if mode == "none" or mode == "off" then
            mode = "on"
            -- ON sistemi
            if spk then
                for i = 1, 3 do
                    spk.playSound("entity.firework.launch", 1, 1)
                    sleep(0.5)
                end
                spk.playSound("block.beacon.activate", 1, 1)
            end
            if mon then
                mon.setBackgroundColor(colors.black)
                mon.setTextColor(colors.green)
                mon.clear()
                mon.setCursorPos(1,1)
                mon.write("Launch Logs")
                local t = textutils.formatTime(os.time(), true)
                mon.setCursorPos(1,2)
                mon.write(t .. " Launch Process is Started")
                relay.setOutput("right", true) 
            end

        elseif mode == "on" then
            mode = "off"
            -- OFF sistemi
            if spk then
                for i = 1, 3 do
                    spk.playNote("harp", 1, 24) -- ~2000 Hz
                    spk.playNote("harp", 1, 6)  -- ~300 Hz
                    sleep(0.7)
                end
                spk.playSound("block.beacon.deactivate", 1, 1)
            end
            if mon then
                mon.setBackgroundColor(colors.black)
                mon.setTextColor(colors.red)
                mon.clear()
                mon.setCursorPos(1,1)
                mon.write("Fall Logs")
                local t = textutils.formatTime(os.time(), true)
                mon.setCursorPos(1,2)
                mon.write(t .. "  FALLING!!!")
                relay.setOutput("right", false) 
            end
        end

        -- Tek tetikleme için bekleme
        sleep(0.5)
        while relay.getInput("back") do sleep(0.1) end
    end

    -- 2. log: relay2 seviyesi sürekli güncellenir
    if mon and relay2 and (mode == "on" or mode == "off") then
        local level = relay2.getAnalogInput("front")
        local t = textutils.formatTime(os.time(), true)
        mon.setCursorPos(1,3)
        mon.clearLine()
        mon.write(t .. "  Altitude Level: " .. tostring(level))
    end

    sleep(0.5)
end
