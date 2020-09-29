local CumModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/ascaxz/pfhaxx/master/Module.lua", true))()

local camera = game:GetService("Workspace").CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = game:GetService("Players").LocalPlayer
local mouse = game:GetService("Players").LocalPlayer:GetMouse()
local Paused = false
local Visible = false

local ToggleEvent = assert(getgenv().ToggleDrawingESP, "Error in creation of BindableEvent")

TaggedPlayers = {}
LinedPlayers = {}
PlayerNames = {}

function WorldToScreen(part, idx)
    if part ~= nil then
        RootPos = part.position
        scr, vis = camera:WorldToScreenPoint(RootPos)
        if vis then
            TaggedPlayers[idx].Visible = true
            LinedPlayers[idx].Visible = true
            return Vector2.new(scr.x, scr.y)
        else
            TaggedPlayers[idx].Visible = false
            LinedPlayers[idx].Visible = false
            return Vector2.new(0, 0)
        end
    else
        TaggedPlayers[idx].Visible = false
        LinedPlayers[idx].Visible = false
        return Vector2.new(0, 0)
    end
end

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

local function cleartb(t)
    for k in pairs(t) do
        t[k] = nil
    end
end

local function removeESP(t)
    for k in pairs(t) do
        t[k].Remove(t[k])
    end
end

function Init()
    Paused = true
    removeESP(TaggedPlayers)
    removeESP(LinedPlayers)
    cleartb(LinedPlayers)
    cleartb(TaggedPlayers)
    cleartb(PlayerNames)

    Wait(1)
    Paused = false
end

function LoadESP()
    for i, v in pairs(game:GetService("Players"):GetChildren()) do
        if game:GetService("Workspace"):FindFirstChild(v.Name) ~= nil then
            if not has_value(PlayerNames, v.Name) then
                table.insert(LinedPlayers, Drawing.new("Line"))
                table.insert(TaggedPlayers, Drawing.new("Text"))
                table.insert(PlayerNames, v.Name)
                if v.Name ~= LocalPlayer.Name then
                    TaggedPlayers[i].Text = v.Name
                    TaggedPlayers[i].Size = 14.0
                    TaggedPlayers[i].Color = v.TeamColor.Color
                    TaggedPlayers[i].Outline = true
                    TaggedPlayers[i].Center = true
                    TaggedPlayers[i].Font = 2

                    LinedPlayers[i].Thickness = 1.5
                    LinedPlayers[i].Color = v.TeamColor.Color

                    Loc = WorldToScreen(CumModule:GetBodyPart(v):FindFirstChild("HumanoidRootPart"), i)

                    LinedPlayers[i].From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y - 2)
                    LinedPlayers[i].To = Loc
                    TaggedPlayers[i].Position = Loc
                end
            else
                Loc = WorldToScreen(CumModule:GetBodyPart(v):FindFirstChild("HumanoidRootPart"), i)
                LinedPlayers[i].From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y - 2)
                LinedPlayers[i].To = Loc
                TaggedPlayers[i].Position = Loc
                LinedPlayers[i].Transparency = Visible and 1 or 0
                TaggedPlayers[i].Transparency = Visible and 1 or 0
            end
        end
    end
end

Init()

Players.PlayerAdded:connect(
    function(player)
        Paused = true
        removeESP(TaggedPlayers)
        removeESP(LinedPlayers)
        cleartb(LinedPlayers)
        cleartb(TaggedPlayers)
        cleartb(PlayerNames)
        Paused = false
        delay(.5, function()
            ToggleEvent:Fire(Visible)
        end)
    end
)

Players.PlayerRemoving:connect(
    function(player)
        Paused = true
        removeESP(TaggedPlayers)
        removeESP(LinedPlayers)
        cleartb(LinedPlayers)
        cleartb(TaggedPlayers)
        cleartb(PlayerNames)
        Paused = false
        delay(.5, function()
            ToggleEvent:Fire(Visible)
        end)
    end
)

RunService.RenderStepped:connect(
    function()
        if not Paused then
            LoadESP()
        end
    end
)

ToggleEvent.Event:connect(function(t)
    Visible = t
end)
