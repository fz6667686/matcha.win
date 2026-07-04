-- ==========================================
-- TEAM DETECTOR (PRISON LIFE)
-- ==========================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if not LocalPlayer then
    print("[ERROR] LocalPlayer not found. Make sure you are in-game.")
    return
end

print("[INFO] Starting Team and Inventory Check...")

-- Function to check a specific player's team/inventory
local function checkPlayerTeam(player)
    if not player then return end
    
    local isGuard = false
    local detectionMethod = "None"

    -- Method 1: Check Team via Player.Team property
    if player.Team then
        local teamName = tostring(player.Team.Name):lower()
        if string.find(teamName, "guard") or string.find(teamName, "police") then
            isGuard = true
            detectionMethod = "Tab/Team Property"
        end
    end

    -- Method 2: Check Inventory (Backpack) for Handcuffs
    if not isGuard and player:FindFirstChild("Backpack") then
        if player.Backpack:FindFirstChild("Handcuffs") then
            isGuard = true
            detectionMethod = "Inventory (Handcuffs found)"
        end
    end

    -- Method 3: Check Character (if they are currently holding them)
    if not isGuard and player.Character then
        if player.Character:FindFirstChild("Handcuffs") then
            isGuard = true
            detectionMethod = "Character Holding Handcuffs"
        end
    end

    -- Print result
    if isGuard then
        print("[GUARD] " .. player.Name .. " | Detected via: " .. detectionMethod)
    else
        print("[PRISONER/OTHER] " .. player.Name)
    end
end

-- 1. Check yourself first
print("--- Checking LocalPlayer ---")
checkPlayerTeam(LocalPlayer)

-- 2. Check all players currently in the server
print("--- Checking Server Players ---")
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        checkPlayerTeam(player)
    end
end

print("[INFO] Scan complete.")
