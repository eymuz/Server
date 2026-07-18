local relay = peripheral.wrap("redstone_relay_0")
local state = false  -- başlangıçta kapalı

while true do
    -- Arka yüzden sinyal kontrolü
    if relay.getInput("south") then
        -- Toggle mantığı
        state = not state

        if state then
            -- Sağ yüzü aktif et
            relay.setOutput("east", true)
            shell.run("on.lua")
        else
            -- Sağ yüzü kapat
            relay.setOutput("east", false)
            shell.run("off.lua")
        end

        -- Tek sinyal algılaması için kısa bekleme
        sleep(0.5)
        -- Sinyal bitene kadar bekle
        while relay.getInput("south") do
            sleep(0.1)
        end
    end

    sleep(0.1)
end
