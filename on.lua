-- on.lua
local spk = peripheral.wrap("speaker_0")
local mon = peripheral.wrap("monitor_1")
local relay2 = peripheral.wrap("redstone_relay_2")

-- Hoparlörden ses efektleri
if spk then
    for i = 1, 3 do
        spk.playSound("entity.firework.launch", 1, 1)
        sleep(0.5)
    end
    spk.playSound("block.beacon.activate", 1, 1)
end

-- Monitör ayarları
if mon then
    mon.setBackgroundColor(colors.black)
    mon.setTextColor(colors.green)
    mon.clear()
    mon.setCursorPos(1,1)
    mon.write("Launch Logs")

    -- İlk log: Başlangıç
    local t = textutils.formatTime(os.time(), true)
    mon.setCursorPos(1,2)
    mon.write(t .. "  Launch Process is Started")
end

-- Sürekli relay girişini logla
while true do
    if mon and relay2 then
        local level = relay2.getInput("front") -- ön yüzdeki giriş
        local t = textutils.formatTime(os.time(), true)
        mon.setCursorPos(1,3)
        mon.clearLine()
        mon.write(t .. "  Relay2 Front Input: " .. tostring(level))
    end
    sleep(0.5)
end
