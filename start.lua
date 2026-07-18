local relay = peripheral.wrap("redstone_relay_0")
local state = false  -- Başlangıçta kapalı

while true do
    -- Arka yüzden sinyal kontrolü
    if relay.getInput("back") then
        -- Toggle mantığı
        state = not state

        if state then
            -- Sağ yüzü aktif et
            relay.setOutput("right", true)
            shell.run("on.lua")
        else
            -- Sağ yüzü kapat
            relay.setOutput("right", false)
            shell.run("off.lua")
        end

        -- Tek tetikleme için kısa bekleme
        sleep(0.5)
        -- Sinyal bitene kadar bekle
        while relay.getInput("back") do
            sleep(0.1)
        end
    end

    sleep(0.1)
end
