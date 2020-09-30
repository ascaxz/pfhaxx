local CumHaxx = {}
getgenv().CumModule = true
function CumHaxx:GetSound()
    for I,V in pairs(getgc()) do
        if type(V) == "table" and rawget(V, "play") then
            return V
        end
    end
end
function CumHaxx:GetNetwork()
    for I,V in pairs(getgc()) do
        if type(V) == "table" and rawget(V, "send") then
            return V
        end
    end
end
function CumHaxx:GetCamera()
    for I,V in pairs(getgc()) do
        if type(V) == "table" and rawget(V, "shake") then
            return V
        end
    end
end
function CumHaxx:GetBodyPart(Player)
    for I,V in pairs(getgc()) do
        if type(V) == "table" and rawget(V, "getbodyparts") then
            return V.getbodyparts(Player)
        end
    end
end
function CumHaxx:GetCharacter()
    for I,V in pairs(getgc()) do
        if type(V) == "table" and rawget(V, "jump") then
            return V
        end
    end
end
function CumHaxx:ChangeWalkSpeed(WalkSpeed)
    local E
    for I,V in pairs(getgc()) do
        if type(V) == "table" and rawget(V, "setbasewalkspeed") then
            E = V
            break
        end
    end
    game:GetService("RunService").Heartbeat:Connect(function()
        E:setbasewalkspeed(WalkSpeed)
    end)
end
function CumHaxx:IsPlayerAlive(Player)
    for I,V in pairs(getgc()) do
        if type(V) == "table" and rawget(V, "isplayeralive") then
            return V:isplayeralive(Player)
        end
    end
end
function CumHaxx:GetGameLogic()
    for I,V in pairs(getgc()) do
        if type(V) == "table" and rawget(V, "currentgun") then
            return V
        end
    end
end
function CumHaxx:Console(Text, PlaySound)
    if PlaySound == nil then PlaySound = false end
    local Misc = game:GetService("ReplicatedStorage").Misc
    local ChatGui = game:GetService("Players").LocalPlayer.PlayerGui.ChatGame
    local MSG = Misc.Msger
    local message = MSG:Clone()
    message.Parent = ChatGui.GlobalChat
    message.Text = "[CumHaxx]: "
    coroutine.wrap(function()
        while wait() do
            local Hue = tick() % 5 / 5
            message.TextColor3 = Color3.fromHSV(Hue, 1, 1)
        end
    end)()
    message.Msg.Text = Text
    message.Msg.Position = UDim2.new(0, message.TextBounds.X, 0, 0)
    message.Visible = true
    message.Msg.Visible = true
    if PlaySound then
        local Play = CumHaxx:GetSound().play
        Play("ui_smallaward", 10, nil, game:GetService("Players").LocalPlayer)
    end
end






















return CumHaxx
