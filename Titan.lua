-- ✅ Versão 2.1 | AOT Revolution Script com Anti-Ban (Sem ESP)

-- 🛡️ ANTI-BAN AVANÇADO
local function ativarAntiBan()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)

    local old = mt.__namecall

    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}

        if method == "Kick" then
            warn("[Anti-Ban] Tentaram te kikar, bloqueado.")
            return nil
        end

        if method == "BreakJoints" and tostring(self) == "Humanoid" then
            warn("[Anti-Ban] Tentaram quebrar joints do jogador.")
            return nil
        end

        if method == "TakeDamage" and tostring(self) == "Humanoid" then
            warn("[Anti-Ban] Tentaram causar dano ao Humanoid.")
            return nil
        end

        return old(self, unpack(args))
    end)

    print("[✔] Anti-Ban ativado com sucesso.")
end

-- 🔍 DETECÇÃO APRIMORADA DE TITÃS
local function detectarTitans()
    local resultados = {}

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and (obj.Name:lower():find("titan") or obj.Name:lower():find("boss")) then
            if obj:FindFirstChild("HumanoidRootPart") then
                table.insert(resultados, obj)
            end
        end
    end

    return resultados
end

-- ⚔️ AUTO-KILL DE TITÃS (BÁSICO)
local function autoKill()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()

    while true do
        for _, titan in ipairs(detectarTitans()) do
            local root = titan:FindFirstChild("HumanoidRootPart")
            local humanoid = titan:FindFirstChildOfClass("Humanoid")

            if root and humanoid and humanoid.Health > 0 then
                char:MoveTo(root.Position + Vector3.new(0, 5, 0))
                wait(0.2)
                humanoid.Health = 0
                wait(0.5)
            end
        end
        wait(1)
    end
end

-- 🔁 INICIAR TUDO
task.spawn(ativarAntiBan)
task.spawn(autoKill)
