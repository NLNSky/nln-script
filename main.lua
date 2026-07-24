-- ===== by nln Scripts =====
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NLNSplash"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0, 280, 0, 70)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BackgroundTransparency = 1
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)

local Stroke = Instance.new("UIStroke")
Stroke.Parent = Frame
Stroke.Color = Color3.fromRGB(170, 0, 255)
Stroke.Thickness = 2
Stroke.Transparency = 1

local Text = Instance.new("TextLabel")
Text.Parent = Frame
Text.Size = UDim2.fromScale(1, 1)
Text.BackgroundTransparency = 1
Text.Text = "by nln"
Text.Font = Enum.Font.GothamBold
Text.TextScaled = true
Text.TextColor3 = Color3.fromRGB(170, 0, 255)
Text.TextTransparency = 1

TweenService:Create(Frame, TweenInfo.new(0.35), {BackgroundTransparency = 0.2}):Play()
TweenService:Create(Stroke, TweenInfo.new(0.35), {Transparency = 0}):Play()
TweenService:Create(Text, TweenInfo.new(0.35), {TextTransparency = 0}):Play()

task.wait(2)

TweenService:Create(Frame, TweenInfo.new(0.35), {BackgroundTransparency = 1}):Play()
TweenService:Create(Stroke, TweenInfo.new(0.35), {Transparency = 1}):Play()
TweenService:Create(Text, TweenInfo.new(0.35), {TextTransparency = 1}):Play()

task.wait(0.4)
ScreenGui:Destroy()

task.wait(0.1)


-- UI Panel by nln
local UIState={ShowName=true,ShowHP=true,ShowDist=true,ESW=false,CL=false}
do
local pg=Instance.new("ScreenGui")
pg.Name="NLNPanel"
pg.ResetOnSpawn=false
pg.Parent=game:GetService("CoreGui")
local f=Instance.new("Frame",pg)
f.Size=UDim2.new(0,170,0,160)
f.Position=UDim2.new(0,40,0.4,0)
f.BackgroundColor3=Color3.new(0,0,0)
f.BorderColor3=Color3.fromRGB(170,0,255)
local u=Instance.new("UICorner",f);u.CornerRadius=UDim.new(0,18)
local t=Instance.new("TextLabel",f)
t.Size=UDim2.new(1,0,0,22);t.BackgroundTransparency=1
t.Text="by nln";t.TextColor3=Color3.fromRGB(170,0,255);t.Font=Enum.Font.GothamBold
local items={{"Name","ShowName",30},{"HP","ShowHP",55},{"Dist","ShowDist",80},{"E-SW","ESW",105},{"CL","CL",130}}
for _,it in ipairs(items) do
 local l=Instance.new("TextLabel",f);l.Position=UDim2.new(0,12,0,it[3]);l.Size=UDim2.new(0,70,0,20);l.BackgroundTransparency=1;l.Text=it[1];l.TextColor3=Color3.fromRGB(170,0,255)
 local b=Instance.new("TextButton",f);b.Position=UDim2.new(1,-34,0,it[3]);b.Size=UDim2.new(0,18,0,18);b.Text=""
 local c=Instance.new("UICorner",b);c.CornerRadius=UDim.new(1,0)
 local function upd() b.BackgroundColor3=UIState[it[2]] and Color3.fromRGB(170,0,255) or Color3.fromRGB(40,40,40) end
 upd();b.MouseButton1Click:Connect(function() UIState[it[2]]=not UIState[it[2]];upd() end)
end
local tog=Instance.new("TextButton",pg)
tog.Size=UDim2.new(0,70,0,18);tog.Position=UDim2.new(0,90,0.4,162)
tog.Text="˅";tog.BackgroundColor3=Color3.new(0,0,0);tog.BorderColor3=Color3.fromRGB(170,0,255)
local uc=Instance.new("UICorner",tog);uc.CornerRadius=UDim.new(1,0)
local open=true
tog.MouseButton1Click:Connect(function() open=not open;f.Visible=open;tog.Text=open and "˅" or "˄" end)
local UIS=game:GetService("UserInputService")
local drag,dstart,start
f.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true;dstart=i.Position;start=f.Position end end)
UIS.InputChanged:Connect(function(i)
 if drag and i.UserInputType==Enum.UserInputType.MouseMovement then
  local d=i.Position-dstart
  f.Position=UDim2.new(start.X.Scale,start.X.Offset+d.X,start.Y.Scale,start.Y.Offset+d.Y)
  tog.Position=UDim2.new(f.Position.X.Scale,f.Position.X.Offset+50,f.Position.Y.Scale,f.Position.Y.Offset+162)
 end
end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
end

-- ESP Script (R6/R15) by nln

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local ESPColor = Color3.fromRGB(170, 0, 255)

local MIN_SCALE = 0.8
local MAX_SCALE = 1.15
local MAX_DISTANCE = 300

local ESP = {}

local function ensureBoxes(char)
    if not char or not UIState.ESW then return end
    for _,part in ipairs(char:GetChildren()) do
        if part:IsA("BasePart") and not part:FindFirstChild("ESPBoxTag") then
            local ok=false
            local n=part.Name
            if n=="Head" or n=="Torso" or n=="UpperTorso" or n=="LowerTorso"
            or n:find("Arm") or n:find("Leg") or n=="LeftHand" or n=="RightHand"
            or n=="LeftFoot" or n=="RightFoot" then
                ok=true
            end
            if ok then
                local tag=Instance.new("BoolValue")
                tag.Name="ESPBoxTag"
                tag.Parent=part
                local box=Instance.new("BoxHandleAdornment")
                box.Name="ESPBox"
                box.Adornee=part
                box.AlwaysOnTop=true
                box.ZIndex=10
                box.Color3=ESPColor
                box.Transparency=0.35
                box.Size=part.Size+Vector3.new(0.05,0.05,0.05)
                box.Visible=true
                box.Parent=char
            end
        end
    end
end


local function getCharacterRoot(char)
    return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
end

local function createBillboard(name, offset)
    local bb = Instance.new("BillboardGui")
    bb.Name = name
    bb.AlwaysOnTop = true
    bb.Size = UDim2.new(0,120,0,40)
    bb.StudsOffset = offset

    local txt = Instance.new("TextLabel")
    txt.BackgroundTransparency = 1
    txt.Size = UDim2.fromScale(1,1)
    txt.Font = Enum.Font.GothamBold
    txt.TextColor3 = ESPColor
    txt.TextStrokeTransparency = 0.5
    txt.TextScaled = true
    txt.Parent = bb

    return bb, txt
end

local function setup(player)
    if player == LocalPlayer then return end

    local function onCharacter(char)
        local hum = char:WaitForChild("Humanoid",5)
        local root = getCharacterRoot(char)
        if not hum or not root then return end

        local adornments = {}

        local highlight=Instance.new("Highlight")
        highlight.Name="ESPOutline"
        highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillTransparency=1
        highlight.OutlineTransparency=0
        highlight.OutlineColor=ESPColor
        highlight.Enabled=UIState.CL
        highlight.Parent=char


        local function addBox(part)
            if part then
                local box = Instance.new("BoxHandleAdornment")
                box.Name = "ESPBox"
                box.Adornee = part
                box.AlwaysOnTop = true
                box.ZIndex = 10
                box.Color3 = ESPColor
                box.Transparency = 0.35
                box.Size = part.Size + Vector3.new(0.05,0.05,0.05)
                box.Visible = UIState.ESW
                box.Parent = char
                table.insert(adornments, box)
            end
        end

        addBox(char:FindFirstChild("Head"))

        for _,n in ipairs({"UpperTorso","LowerTorso","Torso"}) do
            if char:FindFirstChild(n) then addBox(char[n]) end
        end

        for _,n in ipairs({"Left Arm","Right Arm","Left Leg","Right Leg","LeftUpperArm","LeftLowerArm","RightUpperArm","RightLowerArm","LeftHand","RightHand","LeftUpperLeg","LeftLowerLeg","LeftFoot","RightUpperLeg","RightLowerLeg","RightFoot"}) do
            if char:FindFirstChild(n) then addBox(char[n]) end
        end

        local head = char:WaitForChild("Head")

        local nameGui,nameTxt = createBillboard("ESPName", Vector3.new(0,2.8,0))
        nameGui.Parent = head

        local hpGui,hpTxt = createBillboard("ESPHP", Vector3.new(0,-4,0))
        hpGui.Parent = root

        local distGui,distTxt = createBillboard("ESPDist", Vector3.new(2.2,0.5,0))
        distGui.Parent = root

        local con
        con = RunService.RenderStepped:Connect(function()
            if not char.Parent then
                con:Disconnect()
                return
            end

            local lchar = LocalPlayer.Character
            local lroot = lchar and getCharacterRoot(lchar)
            if not lroot then return end

            local dist = (root.Position - lroot.Position).Magnitude
            local t = math.clamp(1 - (dist / MAX_DISTANCE),0,1)
            local scale = MIN_SCALE + (MAX_SCALE - MIN_SCALE) * t

            nameGui.Size = UDim2.new(0,120*scale,0,24*scale)
            hpGui.Size   = UDim2.new(0,90*scale,0,20*scale)
            distGui.Size = UDim2.new(0,60*scale,0,42*scale)

            nameGui.Enabled=UIState.ShowName
            hpGui.Enabled=UIState.ShowHP
            distGui.Enabled=UIState.ShowDist
            highlight.Enabled=UIState.CL
            for _,box in ipairs(adornments) do
                box.Visible = UIState.ESW
                box.Color3 = ESPColor
                box.Transparency = 0.35
            end
            nameTxt.Text = player.Name
            hpTxt.Text = ("%d%%"):format(math.floor((hum.Health / hum.MaxHealth) * 100))
            distTxt.Text = ("D\n%d"):format(math.floor(dist))
        end)
    end

    if player.Character then
        task.spawn(onCharacter, player.Character)
    end
    player.CharacterAdded:Connect(onCharacter)
end

for _,p in ipairs(Players:GetPlayers()) do
    setup(p)
end

Players.PlayerAdded:Connect(setup)

task.spawn(function()
    while true do
        task.wait(30)
        if UIState.ESW then
            for _,plr in ipairs(Players:GetPlayers()) do
                if plr~=LocalPlayer then
                    local char=plr.Character
                    if char then
                        ensureBoxes(char)
                    end
                end
            end
        end
    end
end)

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(char)
        if UIState.ESW then
            task.wait(0.2)
            ensureBoxes(char)
        end
    end)
end)


