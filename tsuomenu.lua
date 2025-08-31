local Players = game:GetService("Players")
local LocalizationService = game:GetService("LocalizationService")
local LocalPlayer = Players.LocalPlayer

local success, countryCode = pcall(function()
    return LocalizationService:GetCountryRegionForPlayerAsync(LocalPlayer)
end)

local isPortuguese = false
if success and countryCode == "BR" then
    isPortuguese = true
else
    local PlayerLocaleId = LocalizationService.RobloxLocaleId or "en-us"
    if string.find(PlayerLocaleId:lower(), "pt") then
        isPortuguese = true
    end
end

local function T(pt, en)
    return isPortuguese and pt or en
end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "Tsuo Hub",
    SubTitle = "discord.gg/tsuo | By DRKscripts",
    TabWidth = 120,
    Size = UDim2.fromOffset(430, 300),
    Acrylic = true,
    Theme = "Amethyst"
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Scripts = Window:AddTab({ Title = T("Scripts", "Scripts"), Icon = "code" })
}

Tabs.Main:AddParagraph({
    Title = T("Entre em nosso Discord!", "Join our Discord!"),
    Content = "discord.gg/tsuo"
})

Tabs.Main:AddButton({
    Title = T("Copiar link do Discord", "Copy Discord link"),
    Description = "discord.gg/tsuo",
    Callback = function()
        setclipboard("discord.gg/tsuo")
        Fluent:Notify({
            Title = "Tsuo Hub",
            Content = T("Link copiado para sua área de transferência!", "Link copied to clipboard!"),
            Duration = 4
        })
    end
})

local games = {
    {Name = "Grow a Garden", Url = "https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/growagarden"},
    {Name = "99 Nights", Url = "https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuohub99nights"},
    {Name = "Hunty Zombie", Url = "https://raw.githubusercontent.com/DRK070/TsuoHubZombie/refs/heads/main/TsuoHuntyZombie.lua"},
    {Name = "Forsaken", Url = "https://raw.githubusercontent.com/DRK070/TsuoHubForsaken/refs/heads/main/TsuoForsaken.lua"},
    {Name = "Blox Fruits", Url = "https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"},
    {Name = "King Legacy", Url = "https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/king%20legacy"},
}

for _, entry in ipairs(games) do
    Tabs.Scripts:AddButton({
        Title = entry.Name,
        Description = T("Executar script de ", "Execute script for ") .. entry.Name,
        Callback = function()
            loadstring(game:HttpGet(entry.Url))()
            Window:Destroy()
        end
    })
end

Window:SelectTab(1)

Fluent:Notify({
    Title = "Tsuo Hub",
    Content = T("Carregado com sucesso!", "Loaded successfully!"),
    SubContent = "discord.gg/tsuo",
    Duration = 4
})