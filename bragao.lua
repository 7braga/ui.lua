pcall(function()
  local E = getgenv and getgenv() or _G
  E.__RYSHUB_BUILD = string.char(50, 54, 100, 57, 51, 50, 55, 56, 53, 97, 97, 56)
end)
setclipboard = setclipboard
local getgenv = getgenv or function()
  return _G
end
local F = "https://discord.gg/hTV5zPjjae"
local G = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local H = "__BE7300BD3F7B0C98901BF365"
local I = false
pcall(function()
  local J = getgenv()
  if type(J[H]) == "function" then
    J[H]()
  end
end)
G:Localization({
  Enabled = true,
  Prefix = "loc:",
  DefaultLanguage = "English",
  Translations = {
    ["English"] = {
      ["b5548857bfbe74e3a90f2f2a91fd521b"] = "Join our discord ʕ•́ᴥ•̀ʔっ♡",
      ["e79ad110a867753729b046fb34f41cd0"] = "Toggle UI Keybind",
      ["f0ef1a4885fed39ccf4049e5ae59c844"] = "Reset Toggle UI Keybind",
      ["c860ffe2aa0bc8f2f19751378a6d513b"] = "Reset this keybind to its default value.",
      ["d9aa593520ade55efa3d5e80a07b4cf4"] = "Reset All Keybinds",
      ["e1ec8181631ee4df350de6caf9d8602a"] = "Reset all keybinds to their default values.",
      ["f4a3863c373d15c1f0f057a0d262b1f3"] = "Edit Bubble Positions",
      ["e00aede412f4e0fa8adac1db28824008"] = "Unlock the on-screen bubbles so you can drag them. Turn this off to lock and save their positions.",
      ["aa5920a455bff5305f21430c2a5ca989"] = "Reset Bubble Positions",
      ["c40968cf77426597fc1002e19ba13c70"] = "Move every bubble back to its default position.",
      ["af644bdec3050256e4b089633ec7c1bb"] = "Toggle Panel Background",
      ["e5a0ad311db35c09d2a8d31d61682588"] = "Enable Notifications",
      ["b06dde438a08f90c210d3de482271695"] = "Unload Script",
      ["f05c53f426488e96cb51805e5ff6cca9"] = "Turns every feature off, unhooks the script and removes the UI. Just closing the window leaves your active features running.",
      ["ad3272e69caac43330718b23d4955751"] = "Language",
      ["e19908b67b5b1a911c69e7e250136f05"] = "Aim at Player",
      ["c6401e2c5000958ba6cf1284224f7033"] = "Rotates the camera toward the closest visible enemy.",
      ["e528eff1f02a3cf87c3c4c72ed4d935c"] = "Aim at Player Keybind",
      ["dc814b083f1afdc4c7eb89e54f4b54c2"] = "Only with firearm",
      ["c3115e4b7e12defdd991a24770b1f2ad"] = "Only with knife",
      ["b9a2b7f7c5dde9640074167ff8c74290"] = "Use raycast",
      ["fab02cd9c966ed2772485f348952b37d"] = "Open Body Part Editor",
      ["b94bf0d66d694b714394f964262adc0f"] = "Choose the body parts used by Aim Mobile.",
      ["efb1b5c3c854c7ae166c10648e3a6901"] = "Triggerbot",
      ["da8a12d3b3bf5148980f746a147eec84"] = "Triggerbot Keybind",
      ["e311dde60ce68fbdebaff476605de4f5"] = "Macro",
      ["aa2b3dd10e5280896abb08c2ad5d9a6e"] = "Macro Keybind",
      ["c10a3756d8b0d11b72b4f7d5a35fafeb"] = "Silent Aim",
      ["a09fbfecc4939ad3f4c2dacb6f092ff0"] = "Redirects your shots to the visible enemy closest to your cursor.",
      ["fdd4d952584aa7289d9caa39706da583"] = "Silent Aim Keybind",
      ["f603d87f683ddfe7e8e794c98a55a86e"] = "FOV",
      ["e53a42bc00372607cd31759543111ef9"] = "Only lock enemies inside the circle (around your cursor on PC, the screen center on mobile).",
      ["b06bb8f8eedbb99d7c9ba438324b0c6e"] = "Visible FOV",
      ["cbbbf53ca3a6245e7948906fdd94fc4d"] = "Draw the FOV circle on screen.",
      ["d15dff7b239795d01569811d5d3465a8"] = "FOV Radius",
      ["cc0f01f735dbd74a02e45530aac64416"] = "Hit Chance",
      ["a436b9219e3de9a9b903b23ba1cd8bf6"] = "% of your shots Silent Aim and the Macro take. The rest are left alone and land exactly where you aimed. Does not affect Auto Shoot.",
      ["fc15d13bac5f83470ac97d1b4a0ad04e"] = "Silent Aim Bubble",
      ["e5a210e23c31db476cf7851c616879fb"] = "Auto Shoot",
      ["c1c6c3f6eb15738a2d406de633e61a75"] = "Auto Shoot Keybind",
      ["afb83060b4c8e1b3501f41f439bb366f"] = "Auto Shoot Bubble",
      ["b8b6acb1ef3ec71564db220b83bee34e"] = "Kill All Enemies",
      ["aedb3de438c31e73809d044271ca6f83"] = "Keep Kill All Always On",
      ["d7a31c7a9773f67ced082a3ebce2278b"] = "Forces Kill All to stay on and locks its toggle so nothing can turn it off.",
      ["d769493da6cac80a80e345c26e3276e6"] = "Kill All Bubble",
      ["a61d83f3d6f99e193d194ea9608a5d59"] = "Invisible",
      ["f2761e3cd59401fb77a07540758e4efb"] = "Invisible Bubble",
      ["c7e7d88b539b76efc3e741e408422e42"] = "Desync",
      ["e1cb9fca42e476daca64fe5bd94b7f5d"] = "Desync Bubble",
      ["db13ef6667ab0f152d5660909506238a"] = "Bannable",
      ["fba977a40b22b988e9dded1417cad3a5"] = "Floating Floor",
      ["d1345f0cda656de47d5e6474b9f08d8a"] = "Hide Map",
      ["ebefa948038ac07ea78172a3c8133ebf"] = "Enable Jump Power",
      ["a5583643fe7eb46f11b783b7abd23751"] = "Jump Power Value",
      ["b5763258a150e11677fab2ce65d43228"] = "Enable Infinite Jump",
      ["d16d4182c7d070152d2c44dee9267832"] = "Enable Speed Hack",
      ["c4d9ce265bee45ab1a00d1d66b15c89f"] = "Speed Value",
      ["fb954fe1209e7e4af448a870ce9052d1"] = "Enable ESP",
      ["afb474e43c9abba8f2a424546978c7ae"] = "Show enemies through walls.",
      ["f8c12ba436a35d1990a8bc3c8e77944e"] = "ESP Color",
      ["c5d2cdd263fd3634ef88b70defbc6bea"] = "Show Enemy Name",
      ["e81d972ea3f11c21b37da930230b091c"] = "ESP Lines",
      ["e60736bc519b7966e29628d36ef08187"] = "Draw lines from your character to enemy positions.",
      ["e16764d65cf84aa798a554206d5be719"] = "ESP Lines Color",
      ["be9e408aec0c298c761ae8cdf9072f03"] = "ESP Keybind",
      ["d5e0016ed741d5ce98b888aaa3d5807a"] = "Enable Hitbox",
      ["b153bf65ab7cda2aa2735a2f07547f13"] = "Show and expand enemy hitboxes.",
      ["d1d20253ec2d3d00bc55958d04bf0377"] = "Hitbox Color",
      ["da30125c0dd7c41bf841a8681f4f5190"] = "Hitbox Size",
      ["b95e7c4d764ee540d887165836d439fa"] = "Hitbox Opacity",
      ["f5fd069150c2314bfb00c744505dd4d3"] = "Show Hitbox",
      ["f031f64fd927124f2749a994d2db2523"] = "Hitbox Keybind",
      ["c2b092443cd7cf784af8fd5431ae53bd"] = "Event Farm",
      ["de6fb023e8fc7a8ab7675ccc3c640284"] = "Automatically collects event drops during matches.",
      ["a25316ff5856541049ba2a6e9d08b425"] = "Automatically teleports to the selected zone when not in a match.",
      ["ddd3ac562d6393093032e19d46508255"] = "Duel Type",
      ["d44bb4f6c0bb3f7089939029cbc816ca"] = "Platform Row",
      ["a7ca395c40cc789197158e4a75cf2661"] = "Break Streak",
      ["b8a78f6003d84bfeb95e6b0a4c8bb466"] = "Uses Main or Alt automatically based on the active Auto Teleport role.",
      ["a91065ff20998adf9c1c8836c53fd7eb"] = "Break Streak Target",
      ["e31dda5e42067eacd1de46e6d1c3e6dd"] = "Lower KD",
      ["e5d883e875425461f7d4877a65230048"] = "Uses Main or Alt automatically based on the active Auto Teleport role.",
      ["ae1cddf7fd913336e01555ff8192b1b8"] = "KD Target Kills",
      ["d8f43decc8733fe46ef97509913f9f49"] = "Selected Box",
      ["d3a79b50f6ee54a51e87dd6d783ef946"] = "Choose which box to buy.",
      ["d057768612c13c7cec145ef544aaa0e9"] = "Buy Box",
      ["e6b0c75f7f453e79992e64f08b5c9756"] = "Buys the selected box if you have enough cash.",
      ["cc6f88fdc0f140aada975b395249475c"] = "Auto Buy",
      ["d805b76f713b15d54843d142ca179701"] = "Automatically buys the selected box.",
    },
    ["Espanol"] = {
      ["b5548857bfbe74e3a90f2f2a91fd521b"] = "Únete a nuestro Discord ʕ•́ᴥ•̀ʔっ♡",
      ["e79ad110a867753729b046fb34f41cd0"] = "Tecla para UI",
      ["f0ef1a4885fed39ccf4049e5ae59c844"] = "Resetear Tecla UI",
      ["c860ffe2aa0bc8f2f19751378a6d513b"] = "Restablece esta tecla a su valor predeterminado.",
      ["d9aa593520ade55efa3d5e80a07b4cf4"] = "Resetear Todas las Teclas",
      ["e1ec8181631ee4df350de6caf9d8602a"] = "Restablece todas las teclas a sus valores predeterminados.",
      ["f4a3863c373d15c1f0f057a0d262b1f3"] = "Editar Posicion de Burbujas",
      ["e00aede412f4e0fa8adac1db28824008"] = "Desbloquea las burbujas en pantalla para poder arrastrarlas. Apaga esto para fijarlas y guardar su posicion.",
      ["aa5920a455bff5305f21430c2a5ca989"] = "Resetear Posicion de Burbujas",
      ["c40968cf77426597fc1002e19ba13c70"] = "Devuelve cada burbuja a su posicion predeterminada.",
      ["af644bdec3050256e4b089633ec7c1bb"] = "Fondo del Panel",
      ["e5a0ad311db35c09d2a8d31d61682588"] = "Activar Notificaciones",
      ["b06dde438a08f90c210d3de482271695"] = "Descargar Script",
      ["f05c53f426488e96cb51805e5ff6cca9"] = "Apaga todas las funciones, desengancha el script y saca la UI. Cerrar la ventana sola deja andando lo que tengas activo.",
      ["ad3272e69caac43330718b23d4955751"] = "Idioma",
      ["e19908b67b5b1a911c69e7e250136f05"] = "Apuntar al Jugador",
      ["c6401e2c5000958ba6cf1284224f7033"] = "Gira la camara hacia el enemigo visible mas cercano.",
      ["e528eff1f02a3cf87c3c4c72ed4d935c"] = "Tecla de Apuntar",
      ["dc814b083f1afdc4c7eb89e54f4b54c2"] = "Solo con arma de fuego",
      ["c3115e4b7e12defdd991a24770b1f2ad"] = "Solo con cuchillo en mano",
      ["b9a2b7f7c5dde9640074167ff8c74290"] = "Usar raycast",
      ["fab02cd9c966ed2772485f348952b37d"] = "Abrir editor de partes del cuerpo",
      ["b94bf0d66d694b714394f964262adc0f"] = "Elige las partes del cuerpo que usa Aim Mobile.",
      ["efb1b5c3c854c7ae166c10648e3a6901"] = "Triggerbot",
      ["da8a12d3b3bf5148980f746a147eec84"] = "Tecla de Triggerbot",
      ["e311dde60ce68fbdebaff476605de4f5"] = "Macro",
      ["aa2b3dd10e5280896abb08c2ad5d9a6e"] = "Tecla de Macro",
      ["c10a3756d8b0d11b72b4f7d5a35fafeb"] = "Silent Aim",
      ["a09fbfecc4939ad3f4c2dacb6f092ff0"] = "Redirige tus disparos al enemigo visible mas cercano al cursor.",
      ["fdd4d952584aa7289d9caa39706da583"] = "Tecla de Silent Aim",
      ["f603d87f683ddfe7e8e794c98a55a86e"] = "FOV",
      ["e53a42bc00372607cd31759543111ef9"] = "Solo fija enemigos dentro del circulo (alrededor del cursor en PC, el centro de la pantalla en mobile).",
      ["b06bb8f8eedbb99d7c9ba438324b0c6e"] = "FOV Visible",
      ["cbbbf53ca3a6245e7948906fdd94fc4d"] = "Dibuja el circulo del FOV en pantalla.",
      ["d15dff7b239795d01569811d5d3465a8"] = "Radio del FOV",
      ["cc0f01f735dbd74a02e45530aac64416"] = "Porcentaje de acierto",
      ["a436b9219e3de9a9b903b23ba1cd8bf6"] = "% de tus disparos que toman el Silent Aim y la Macro. Los demas no se tocan y van justo donde apuntaste. No afecta al Auto Shoot.",
      ["fc15d13bac5f83470ac97d1b4a0ad04e"] = "Burbuja Silent Aim",
      ["e5a210e23c31db476cf7851c616879fb"] = "Auto Shoot",
      ["c1c6c3f6eb15738a2d406de633e61a75"] = "Tecla de Auto Shoot",
      ["afb83060b4c8e1b3501f41f439bb366f"] = "Burbuja Auto Shoot",
      ["b8b6acb1ef3ec71564db220b83bee34e"] = "Matar a Todos los Enemigos",
      ["aedb3de438c31e73809d044271ca6f83"] = "Mantener Kill All Siempre Activo",
      ["d7a31c7a9773f67ced082a3ebce2278b"] = "Fuerza que Kill All quede activo y bloquea su toggle para que nada lo apague.",
      ["d769493da6cac80a80e345c26e3276e6"] = "Burbuja Kill All",
      ["a61d83f3d6f99e193d194ea9608a5d59"] = "Invisible",
      ["f2761e3cd59401fb77a07540758e4efb"] = "Burbuja Invisible",
      ["c7e7d88b539b76efc3e741e408422e42"] = "Desync",
      ["e1cb9fca42e476daca64fe5bd94b7f5d"] = "Burbuja Desync",
      ["db13ef6667ab0f152d5660909506238a"] = "Baneable",
      ["fba977a40b22b988e9dded1417cad3a5"] = "Floating Floor",
      ["d1345f0cda656de47d5e6474b9f08d8a"] = "Ocultar Mapa",
      ["ebefa948038ac07ea78172a3c8133ebf"] = "Activar Potencia de Salto",
      ["a5583643fe7eb46f11b783b7abd23751"] = "Potencia de Salto",
      ["b5763258a150e11677fab2ce65d43228"] = "Activar Salto Infinito",
      ["d16d4182c7d070152d2c44dee9267832"] = "Activar Velocidad",
      ["c4d9ce265bee45ab1a00d1d66b15c89f"] = "Velocidad",
      ["fb954fe1209e7e4af448a870ce9052d1"] = "Activar ESP",
      ["afb474e43c9abba8f2a424546978c7ae"] = "Muestra enemigos a través de paredes.",
      ["f8c12ba436a35d1990a8bc3c8e77944e"] = "Color del ESP",
      ["c5d2cdd263fd3634ef88b70defbc6bea"] = "Mostrar Nombre del Enemigo",
      ["e81d972ea3f11c21b37da930230b091c"] = "Lineas ESP",
      ["e60736bc519b7966e29628d36ef08187"] = "Dibuja lineas desde tu personaje hacia los enemigos.",
      ["e16764d65cf84aa798a554206d5be719"] = "Color de Lineas ESP",
      ["be9e408aec0c298c761ae8cdf9072f03"] = "Tecla de ESP",
      ["d5e0016ed741d5ce98b888aaa3d5807a"] = "Activar Hitbox",
      ["b153bf65ab7cda2aa2735a2f07547f13"] = "Muestra y agranda las hitboxes enemigas.",
      ["d1d20253ec2d3d00bc55958d04bf0377"] = "Color de Hitbox",
      ["b95e7c4d764ee540d887165836d439fa"] = "Opacidad de Hitbox",
      ["da30125c0dd7c41bf841a8681f4f5190"] = "Tamaño de Hitbox",
      ["f5fd069150c2314bfb00c744505dd4d3"] = "Mostrar Hitbox",
      ["f031f64fd927124f2749a994d2db2523"] = "Tecla de Hitbox",
      ["c2b092443cd7cf784af8fd5431ae53bd"] = "Farmeo de Evento",
      ["de6fb023e8fc7a8ab7675ccc3c640284"] = "Recolecta automáticamente los drops del evento. Solo en partidas.",
      ["a25316ff5856541049ba2a6e9d08b425"] = "Te teletransporta automáticamente a la zona seleccionada cuando no estás en partida.",
      ["ddd3ac562d6393093032e19d46508255"] = "Tipo de Duelo",
      ["d44bb4f6c0bb3f7089939029cbc816ca"] = "Fila de plataformas",
      ["a7ca395c40cc789197158e4a75cf2661"] = "Romper Racha",
      ["b8a78f6003d84bfeb95e6b0a4c8bb466"] = "Usa Main o Alt automáticamente según el Auto Teleport activo.",
      ["a91065ff20998adf9c1c8836c53fd7eb"] = "Objetivo de Racha",
      ["e31dda5e42067eacd1de46e6d1c3e6dd"] = "Bajar KD",
      ["e5d883e875425461f7d4877a65230048"] = "Usa Main o Alt automáticamente según el Auto Teleport activo.",
      ["ae1cddf7fd913336e01555ff8192b1b8"] = "Kills objetivo KD",
      ["d8f43decc8733fe46ef97509913f9f49"] = "Caja Seleccionada",
      ["d3a79b50f6ee54a51e87dd6d783ef946"] = "Elige qué caja comprar.",
      ["d057768612c13c7cec145ef544aaa0e9"] = "Comprar Caja",
      ["e6b0c75f7f453e79992e64f08b5c9756"] = "Compra la caja seleccionada si tienes efectivo suficiente.",
      ["cc6f88fdc0f140aada975b395249475c"] = "Compra Automática",
      ["d805b76f713b15d54843d142ca179701"] = "Compra automáticamente la caja seleccionada.",
    },
  },
})
G:Notify({ Title = "RysHub 🇦🇷", Content = "Loading GUI...", Duration = 4, Icon = "sparkles" })
local K = game:GetService("Players")
local L = game:GetService("RunService")
local M = game:GetService("UserInputService")
local N = game:GetService("ReplicatedStorage")
local O = game:GetService("Lighting")
local P = K.LocalPlayer
local function Q()
  local R, S = pcall(function()
    return M:GetPlatform()
  end)
  if R and (S == Enum.Platform.Android or S == Enum.Platform.IOS) then
    return true
  end
  return M.TouchEnabled and not M.KeyboardEnabled
end
local T = Q()
function c1()
  if T then
    local U = workspace.CurrentCamera
    return U and U.ViewportSize / 2 or Vector2.zero
  end
  return M:GetMouseLocation()
end
local V = { D7 = {}, Th = {}, Pd = {}, OH = false }
local W = { 8343463328 }
local X = { [8343463328] = true }
for Y, Z in ipairs(W) do
  X[Z] = true
end
local _ = false
local a0 = {}
function a0:vI(a1)
  if _ then
    return false
  end
  if not a1 then
    return false
  end
  local a2 = a1.UserId
  return X[a2] == true
end
local a3 = {}
a3.__index = a3
function a3.new()
  return setmetatable({ ay = {} }, a3)
end
function a3:id_d91afa(task)
  self.ay[#self.ay + 1] = task
  return task
end
function a3:id_e2a4c4()
  for a5 = #self.ay, 1, -1 do
    local a6 = self.ay[a5]
    self.ay[a5] = nil
    local a7 = typeof(a6)
    if a7 == "RBXScriptConnection" then
      pcall(function()
        a6:Disconnect()
      end)
    elseif a7 == "Instance" then
      pcall(function()
        a6:Destroy()
      end)
    elseif a7 == "function" then
      pcall(a6)
    end
  end
end
local a8 = {
  id_db8efe = {
    id_a04ad4 = false,
    Language = "English",
  },
  id_b2d046 = {
    Enabled = false,
    id_a9e7ee = false,
    id_de5c26 = false,
    Color = Color3.fromRGB(0, 421 - 166, 0),
    id_d6b5ab = Color3.fromRGB(0, 255, 0),
  },
  id_e1110a = {
    Enabled = false,
    Size = 4,
    Show = true,
    id_aab82c = 5.5,
    Color = Color3.fromRGB(272 - 17, 0, 0),
  },
  id_a627a2 = {
    id_b8cf17 = false,
    id_b739bd = false,
    id_cc0919 = false,
    id_e32658 = false,
    id_b2f78b = false,
  },
  id_c2960b = {
    id_fa7ccf = false,
    id_f4716b = 25,
    id_d21688 = false,
    id_d05c51 = false,
    id_ba7ec6 = 24,
  },
  id_db7d1a = {
    id_eac970 = false,
    id_a0792b = false,
    id_a82937 = "1v1",
    id_a5d67b = "Right Platforms",
    id_f5ec1a = false,
    id_fa0986 = 1,
    id_aaf372 = false,
    id_f39539 = 4,
    id_c40070 = false,
  },
  id_c1632a = {
    id_e1993c = false,
    id_c41ca6 = false,
    id_f25bb1 = false,
    id_b385e1 = false,
    id_a00ab8 = true,
    id_f7ca6b = false,
    id_b6ad50 = true,
    id_f0abef = true,
    id_f507e2 = {},
    id_fda17e = false,
    id_b0732d = false,
    id_df8e49 = false,
    id_d741b8 = false,
    id_b7ba43 = false,
    id_e82f73 = true,
    id_f2d9c0 = 200,
    id_f28945 = 100,
  },
  id_eb081e = {
    Selected = "Knife Box #1",
    id_aad55a = 500,
    id_aaf026 = false,
  },
  id_d20c9a = {
    Enabled = false,
    id_bac88e = false,
    id_fb990f = 0,
  },
  id_e4985c = {
    id_bbbf32 = false,
  },
  id_f749bd = {
    id_b965cd = "RightControl",
    id_b2d046 = "",
    id_e1110a = "",
    id_b385e1 = "",
    id_fda17e = "",
    id_b0732d = "",
    id_df8e49 = "",
    id_d741b8 = "",
  },
}
local a9 = {
  en = {
    id_cd7fc6 = "Could not open the confirmation popup.",
    id_efdbbd = "Cancel",
    id_fefe73 = "Continue",
    id_d1ef65 = "Confirm Script",
    id_dc9a82 = "You are about to run %s.\n\nDo you want to continue?",
    id_e78f80 = "Unload RysHub",
    id_a5c3a6 = "Every active feature will be switched off and the UI removed.\n\nDo you want to continue?",
    id_a930a6 = "Could not unload the script.",
    id_a66c27 = "Locked by Always On",
    id_b7a855 = "Script launched.",
    id_ee4856 = "Could not run the script.",
    id_c2849a = "Language",
    id_fcd3a1 = "Language changed to %s.",
    id_c10dbc = "External Scripts",
    id_e9c271 = "EMOTES",
    id_b9e052 = "Opens the external emotes menu.",
    id_e7d11c = "Auto Execute Emotes",
    id_bb8ad7 = "Runs Emotes automatically after startup.",
    id_c4f2a0 = "COPY SCRIPT",
  },
  es = {
    id_cd7fc6 = "No se pudo abrir la confirmación.",
    id_efdbbd = "Cancelar",
    id_fefe73 = "Continuar",
    id_d1ef65 = "Confirmar script",
    id_dc9a82 = "Vas a ejecutar %s.\n\n¿Querés continuar?",
    id_e78f80 = "Descargar RysHub",
    id_a5c3a6 = "Se van a apagar todas las funciones activas y se saca la UI.\n\n¿Querés continuar?",
    id_a930a6 = "No se pudo descargar el script.",
    id_a66c27 = "Bloqueado por Siempre Activo",
    id_b7a855 = "Script ejecutado.",
    id_ee4856 = "No se pudo ejecutar el script.",
    id_c2849a = "Idioma",
    id_c10dbc = "Scripts Externos",
    id_e9c271 = "EMOTES",
    id_b9e052 = "Abre el menu externo de emotes.",
    id_e7d11c = "Auto Ejecutar Emotes",
    id_bb8ad7 = "Ejecuta Emotes automaticamente al iniciar.",
    id_c4f2a0 = "COPIAR SCRIPT",
    id_fcd3a1 = "Idioma cambiado a %s.",
  },
}
local function aa(ab)
  local ac = tostring(ab or "")
  if ac == "es" or ac == "Espanol" or ac == "Español" or ac == "Spanish" then
    return "Espanol", "es"
  end
  return "English", "en"
end
local function ad()
  local ae = aa(a8 and a8.id_db8efe and a8.id_db8efe.Language)
  return ae
end
local function af()
  local Y, ag = aa(a8 and a8.id_db8efe and a8.id_db8efe.Language)
  return ag
end
local function ah(ab)
  local ae = aa(ab)
  a8.id_db8efe.Language = ae
  return ae
end
local function ai(aj, ...)
  local ak = af()
  local al = a9[ak] and a9[ak][aj] or nil
  local am = a9.en[aj] or aj
  local an = al or am
  if select("#", ...) > 0 then
    return string.format(an, ...)
  end
  return an
end
local function ao()
  local ap = ad()
  pcall(function()
    G:SetLanguage(ap)
  end)
  return ap
end
local function aq(ab, am)
  if typeof(ab) == "Color3" then
    return ab
  end
  if typeof(ab) == "BrickColor" then
    return ab.Color
  end
  if type(ab) == "table" then
    local ar = ab.R or ab.r or ab.Red or ab.red or ab[1]
    local as = ab.G or ab.g or ab.Green or ab.green or ab[2]
    local at = ab.B or ab.b or ab.Blue or ab.blue or ab[3]
    if type(ar) == "number" and type(as) == "number" and type(at) == "number" then
      if ar > 1 or as > 1 or at > 1 then
        return Color3.fromRGB(math.clamp(ar, 0, 255), math.clamp(as, 0, 255), math.clamp(at, 0, 51 * 5))
      end
      return Color3.new(math.clamp(ar, 0, 1), math.clamp(as, 0, 1), math.clamp(at, 0, 1))
    end
  end
  return am
end
local au
local av = { id_a79299 = false }
local function ax(ay, ab)
  if ab == nil then
    return
  end
  av.id_a79299 = true
  pcall(function()
    ay:Set(ab)
  end)
  av.id_a79299 = false
end
function V.Z4(az)
  if not az or not az.Parent then
    return
  end
  local aA = az:FindFirstChildOfClass("UIStroke")
  if not aA then
    return
  end
  if V.OH then
    aA.Color = Color3.fromRGB(79, 13 + 182, 247)
    aA.Thickness = 2
  else
    aA.Color = Color3.fromRGB(115, 134 - 19, 193 - 78)
    aA.Thickness = 1
  end
end
function V.P_()
  for Y, az in pairs(V.Pd) do
    V.Z4(az)
  end
end
local function aC(az, aD)
  local aE = az:FindFirstChildOfClass("UICorner")
  if aE then
    aE.CornerRadius = UDim.new(1, 0)
  end
  local aF = 6
  local aG = false
  local aH = false
  local aI = nil
  local aJ = nil
  local aK = (az.Parent and az.Parent.Name or "QuickButton") .. "/" .. (az.Name or "Button")
  V.Th[aK] = az.Position
  local aL = V.D7[aK]
  if aL then
    az.Position = aL
  end
  V.Pd[aK] = az
  if V.OH then
    V.Z4(az)
  end
  local function aM(aN)
    return aN.UserInputType == Enum.UserInputType.MouseButton1 or aN.UserInputType == Enum.UserInputType.Touch
  end
  az.InputBegan:Connect(function(aN)
    if not aM(aN) then
      return
    end
    aH = false
    if not V.OH then
      return
    end
    aG = true
    aI = aN.Position
    aJ = az.Position
  end)
  local aO = M.InputChanged:Connect(function(aN)
    if not V.OH or not aG or not aI then
      return
    end
    local a6 = aN.UserInputType
    if a6 ~= Enum.UserInputType.Touch and a6 ~= Enum.UserInputType.MouseMovement then
      return
    end
    local aP = aN.Position - aI
    if not aH and aP.Magnitude > aF then
      aH = true
    end
    if not aH then
      return
    end
    local aQ = UDim2.new(aJ.X.Scale, aJ.X.Offset + aP.X, aJ.Y.Scale, aJ.Y.Offset + aP.Y)
    az.Position = aQ
    V.D7[aK] = aQ
  end)
  local aR = M.InputEnded:Connect(function(aN)
    if aM(aN) then
      aG = false
    end
  end)
  az.Destroying:Connect(function()
    if aO then
      aO:Disconnect()
    end
    if aR then
      aR:Disconnect()
    end
    if V.Pd[aK] == az then
      V.Pd[aK] = nil
    end
  end)
  az.Activated:Connect(function()
    if V.OH then
      return
    end
    if aH then
      return
    end
    aD()
  end)
end
local function aS(aT, aU)
  aU = aU or aT
  local aG = false
  local aI = nil
  local aJ = nil
  local function aM(aN)
    return aN.UserInputType == Enum.UserInputType.MouseButton1 or aN.UserInputType == Enum.UserInputType.Touch
  end
  aU.InputBegan:Connect(function(aN)
    if not aM(aN) then
      return
    end
    aG = true
    aI = aN.Position
    aJ = aT.Position
  end)
  local aO = M.InputChanged:Connect(function(aN)
    if not aG or not aI or not aJ then
      return
    end
    local a6 = aN.UserInputType
    if a6 ~= Enum.UserInputType.Touch and a6 ~= Enum.UserInputType.MouseMovement then
      return
    end
    local aP = aN.Position - aI
    aT.Position = UDim2.new(aJ.X.Scale, aJ.X.Offset + aP.X, aJ.Y.Scale, aJ.Y.Offset + aP.Y)
  end)
  local aR = M.InputEnded:Connect(function(aN)
    if aM(aN) then
      aG = false
    end
  end)
  aT.Destroying:Connect(function()
    if aO then
      aO:Disconnect()
    end
    if aR then
      aR:Disconnect()
    end
  end)
end
local function aV(aW, aX)
  if not aW then
    return false
  end
  local ab = aW:GetAttribute(aX)
  return typeof(ab) == "string" and ab ~= ""
end
local function aY(a1)
  return aV(a1, "Game")
end
local function aZ(a1)
  return aY(a1) and aV(a1, "Map")
end
local function a_(b0, b1, b2)
  if not b0 then
    return nil
  end
  b2 = b2 or 2
  local R, b3 = pcall(function()
    return b0:WaitForChild(b1, b2)
  end)
  if R then
    return b3
  end
  return nil
end
local function b4(b2)
  return N:FindFirstChild("Remotes") or a_(N, "Remotes", b2 or 2)
end
local function b5(b6, b2)
  local b7 = N:FindFirstChild("Packages") or a_(N, "Packages", math.min(tonumber(b2) or 2, 0.5))
  local b8 = b7 and (b7:FindFirstChild("Networking") or a_(b7, "Networking", math.min(tonumber(b2) or 2, 0.5)))
  if b8 then
    local b9 = {
      id_eb8082 = "RE/Match/SetStatePlr",
      id_b17274 = "RE/Combat/KnifeKill",
      id_d8edcc = "RE/Events/CollectEventSpawnable",
    }
    local ba = b9[b6]
    if ba then
      local bb = b8:FindFirstChild(ba) or a_(b8, ba, math.min(tonumber(b2) or 2, 0.5))
      if bb then
        return bb
      end
    end
  end
  local bc = b4(b2)
  local bd = bc and (bc:FindFirstChild(b6) or a_(bc, b6, b2 or 2))
  if bd then
    return bd
  end
  return N:FindFirstChild(b6) or a_(N, b6, b2 or 2)
end
local function be(a1)
  local bf = a1.Character
  if not bf then
    return nil
  end
  local bg = bf:FindFirstChild("HumanoidRootPart")
  if bg and bg:IsA("BasePart") then
    return bg
  end
  return nil
end
local function bh(a1)
  local bf = a1.Character
  return bf and bf:FindFirstChildOfClass("Humanoid") or nil
end
local bi = {}
bi.__index = bi
function bi.new()
  return setmetatable({
    z3 = a3.new(),
    BJ = a3.new(),
    kx = nil,
    Qz = { id_ee87eb = {} },
    L_ = 0,
    Kg = 1,
    mB = false,
  }, bi)
end
function bi:Yy(aX)
  local ab = P:GetAttribute(aX)
  return typeof(ab) == "string" and ab ~= "" and ab or nil
end
function bi:c0()
  local bj = self:Yy("Game")
  local bk = self:Yy("Map")
  local bl = be(P)
  local bm = P.Character
  local bn = bm and bm:FindFirstChildOfClass("Humanoid")
  local bo = bn ~= nil and bn.Health > 0 and bl ~= nil
  return {
    id_af8690 = bj,
    id_aa3a58 = bk,
    id_a78b0a = bj and bk and ("%s:%s"):format(bj, bk) or nil,
    id_f52ad0 = bj ~= nil,
    id_c72e2e = bj ~= nil and bk ~= nil,
    id_a3aa92 = bo,
    id_e265ce = bl,
    id_c22831 = bm,
    id_c68069 = bn,
  }
end
function bi:RQ(bp, bq, br)
  local bs = self.Qz[bp]
  if not bs then
    return
  end
  for Y, bt in ipairs(table.clone(bs)) do
    pcall(bt, bq, br)
  end
end
function bi:kY()
  local br = self.kx
  local bq = self:c0()
  self.kx = bq
  if not br or br.id_a78b0a ~= bq.id_a78b0a then
    self:RQ("id_ee87eb", bq, br)
  end
  return bq
end
function bi:u5(bm)
  self.BJ:id_e2a4c4()
  if not bm then
    self:kY()
    return
  end
  local function bu(bn)
    if not bn then
      return
    end
    self.BJ:id_d91afa(bn.Died:Connect(function()
      self:kY()
    end))
    self.BJ:id_d91afa(bn:GetPropertyChangedSignal("Health"):Connect(function()
      self:kY()
    end))
  end
  bu(bm:FindFirstChildOfClass("Humanoid"))
  self.BJ:id_d91afa(bm.ChildAdded:Connect(function(bv)
    if bv:IsA("Humanoid") then
      bu(bv)
      self:kY()
    elseif bv.Name == "HumanoidRootPart" then
      self:kY()
    end
  end))
  self.BJ:id_d91afa(bm.ChildRemoved:Connect(function(bv)
    if bv:IsA("Humanoid") or bv.Name == "HumanoidRootPart" then
      self:kY()
    end
  end))
  self:kY()
end
function bi:id_e26235()
  return self.kx or self:kY()
end
function bi:id_a7a13d(bt)
  self.Qz.id_ee87eb[#self.Qz.id_ee87eb + 1] = bt
  return function()
    local bs = self.Qz.id_ee87eb
    for a5 = #bs, 1, -1 do
      if bs[a5] == bt then
        table.remove(bs, a5)
        break
      end
    end
  end
end
function bi:Start()
  if self.mB then
    return
  end
  self.mB = true
  self:u5(P.Character)
  self.z3:id_d91afa(P.CharacterAdded:Connect(function(bm)
    self:u5(bm)
  end))
  self.z3:id_d91afa(P:GetAttributeChangedSignal("Game"):Connect(function()
    self:kY()
  end))
  self.z3:id_d91afa(P:GetAttributeChangedSignal("Map"):Connect(function()
    self:kY()
  end))
  self.z3:id_d91afa(L.Heartbeat:Connect(function(bw)
    self.L_ = self.L_ + bw
    if self.L_ >= self.Kg then
      self.L_ = 0
      self:kY()
    end
  end))
end
function bi:Stop()
  if not self.mB then
    return
  end
  self.mB = false
  self.z3:id_e2a4c4()
  self.BJ:id_e2a4c4()
  self.Qz.id_ee87eb = {}
  self.kx = nil
end
local bx = bi.new()
bx:Start()
local by
local function bz()
  local as = rawget(_G, "Drawing")
  if as and type(as.new) == "function" then
    return as
  end
  if type(getgenv) == "function" then
    local bA = getgenv()
    local bB = bA and bA.Drawing
    if bB and type(bB.new) == "function" then
      return bB
    end
  end
  if type(getfenv) == "function" then
    local bC = getfenv(0)
    local bB = bC and bC.Drawing
    if bB and type(bB.new) == "function" then
      return bB
    end
  end
  return nil
end
local function bD(bE, bF, bG, bH)
  if a8.id_db8efe.id_a04ad4 then
    G:Notify({ Title = bE, Content = bF, Duration = bH or 3, Icon = bG or "info" })
  end
end
local function bI(bJ, bK)
  local bL = ai("id_d1ef65")
  local bM = ai("id_dc9a82", bJ)
  if not G or type(G.Popup) ~= "function" then
    bD(bL, ai("id_cd7fc6"), "alert-triangle", 4)
    return
  end
  local bN = pcall(function()
    G:Popup({
      Title = bL,
      Icon = "info",
      Content = bM,
      Buttons = {
        { Title = ai("id_efdbbd"), Variant = "Tertiary" },
        {
          Title = ai("id_fefe73"),
          Icon = "arrow-right",
          Variant = "Primary",
          Callback = function()
            task.spawn(function()
              local R, bO = pcall(function()
                if type(loadstring) ~= "function" then
                  error("loadstring unavailable")
                end
                local bP = game:HttpGet(bK)
                local bQ = loadstring(bP)
                if type(bQ) ~= "function" then
                  error("invalid script chunk")
                end
                bQ()
              end)
              if R then
                bD(bJ, ai("id_b7a855"), "check", 3)
              else
                bD(bJ, ai("id_ee4856") .. " " .. tostring(bO), "alert-triangle", 4)
              end
            end)
          end,
        },
      },
    })
  end)
  if not bN then
    bD(bL, ai("id_cd7fc6"), "alert-triangle", 4)
  end
end
function uZ(bJ, bK)
  task.spawn(function()
    local R, bO = pcall(function()
      if type(loadstring) ~= "function" then
        error("loadstring unavailable")
      end
      local bP = game:HttpGet(bK)
      local bQ = loadstring(bP)
      if type(bQ) ~= "function" then
        error("invalid script chunk")
      end
      bQ()
    end)
    if not R then
      bD(bJ, ai("id_ee4856") .. " " .. tostring(bO), "alert-triangle", 4)
    end
  end)
end
local function bR(bJ, bS)
  if type(setclipboard) ~= "function" then
    local bU = af() == "es" and "No se pudo copiar el script." or "Could not copy the script."
    bD(bJ, bU, "alert-triangle", 4)
    return
  end
  local R, bO = pcall(function()
    setclipboard(bS)
  end)
  if R then
    local bV = af() == "es" and "Script copiado al portapapeles." or "Script copied to clipboard."
    bD(bJ, bV, "copy", 3)
  else
    local bW = af() == "es" and "No se pudo copiar el script." or "Could not copy the script."
    bD(bJ, bW .. " " .. tostring(bO), "alert-triangle", 4)
  end
end
local bX = {}
bX.__index = bX
local bY = { id_a92eaa = nil }
function bX.new()
  return setmetatable({ id_eefb95 = false, z3 = a3.new(), vy = 0 }, bX)
end
function bX:Lu()
  local bZ = workspace:FindFirstChild("Leaderboards")
  if not bZ then
    return nil
  end
  local b_ = bZ:FindFirstChild("streak")
  if not b_ then
    return nil
  end
  local c0 = b_:FindFirstChild("ScreenPart")
  if not c0 then
    return nil
  end
  local c2 = c0:FindFirstChild("SurfaceGui")
  if not c2 then
    return nil
  end
  return c2:FindFirstChild("Frame")
end
function bX:Ht(c3)
  if not c3 then
    return nil
  end
  for Y, bv in ipairs(c3:GetChildren()) do
    if bv:IsA("Frame") and bv.LayoutOrder == 50 then
      return bv
    end
  end
  return nil
end
function bX:us(c4)
  local c5 = nil
  if c4 then
    local c6 = c4:FindFirstChild("Wins")
    if c6 then
      if c6:IsA("NumberValue") or c6:IsA("IntValue") then
        c5 = tonumber(c6.Value)
      elseif c6:IsA("TextLabel") or c6:IsA("TextButton") or c6:IsA("TextBox") then
        local c7 = tostring(c6.Text or "")
        local c8 = tonumber(c7)
        if c8 then
          c5 = c8
        else
          local c9 = string.match(c7, "%d+")
          c5 = c9 and tonumber(c9) or nil
        end
      end
    end
  end
  bY.id_a92eaa = c5
end
function bX:tO(bw)
  self.vy = self.vy + bw
  if self.vy < 0.5 then
    return
  end
  self.vy = 0
  local c3 = self:Lu()
  local cb = self:Ht(c3)
  self:us(cb)
end
function bX:id_c6a804()
  if self.id_eefb95 then
    return
  end
  self.id_eefb95 = true
  self.vy = 0
  self.z3:id_d91afa(L.Heartbeat:Connect(function(bw)
    if not self.id_eefb95 then
      return
    end
    self:tO(bw)
  end))
end
function bX:id_d7eac1()
  if not self.id_eefb95 then
    return
  end
  self.id_eefb95 = false
  self.vy = 0
  bY.id_a92eaa = nil
  self.z3:id_e2a4c4()
end
by = {}
function by:mk(a1)
  if a1 == P then
    return false
  end
  if not aZ(P) or not aZ(a1) then
    return false
  end
  local cc = P:GetAttribute("Game")
  local cd = a1:GetAttribute("Game")
  if cc ~= cd then
    return false
  end
  local ce = P:GetAttribute("Map")
  local cf = a1:GetAttribute("Map")
  if ce ~= cf then
    return false
  end
  local cg = P:GetAttribute("Team")
  local ch = a1:GetAttribute("Team")
  if typeof(cg) ~= "string" or cg == "" then
    return false
  end
  if typeof(ch) ~= "string" or ch == "" then
    return false
  end
  return cg ~= ch
end
local function ci(a1)
  if not by:mk(a1) then
    return false
  end
  if a0:vI(a1) then
    return false
  end
  return true
end
MS = {}
MS.__index = MS
local cj = 1
local ck = 90
local cl = 0.5
function MS.new()
  return setmetatable({ id_eefb95 = false, z3 = a3.new(), uO = {}, WT = 0 }, MS)
end
function MS:aR()
  local bf = P.Character
  if not bf then
    return
  end
  for Y, cm in ipairs(bf:GetDescendants()) do
    if cm:IsA("BasePart") and cm.CanCollide then
      if self.uO[cm] == nil then
        self.uO[cm] = cm.CanCollide
      end
      cm.CanCollide = false
    end
  end
end
function MS:ns()
  for cm, cn in pairs(self.uO) do
    if cm.Parent then
      pcall(function()
        cm.CanCollide = cn
      end)
    end
  end
  table.clear(self.uO)
end
function MS:Mn()
  local co = be(P)
  if not co then
    return nil
  end
  local cp, cq
  for Y, a1 in ipairs(K:GetPlayers()) do
    if ci(a1) then
      local bn = bh(a1)
      local bl = be(a1)
      if bl and bn and bn.Health > 0 then
        local cr = (bl.Position - co.Position).Magnitude
        if not cq or cr < cq then
          cp, cq = bl, cr
        end
      end
    end
  end
  return cp
end
function MS:qh(bl)
  local bn = bl.Parent and bl.Parent:FindFirstChildOfClass("Humanoid")
  local cs = bn and tonumber(bn.HipHeight) or 2
  return bl.Position.Y - cs - bl.Size.Y / 2
end
function MS:Mu()
  local ct = P:FindFirstChild("PlayerGui")
  local cu = ct and ct:FindFirstChild("Main") or ct
  local cv = cu and cu:FindFirstChild("MainGameFrame")
  local cw = cv and cv:FindFirstChild("IngameScore")
  local cx = cw and cw:FindFirstChild("Timer")
  if not cx or not (cx:IsA("TextLabel") or cx:IsA("TextButton") or cx:IsA("TextBox")) then
    return false
  end
  return tostring(cx.Text or ""):match("^%s*%d+:%d%d%s*$") ~= nil
end
function MS:t4()
  self.PJ = nil
  self.rf = nil
  self.ph = false
  self:ns()
  local bn = bh(P)
  if bn and bn.PlatformStand then
    pcall(function()
      bn.PlatformStand = false
    end)
  end
end
function MS:My(cy)
  if not (cy and cy:IsA("Tool")) then
    return false
  end
  if cy:FindFirstChild("fire") or cy:FindFirstChild("showBeam") then
    return false
  end
  return cy:FindFirstChild("Slash") ~= nil or cy:FindFirstChild("SlashStart") ~= nil
end
function MS:h3()
  local bf = P.Character
  if bf then
    for Y, bv in ipairs(bf:GetChildren()) do
      if self:My(bv) then
        return bv, true
      end
    end
  end
  local cz = P:FindFirstChildOfClass("Backpack")
  if cz then
    for Y, bv in ipairs(cz:GetChildren()) do
      if self:My(bv) then
        return bv, false
      end
    end
  end
  return nil, false
end
function MS:ji(bw)
  self.WT = (self.WT or 0) + bw
  if self.WT < cl then
    return
  end
  self.WT = 0
  local cA, cB = self:h3()
  if not cA then
    return
  end
  if not cB then
    local bn = bh(P)
    if not bn then
      return
    end
    pcall(function()
      bn:EquipTool(cA)
    end)
    if cA.Parent ~= P.Character then
      return
    end
  end
  pcall(function()
    cA:Activate()
  end)
end
function MS:KL()
  if a8.id_db7d1a.id_eac970 then
    return "Main"
  end
  if a8.id_db7d1a.id_a0792b then
    return "Alt"
  end
  return nil
end
function MS:fO(ab)
  if ab == nil then
    return nil
  end
  local c7 = tostring(ab)
  return tonumber(c7) or tonumber(string.match(c7, "%d+") or "")
end
function MS:Dn()
  local ct = P:FindFirstChild("PlayerGui")
  local cu = ct and ct:FindFirstChild("Main")
  local cv = cu and cu:FindFirstChild("MainGameFrame")
  local cC = cv and cv:FindFirstChild("PlayersFrame")
  if not cC then
    return nil, nil
  end
  local cD = cC:FindFirstChild("TeamBlueScoreFrame")
  local cE = cC:FindFirstChild("TeamRedScoreFrame")
  local cF = cD and cD:FindFirstChild("ScoreText")
  local cG = cE and cE:FindFirstChild("ScoreText")
  if not (cF and cG) then
    return nil, nil
  end
  local cH = self:fO(cF.Text)
  local cI = self:fO(cG.Text)
  if P:GetAttribute("Team") == "Red" then
    return cI, cH
  end
  return cH, cI
end
function MS:kM(a1)
  if not a1 then
    return nil
  end
  local cJ = tonumber(a1:GetAttribute("RoundKills"))
  if cJ then
    return cJ
  end
  local cK = a1:FindFirstChild("RoundKills")
  if cK and (cK:IsA("IntValue") or cK:IsA("NumberValue")) then
    return tonumber(cK.Value) or 0
  end
  local cL = a1:FindFirstChild("leaderstats")
  local cM = cL and cL:FindFirstChild("RoundKills")
  if cM and (cM:IsA("IntValue") or cM:IsA("NumberValue")) then
    return tonumber(cM.Value) or 0
  end
  return nil
end
function MS:hP(a1)
  local cN = a1 and a1:FindFirstChild("Streak")
  if cN and (cN:IsA("IntValue") or cN:IsA("NumberValue")) then
    return tonumber(cN.Value)
  end
  local bl = a1 and be(a1)
  local cO = bl and bl:FindFirstChild("HeadTag")
  local b_ = cO and cO:FindFirstChild("Streak")
  local cP = b_ and b_:FindFirstChild("TextLabel")
  if not cP then
    return nil
  end
  return tonumber(tostring(cP.Text or ""):gsub("[^%d%-]", ""))
end
function MS:ho()
  if not a8.id_db7d1a.id_f5ec1a then
    return true
  end
  local cQ = math.floor(tonumber(a8.id_db7d1a.id_fa0986) or 0)
  if cQ <= 0 then
    local cR = tonumber(bY.id_a92eaa)
    if not cR then
      return false
    end
    cQ = math.max(0, cR - 1)
  end
  for Y, a1 in ipairs(K:GetPlayers()) do
    if ci(a1) then
      local b_ = self:hP(a1)
      if b_ and b_ >= cQ then
        return true
      end
    end
  end
  return false
end
function MS:Y8(cS)
  if not a8.id_db7d1a.id_aaf372 then
    return true
  end
  local cQ = math.clamp(math.floor(tonumber(a8.id_db7d1a.id_f39539) or 4), 0, 4)
  local cT, cU = self:Dn()
  if cS == "Alt" then
    local cV = self:kM(P)
    return (cV or cT or 0) < cQ
  end
  if cU then
    return cU >= cQ
  end
  for Y, a1 in ipairs(K:GetPlayers()) do
    local cW = ci(a1) and self:kM(a1) or nil
    if cW and cW >= cQ then
      return true
    end
  end
  return false
end
function MS:sv()
  local cS = self:KL()
  if not cS then
    return true
  end
  return self:ho() and self:Y8(cS)
end
function MS:tO(bw)
  if not self:Mu() then
    self:t4()
    return
  end
  if not self:sv() then
    self:t4()
    return
  end
  local co = be(P)
  local cX = co and self:Mn()
  if not cX then
    self:t4()
    return
  end
  self:aR()
  self:ji(bw or 0)
  local bn = bh(P)
  if bn and not bn.PlatformStand then
    pcall(function()
      bn.PlatformStand = true
    end)
  end
  local cY = cX.Position
  local cZ = cX.Parent and cX.Parent:FindFirstChildOfClass("Humanoid")
  local c_ = cZ and cZ.FloorMaterial ~= Enum.Material.Air
  if cX ~= self.rf then
    self.rf = cX
    self.PJ = nil
    self.ph = false
  end
  if c_ or not self.PJ then
    self.PJ = self:qh(cX)
  end
  local d0 = self.PJ - cj
  local d1 = co.Position
  local d2, d3 = cY.X, cY.Z
  if not self.ph then
    if math.abs(d1.Y - d0) > 1 then
      d2, d3 = d1.X, d1.Z
    else
      self.ph = true
    end
  end
  pcall(function()
    co.CFrame = CFrame.new(d2, d0, d3) * CFrame.Angles(math.rad(ck), 0, 0)
    co.AssemblyLinearVelocity = Vector3.zero
    co.AssemblyAngularVelocity = Vector3.zero
  end)
end
function MS:id_c6a804()
  if self.id_eefb95 then
    return
  end
  self.id_eefb95 = true
  self.WT = 0
  self.z3:id_d91afa(L.Heartbeat:Connect(function(bw)
    if not self.id_eefb95 then
      return
    end
    self:tO(bw)
  end))
  self.z3:id_d91afa(P.CharacterAdded:Connect(function()
    table.clear(self.uO)
  end))
end
function MS:id_d7eac1()
  if not self.id_eefb95 then
    return
  end
  self.id_eefb95 = false
  self.z3:id_e2a4c4()
  self:t4()
end
WV = MS.new()
ca = {}
ca.__index = ca
local d4 = 400
local d5 = 0.6
function ca.new()
  return setmetatable({ id_eefb95 = false, z3 = a3.new(), z4 = nil, JO = nil }, ca)
end
function ca:J2(d6)
  for Y, cm in ipairs(d6:GetDescendants()) do
    if cm:IsA("BasePart") then
      pcall(function()
        cm.Transparency = math.max(cm.Transparency, d5)
      end)
    elseif cm:IsA("Decal") or cm:IsA("Texture") then
      pcall(function()
        cm.Transparency = d5
      end)
    end
  end
end
function ca:bE(d6)
  for Y, bv in ipairs(d6:GetChildren()) do
    if bv:IsA("Tool") then
      pcall(function()
        bv:Destroy()
      end)
    end
  end
end
function ca:UZ(d7, d8)
  if not (d7 and d8) then
    return
  end
  for Y, bv in ipairs(d7:GetChildren()) do
    if bv:IsA("Tool") then
      pcall(function()
        bv.Parent = d8
      end)
    end
  end
end
function ca:lM()
  local U = workspace.CurrentCamera
  if not U then
    return function() end
  end
  local d9 = U.CFrame
  local da = U.Focus
  return function()
    local db = 0
    local dc
    dc = L.RenderStepped:Connect(function()
      local dd = workspace.CurrentCamera
      if dd then
        dd.CFrame = d9
        dd.Focus = da
      end
      db = db + 1
      if db >= 3 then
        dc:Disconnect()
      end
    end)
  end
end
function ca:id_c6a804()
  if self.id_eefb95 then
    return
  end
  local de = P.Character
  local df = be(P)
  if not (de and df) then
    return
  end
  local dg = df.CFrame
  local R, d6 = pcall(function()
    de.Archivable = true
    local dh = de:Clone()
    dh.Name = P.Name .. "d55076dde45f5d1c5267"
    dh.Parent = workspace
    dh:PivotTo(dg)
    return dh
  end)
  if not R or not d6 then
    return
  end
  self.id_eefb95 = true
  self.z4 = de
  self.JO = d6
  self:bE(d6)
  self:J2(d6)
  local di = self:lM()
  pcall(function()
    P.Character = d6
  end)
  pcall(function()
    local dj = d6:FindFirstChildOfClass("Humanoid")
    if dj then
      workspace.CurrentCamera.CameraSubject = dj
    end
  end)
  di()
  local dk = dg + Vector3.new(0, d4, 0)
  self.bP = dk
  pcall(function()
    df.Anchored = false
    df.CFrame = dk
  end)
  self.z3:id_d91afa(L.Heartbeat:Connect(function()
    if not self.id_eefb95 or not df.Parent then
      return
    end
    pcall(function()
      df.CFrame = dk
      df.AssemblyLinearVelocity = Vector3.zero
      df.AssemblyAngularVelocity = Vector3.zero
    end)
  end))
  self.z3:id_d91afa(P.CharacterAdded:Connect(function()
    task.defer(function()
      self:id_d7eac1()
      a8.id_c1632a.id_c41ca6 = false
      if w6 then
        ax(w6, false)
      end
      if MJ then
        MJ()
      end
    end)
  end))
end
function ca:id_d7eac1()
  if not self.id_eefb95 then
    return
  end
  self.id_eefb95 = false
  self.z3:id_e2a4c4()
  local d6 = self.JO
  local de = self.z4
  self.JO = nil
  self.z4 = nil
  self.bP = nil
  local dl = nil
  if d6 then
    local R, dm = pcall(function()
      return d6:GetPivot()
    end)
    dl = R and dm or nil
  end
  if d6 then
    self:UZ(d6, P:FindFirstChildOfClass("Backpack"))
  end
  if de and de.Parent then
    local di = self:lM()
    pcall(function()
      P.Character = de
    end)
    local df = de:FindFirstChild("HumanoidRootPart")
    if df then
      pcall(function()
        if dl then
          df.CFrame = dl
        end
        df.Anchored = false
        df.AssemblyLinearVelocity = Vector3.zero
      end)
    end
    pcall(function()
      local bn = de:FindFirstChildOfClass("Humanoid")
      if bn then
        workspace.CurrentCamera.CameraSubject = bn
      end
    end)
    di()
  end
  if d6 then
    pcall(function()
      d6:Destroy()
    end)
  end
end
ir = ca.new()
vp = {}
vp.__index = vp
local dn = {
  id_b87f68 = 16,
  id_c2132f = 50,
  id_a0ab55 = 200,
}
function vp.new()
  return setmetatable({
    id_eefb95 = false,
    z3 = a3.new(),
    id_e265ce = nil,
    iD = nil,
    tF = nil,
    Ym = 0,
    Pb = true,
    nw = nil,
    Ez = nil,
  }, vp)
end
function vp:A3(dp)
  local dq = self.nw
  if not dq then
    dq = RaycastParams.new()
    dq.FilterType = Enum.RaycastFilterType.Exclude
    dq.IgnoreWater = true
    self.nw = dq
  end
  dq.FilterDescendantsInstances = { P.Character, self.tF }
  local dr = workspace:Raycast(dp, Vector3.new(0, -dn.id_a0ab55, 0), dq)
  return dr and dr.Position.Y or nil
end
function vp:b4(bm, bn)
  local R, ds = pcall(function()
    local dt = bn and bn:FindFirstChildOfClass("Animator")
    local du = bm and bm:FindFirstChild("Animate")
    local bS = du and (du:FindFirstChild("run") or du:FindFirstChild("walk"))
    local dv = bS and bS:FindFirstChildOfClass("Animation")
    if not (dt and dv) then
      return nil
    end
    local dw = dt:LoadAnimation(dv)
    dw.Priority = Enum.AnimationPriority.id_c2960b
    dw.Looped = true
    return dw
  end)
  if R then
    self.Ez = ds
  end
end
function vp:UW(dx)
  local ds = self.Ez
  if not ds then
    return
  end
  pcall(function()
    if dx and not ds.IsPlaying then
      ds:Play(0.1)
    elseif not dx and ds.IsPlaying then
      ds:Stop(0.1)
    end
  end)
end
function vp:xs(dp)
  local R, dy = pcall(function()
    local cm = Instance.new("Part")
    cm.Name = "a30e0d944694bc7577b7"
    cm.Size = Vector3.new(3, 6, 3)
    cm.Anchored = true
    cm.CanCollide = false
    cm.CanQuery = false
    cm.CanTouch = false
    cm.Transparency = 0.6
    cm.Color = Color3.fromRGB(2 + 253, 70, 70)
    cm.Material = Enum.Material.Neon
    cm.CFrame = CFrame.new(dp)
    cm.Parent = workspace
    local dz = Instance.new("BillboardGui")
    dz.Size = UDim2.fromOffset(70, 22)
    dz.StudsOffset = Vector3.new(0, 4, 0)
    dz.AlwaysOnTop = true
    dz.MaxDistance = 5000
    dz.Parent = cm
    local dA = Instance.new("TextLabel")
    dA.Size = UDim2.fromScale(1, 1)
    dA.BackgroundTransparency = 1
    dA.Font = Enum.Font.GothamBold
    dA.Text = "REAL"
    dA.TextColor3 = Color3.fromRGB(255, 120, 120)
    dA.TextSize = 14
    dA.Parent = dz
    return cm
  end)
  if R then
    self.tF = dy
  end
end
function vp:cr(bw)
  local bl = self.id_e265ce
  if not (bl and bl.Parent) then
    self:id_d7eac1()
    return
  end
  if not bl.Anchored then
    pcall(function()
      bl.Anchored = true
    end)
  end
  bw = bw or 0
  local bn = bh(P)
  local dB = bn and bn.MoveDirection or Vector3.zero
  local dx = dB.Magnitude > 0.01
  local dC = bn and tonumber(bn.WalkSpeed) or nil
  if not dC or dC <= 0 then
    dC = dn.id_b87f68
  end
  local dD = bl.CFrame
  local dp = dD.Position
  if dx then
    local dE = dp + dB * dC * bw
    dD = CFrame.lookAt(dE, dE + dB)
    dp = dD.Position
  end
  self.Ym = (self.Ym or 0) - workspace.Gravity * bw
  local d0 = dp.Y + self.Ym * bw
  local dF = self:A3(dp)
  local dG = dF and dF + (bn and bn.HipHeight or 2) + bl.Size.Y / 2 or nil
  if dG and d0 <= dG then
    d0 = dG
    self.Ym = 0
    self.Pb = true
  else
    self.Pb = false
  end
  dD = CFrame.new(dp.X, d0, dp.Z) * (dD - dD.Position)
  pcall(function()
    bl.CFrame = dD
  end)
  self:UW(dx and self.Pb)
end
function vp:id_c6a804()
  if self.id_eefb95 then
    return
  end
  local bl = be(P)
  if not bl then
    return
  end
  self.id_eefb95 = true
  self.id_e265ce = bl
  self.iD = bl.Position
  self.Ym = 0
  self.Pb = true
  pcall(function()
    bl.AssemblyLinearVelocity = Vector3.zero
    bl.AssemblyAngularVelocity = Vector3.zero
    bl.Anchored = true
  end)
  self:b4(P.Character, bh(P))
  self:xs(self.iD)
  self.z3:id_d91afa(L.RenderStepped:Connect(function(bw)
    if self.id_eefb95 then
      self:cr(bw)
    end
  end))
  self.z3:id_d91afa(M.JumpRequest:Connect(function()
    if not (self.id_eefb95 and self.Pb) then
      return
    end
    local bn = bh(P)
    local dH = dn.id_c2132f
    if bn then
      if bn.UseJumpPower then
        dH = tonumber(bn.JumpPower) or dH
      else
        dH = math.sqrt(2 * workspace.Gravity * (tonumber(bn.JumpHeight) or 7))
      end
    end
    self.Ym = dH
    self.Pb = false
  end))
  self.z3:id_d91afa(P.CharacterAdded:Connect(function()
    task.defer(function()
      self:id_d7eac1()
      a8.id_c1632a.id_f25bb1 = false
      if jr then
        ax(jr, false)
      end
      if IX then
        IX()
      end
    end)
  end))
end
function vp:id_d7eac1()
  if not self.id_eefb95 then
    return
  end
  self.id_eefb95 = false
  self.z3:id_e2a4c4()
  local bl = self.id_e265ce
  self.id_e265ce = nil
  self.iD = nil
  self.Ym = 0
  self.Pb = true
  if self.Ez then
    pcall(function()
      self.Ez:Stop(0.1)
      self.Ez:Destroy()
    end)
    self.Ez = nil
  end
  if bl and bl.Parent then
    pcall(function()
      bl.Anchored = false
      bl.AssemblyLinearVelocity = Vector3.zero
      bl.AssemblyAngularVelocity = Vector3.zero
    end)
  end
  if self.tF then
    pcall(function()
      self.tF:Destroy()
    end)
    self.tF = nil
  end
end
oj = vp.new()
local dI = bX.new()
dI:id_c6a804()
local dJ = {}
dJ.__index = dJ
local dK = "H_" .. tostring(math.random(100000, 999999))
local dL = 0.1
local dM = setmetatable({}, { __mode = "k" })
local function dN(dO, dP)
  local R, ab = pcall(function()
    return dO[dP]
  end)
  if R then
    return ab
  end
  return nil
end
local function dQ(a1)
  local bf = a1.Character
  if not bf then
    return nil
  end
  local bg = bf:FindFirstChild("HumanoidRootPart")
  if not bg or not bg:IsA("BasePart") then
    return nil
  end
  local dR = bg:FindFirstChild("HeadTag")
  if not dR then
    return nil
  end
  return dR
end
local function dS(dR)
  if not dR then
    return
  end
  if dM[dR] then
    return
  end
  dM[dR] = {
    Enabled = dN(dR, "Enabled"),
    id_c6a804 = dN(dR, "Enable"),
    MaxDistance = dN(dR, "MaxDistance"),
    Size = dN(dR, "Size"),
  }
end
local function dT(dR)
  local dU = dR and dM[dR]
  if not dR or not dU then
    return
  end
  pcall(function()
    dR.Enabled = dU.Enabled
  end)
  pcall(function()
    dR.id_c6a804 = dU.id_c6a804
  end)
  pcall(function()
    if dU.MaxDistance ~= nil then
      dR.MaxDistance = dU.MaxDistance
    end
  end)
  pcall(function()
    if dU.Size then
      dR.Size = dU.Size
    end
  end)
end
local function dV(a1, dW)
  local dR = dQ(a1)
  if not dR then
    return
  end
  dS(dR)
  if dW then
    pcall(function()
      dR.Enabled = true
    end)
    pcall(function()
      dR.id_c6a804 = true
    end)
  else
    dT(dR)
  end
  if dW and dR:IsA("BillboardGui") then
    pcall(function()
      dR.MaxDistance = 150 + 150
    end)
    pcall(function()
      dR.Size = UDim2.new(dR.Size.X.Scale, dR.Size.X.Offset, 3, 0)
    end)
  end
end
local function dX(a1)
  local bf = a1 and a1.Character
  if not bf then
    return false
  end
  local bn = bf:FindFirstChildOfClass("Humanoid")
  return bn and bn.Health > 0
end
function dJ:uT(a1)
  local dY = by:mk(a1)
  local dZ = false
  if self.id_eefb95 and dY then
    local d_ = self.kZ[a1]
    dZ = d_ ~= nil and d_.Parent ~= nil
  end
  local e0 = self.id_eefb95 and a8.id_b2d046.id_a9e7ee and dY and dZ and dX(a1)
  dV(a1, e0)
end
function dJ.new()
  return setmetatable({ id_eefb95 = false, z3 = a3.new(), v0 = {}, kZ = {}, Iz = nil }, dJ)
end
function dJ:gk()
  if type(gethui) == "function" then
    local R, e1 = pcall(gethui)
    if R and e1 then
      return e1
    end
  end
  local R, e2 = pcall(function()
    return game:GetService("CoreGui")
  end)
  if R and e2 then
    return e2
  end
  return P:FindFirstChild("PlayerGui")
end
function dJ:QG()
  if self.Iz and self.Iz.Parent then
    return self.Iz
  end
  local b0 = self:gk()
  if not b0 then
    return nil
  end
  local e3 = Instance.new("Folder")
  e3.Name = "F_" .. tostring(math.random(100000, 33 * 30303))
  e3.Parent = b0
  self.Iz = e3
  return e3
end
function dJ:zY(a1)
  local d_ = self.kZ[a1]
  self.kZ[a1] = nil
  if d_ then
    pcall(function()
      d_:Destroy()
    end)
  end
end
function dJ:LO()
  if self.Iz then
    pcall(function()
      self.Iz:Destroy()
    end)
    self.Iz = nil
  end
end
function dJ:v9(d_)
  local e4 = aq(a8.id_b2d046.Color, Color3.fromRGB(0, 255, 0))
  d_.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
  d_.FillColor = e4
  d_.OutlineColor = e4
  d_.FillTransparency = 1 - dL
  d_.OutlineTransparency = 0
end
function dJ:am(a1, e5)
  local bf = a1.Character
  if not e5 or not bf then
    self:zY(a1)
    return
  end
  local d_ = self.kZ[a1]
  if not d_ or not d_.Parent then
    local e3 = self:QG()
    if not e3 then
      return
    end
    d_ = Instance.new("Highlight")
    d_.Name = dK
    d_.Parent = e3
    self.kZ[a1] = d_
  end
  if d_.Adornee ~= bf then
    d_.Adornee = bf
  end
  self:v9(d_)
end
function dJ:Ya(a1)
  if not self.id_eefb95 then
    return
  end
  self:am(a1, by:mk(a1) and dX(a1))
  self:uT(a1)
end
function dJ:I1(a1)
  if self.v0[a1] then
    self.v0[a1]:id_e2a4c4()
  end
  local e6 = a3.new()
  self.v0[a1] = e6
  local function e7()
    local bf = a1.Character
    if not bf then
      return
    end
    local bn = bf:FindFirstChildOfClass("Humanoid")
    if not bn then
      return
    end
    e6:id_d91afa(bn.Died:Connect(function()
      task.defer(function()
        self:Ya(a1)
      end)
    end))
    e6:id_d91afa(bn:GetPropertyChangedSignal("Health"):Connect(function()
      task.defer(function()
        self:Ya(a1)
      end)
    end))
  end
  e6:id_d91afa(a1.CharacterAdded:Connect(function()
    task.defer(function()
      local bf = a1.Character
      if bf then
        a_(bf, "Head", 3)
      end
      e7()
      self:Ya(a1)
    end)
  end))
  e6:id_d91afa(a1:GetAttributeChangedSignal("Game"):Connect(function()
    task.defer(function()
      self:Ya(a1)
    end)
  end))
  e6:id_d91afa(a1:GetAttributeChangedSignal("Map"):Connect(function()
    task.defer(function()
      self:Ya(a1)
    end)
  end))
  e6:id_d91afa(a1:GetAttributeChangedSignal("Team"):Connect(function()
    task.defer(function()
      self:Ya(a1)
    end)
  end))
  task.defer(function()
    e7()
    self:Ya(a1)
  end)
end
function dJ:Yh(a1)
  local e6 = self.v0[a1]
  if e6 then
    e6:id_e2a4c4()
    self.v0[a1] = nil
  end
  self:zY(a1)
end
function dJ:id_fd7854()
  if not self.id_eefb95 then
    return
  end
  for Y, a1 in ipairs(K:GetPlayers()) do
    self:Ya(a1)
  end
end
function dJ:id_c6a804()
  if self.id_eefb95 then
    return
  end
  self.id_eefb95 = true
  for Y, a1 in ipairs(K:GetPlayers()) do
    self:I1(a1)
  end
  self.z3:id_d91afa(K.PlayerAdded:Connect(function(a1)
    self:I1(a1)
    task.defer(function()
      self:id_fd7854()
    end)
  end))
  self.z3:id_d91afa(K.PlayerRemoving:Connect(function(a1)
    self:Yh(a1)
    task.defer(function()
      self:id_fd7854()
    end)
  end))
  self.z3:id_d91afa(P:GetAttributeChangedSignal("Game"):Connect(function()
    task.defer(function()
      self:id_fd7854()
    end)
  end))
  self.z3:id_d91afa(P:GetAttributeChangedSignal("Map"):Connect(function()
    task.defer(function()
      self:id_fd7854()
    end)
  end))
  self.z3:id_d91afa(P:GetAttributeChangedSignal("Team"):Connect(function()
    task.defer(function()
      self:id_fd7854()
    end)
  end))
  self:id_fd7854()
end
function dJ:id_d7eac1()
  if not self.id_eefb95 then
    return
  end
  self.id_eefb95 = false
  self.z3:id_e2a4c4()
  for a1, e6 in pairs(self.v0) do
    e6:id_e2a4c4()
    self.v0[a1] = nil
  end
  for Y, a1 in ipairs(K:GetPlayers()) do
    dV(a1, false)
  end
  for a1 in pairs(self.kZ) do
    self:zY(a1)
  end
  self:LO()
end
local e8 = dJ.new()
local e9 = {}
e9.__index = e9
function e9.new()
  return setmetatable({
    id_eefb95 = false,
    z3 = a3.new(),
    e2 = {},
    o2 = nil,
    dX = false,
    V6 = {},
    eA = 0,
    pZ = 0.2,
    Wc = {},
  }, e9)
end
function e9:cQ()
  local ea = {}
  for Y, a1 in ipairs(K:GetPlayers()) do
    if a1 ~= P and by:mk(a1) and dX(a1) then
      ea[#ea + 1] = a1
    end
  end
  self.V6 = ea
end
function e9:kd()
  if self.o2 then
    return self.o2
  end
  if self.dX then
    return nil
  end
  self.dX = true
  self.o2 = bz()
  return self.o2
end
function e9:NH(a1)
  local eb = self.e2[a1]
  self.e2[a1] = nil
  if not eb then
    return
  end
  pcall(function()
    eb.Visible = false
  end)
  pcall(function()
    if eb.Remove then
      eb:Remove()
    elseif eb.Destroy then
      eb:Destroy()
    end
  end)
end
function e9:sG()
  local ec = {}
  for a1 in pairs(self.e2) do
    ec[#ec + 1] = a1
  end
  for Y, a1 in ipairs(ec) do
    self:NH(a1)
  end
end
function e9:s1(a1)
  local eb = self.e2[a1]
  if eb then
    return eb
  end
  local ed = self:kd()
  if not ed then
    return nil
  end
  local R, ee = pcall(function()
    local ef = ed.new("Line")
    ef.Visible = false
    ef.Color = aq(a8.id_b2d046.id_d6b5ab, Color3.fromRGB(0, 2 + 253, 0))
    ef.Thickness = 1.5
    ef.Transparency = 0.85
    return ef
  end)
  if R and ee then
    self.e2[a1] = ee
    return ee
  end
  return nil
end
function e9:h7(a1)
  local bf = a1 and a1.Character
  if not bf then
    return nil
  end
  local bg = bf:FindFirstChild("HumanoidRootPart")
  if bg and bg:IsA("BasePart") then
    return bg
  end
  local eg = bf:FindFirstChild("Head")
  if eg and eg:IsA("BasePart") then
    return eg
  end
  return nil
end
function e9:WH(bw)
  local U = workspace.CurrentCamera
  local eh = self:h7(P)
  if not U or not eh then
    self:Bg()
    return
  end
  self.eA = self.eA + (bw or 0)
  if self.eA >= self.pZ or not self.V6 then
    self.eA = 0
    self:cQ()
  end
  local ei = U.ViewportSize
  local ej, ek = U:WorldToViewportPoint(eh.Position)
  local d7 = Vector2.new(ej.X, ej.Y)
  if not ek or ej.Z <= 0 then
    d7 = Vector2.new(ei.X * 0.5, ei.Y - 16)
  end
  local el = aq(a8.id_b2d046.id_d6b5ab, Color3.fromRGB(0, 255, 0))
  local em = self.Wc
  table.clear(em)
  for Y, a1 in ipairs(self.V6) do
    local en = self:h7(a1)
    local eb = self:s1(a1)
    if en and eb then
      if eb.Color ~= el then
        eb.Color = el
      end
      local eo = U:WorldToViewportPoint(en.Position)
      if eo.Z > 0 then
        eb.From = d7
        eb.To = Vector2.new(eo.X, eo.Y)
        eb.Visible = true
        em[a1] = true
      else
        eb.Visible = false
      end
    end
  end
  for a1, eb in pairs(self.e2) do
    if not em[a1] and eb then
      eb.Visible = false
    end
  end
end
function e9:Bg()
  for Y, eb in pairs(self.e2) do
    if eb then
      pcall(function()
        eb.Visible = false
      end)
    end
  end
end
function e9:id_c6a804()
  if self.id_eefb95 then
    return
  end
  self.id_eefb95 = true
  self.V6 = {}
  self.eA = self.pZ
  self.z3:id_d91afa(L.RenderStepped:Connect(function(bw)
    if self.id_eefb95 then
      self:WH(bw)
    end
  end))
end
function e9:id_d7eac1()
  if not self.id_eefb95 then
    self:sG()
    return
  end
  self.id_eefb95 = false
  self.z3:id_e2a4c4()
  self:sG()
end
local ep = e9.new()
local eq = {}
eq.__index = eq
function eq.new()
  return setmetatable({ id_eefb95 = false, z3 = a3.new(), vy = 0, WX = {} }, eq)
end
function eq:qD(bg)
  if self.WX[bg] then
    return
  end
  self.WX[bg] = { Size = bg.Size, Transparency = bg.Transparency, Color = bg.Color, CanCollide = bg.CanCollide }
end
function eq:j6()
  for bg, er in pairs(self.WX) do
    if bg and bg.Parent then
      pcall(function()
        bg.Size = er.Size
        bg.Transparency = er.Transparency
        bg.Color = er.Color
        bg.CanCollide = er.CanCollide
      end)
    end
  end
  table.clear(self.WX)
end
function eq:D0(bg)
  local er = bg and self.WX[bg]
  if not er then
    return
  end
  if bg.Parent then
    pcall(function()
      bg.Size = er.Size
      bg.Transparency = er.Transparency
      bg.Color = er.Color
      bg.CanCollide = er.CanCollide
    end)
  end
  self.WX[bg] = nil
end
function eq:fM(a1)
  if a1 == P then
    return
  end
  local bg = be(a1)
  if not bg then
    return
  end
  if not ci(a1) or not dX(a1) then
    self:D0(bg)
    return
  end
  self:qD(bg)
  local es = tonumber(a8.id_e1110a.Size) or 4
  bg.Size = Vector3.new(es, es, es)
  local et = a8.id_e1110a.Show and math.clamp((tonumber(a8.id_e1110a.id_aab82c) or 5.5) / 10, 0, 1) or 0
  bg.Transparency = 1 - et
  bg.Color = aq(a8.id_e1110a.Color, Color3.fromRGB(255, 0, 0))
  bg.CanCollide = false
end
function eq:tO(bw)
  self.vy = self.vy + bw
  if self.vy < 0.1 then
    return
  end
  self.vy = 0
  for bg in pairs(self.WX) do
    if not bg.Parent then
      self.WX[bg] = nil
    end
  end
  for Y, a1 in ipairs(K:GetPlayers()) do
    self:fM(a1)
  end
end
function eq:id_c6a804()
  if self.id_eefb95 then
    return
  end
  self.id_eefb95 = true
  self.vy = 0
  self.z3:id_d91afa(L.Heartbeat:Connect(function(bw)
    self:tO(bw)
  end))
end
function eq:id_d7eac1()
  if not self.id_eefb95 then
    return
  end
  self.id_eefb95 = false
  self.z3:id_e2a4c4()
  self:j6()
end
function eq:id_f8a136()
  if not self.id_eefb95 then
    return
  end
  for Y, a1 in ipairs(K:GetPlayers()) do
    self:fM(a1)
  end
end
local eu = eq.new()
local ev = {}
ev.__index = ev
local ew = { "Right Platforms", "Left Platforms" }
local ex = {
  ["Right Platforms"] = {
    ["1v1"] = { id_afb39e = "PadZone1", Main = "Pad1", Alt = "Pad2" },
    ["2v2"] = { id_afb39e = "PadZone2", Main = "Pad1", Alt = "Pad2" },
    ["3v3"] = { id_afb39e = "PadZone3", Main = "Pad1", Alt = "Pad2" },
    ["4v4"] = { id_afb39e = "PadZone4", Main = "Pad1", Alt = "Pad2" },
  },
  ["Left Platforms"] = {
    ["1v1"] = { id_afb39e = "PadZone5", Main = "Pad1", Alt = "Pad2" },
    ["2v2"] = { id_afb39e = "PadZone6", Main = "Pad1", Alt = "Pad2" },
    ["3v3"] = { id_afb39e = "PadZone7", Main = "Pad1", Alt = "Pad2" },
    ["4v4"] = { id_afb39e = "PadZone8", Main = "Pad1", Alt = "Pad2" },
  },
}
local ey = {
  Main = {
    id_f59f4e = "id_eac970",
    id_fcbfb0 = "id_a82937",
    id_a33d71 = "id_a5d67b",
    id_a71128 = "auto_teleport_main_zone",
    id_c314e2 = "auto_teleport_platform_row_v2",
    id_af6110 = "Main",
  },
  Alt = {
    id_f59f4e = "id_a0792b",
    id_fcbfb0 = "id_a82937",
    id_a33d71 = "id_a5d67b",
    id_af6110 = "Alt",
  },
}
local function ez(eA, eB)
  local eC = eA and eA[eB]
  return eC and a8.id_db7d1a[eC] or nil
end
local function eD(eA)
  local eE = tostring(ez(eA, "id_fcbfb0") or "")
  return tonumber(string.match(eE, "^(%d+)v%d+$")) or 1
end
local function eF(eA)
  local eE = tostring(ez(eA, "id_fcbfb0") or "")
  if ex["Right Platforms"][eE] then
    return eE
  end
  local eG = eD(eA)
  local eH = ("%dv%d"):format(eG, eG)
  if ex["Right Platforms"][eH] then
    return eH
  end
  return "1v1"
end
local function eI(eA)
  local eJ = tostring(ez(eA, "id_a33d71") or "")
  if eJ == "Right" or eJ == "" then
    return "Right Platforms"
  end
  if eJ == "Left" then
    return "Left Platforms"
  end
  return eJ
end
local function eK(eA)
  local eL = ex[eI(eA)]
  if not eL then
    eL = ex["Right Platforms"]
  end
  local eM = eL[eF(eA)]
  if not eM then
    eM = eL["1v1"]
  end
  local eN = eA and eA.id_af6110 or "Main"
  return eM.id_afb39e, eM[eN]
end
local function eO(eA)
  local eP, eQ = eK(eA)
  local eR = workspace:FindFirstChild("PadZones")
  local eS = eR and eP and eR:FindFirstChild(eP)
  local eT = eS and eQ and eS:FindFirstChild(eQ)
  local eU = eT and eT:FindFirstChild("Pad")
  return eU and eU:IsA("BasePart") and eU or nil
end
local function eV(eW, cm, eX)
  if not (eW and cm and cm:IsA("BasePart")) then
    return false
  end
  eX = tonumber(eX) or 0
  local eY = cm.CFrame:PointToObjectSpace(eW)
  local eZ = cm.Size / 2
  return math.abs(eY.X) <= eZ.X + eX and math.abs(eY.Z) <= eZ.Z + eX and eY.Y >= -(eZ.Y + 6) and eY.Y <= eZ.Y + 14
end
local function f0(eA)
  local f1 = eO(eA)
  local bg = be(P)
  return f1 ~= nil and bg ~= nil and eV(bg.Position, f1, 0.5)
end
function ev.new(f2, eA)
  return setmetatable({
    Ll = f2 or "Main",
    D6 = eA or ey.Main,
    id_eefb95 = false,
    z3 = a3.new(),
    vy = 0,
    ZB = 0,
    YK = 0,
    fX = 0,
    NT = nil,
    Z2 = nil,
    xT = nil,
  }, ev)
end
function ev:IQ()
  if self.Z2 and self.xT then
    local eU = self.Z2
    local f3 = self.xT
    pcall(function()
      if eU.Parent then
        eU.Color = f3.Color
        eU.Transparency = f3.Transparency
      end
    end)
  end
  self.Z2 = nil
  self.xT = nil
end
function ev:eY(f1)
  if not f1 then
    self:IQ()
    return
  end
  if self.Z2 ~= f1 then
    self:IQ()
    self.Z2 = f1
    self.xT = { Color = f1.Color, Transparency = f1.Transparency }
  end
  f1.Color = self.Ll == "Alt" and Color3.fromRGB(255, 70, 70) or Color3.fromRGB(70, 105 + 40, 255)
  f1.Transparency = 0.5
end
function ev:OW()
  local bn = bh(P)
  local bl = be(P)
  if bn and bl then
    pcall(function()
      bn:MoveTo(bl.Position)
    end)
  end
end
function ev:I9()
  return bx:id_e26235()
end
function ev:PH()
  local bq = self:I9()
  return bq and bq.id_f52ad0 == true
end
function ev:dk()
  return aV(P, "Team")
end
function ev:gF(bq)
  bq = bq or self:I9()
  return bq and bq.id_f52ad0 == true and bq.id_c72e2e ~= true and self:dk()
end
function ev:M3()
  local b7 = N:FindFirstChild("Packages")
  local b8 = b7 and b7:FindFirstChild("Networking")
  local bd = b8 and b8:FindFirstChild("RE/Match/SetStatePlr")
  return bd and bd:IsA("RemoteEvent") and bd or nil
end
function ev:C_()
  local b7 = N:FindFirstChild("Packages")
  local b8 = b7 and b7:FindFirstChild("Networking")
  local bd = b8 and b8:FindFirstChild("RF/Voting/Vote")
  return bd and bd:IsA("RemoteFunction") and bd or nil
end
function ev:K6()
  local ct = P:FindFirstChild("PlayerGui")
  local cu = ct and ct:FindFirstChild("Main")
  local f4 = cu and cu:FindFirstChild("MapVoting")
  local f5 = f4 and f4:FindFirstChild("VotingHolder")
  if not f5 then
    return nil
  end
  for Y, bv in ipairs(f5:GetChildren()) do
    if bv:IsA("ImageButton") and bv.Visible and bv.Name ~= "" then
      return bv.Name
    end
  end
  return nil
end
function ev:Nj(bq)
  bq = bq or self:I9()
  if not self:gF(bq) then
    return
  end
  if self.NT == bq.id_af8690 then
    return
  end
  local f6 = os.clock()
  if f6 - (self.fX or 0) < 1 then
    return
  end
  self.fX = f6
  local f7 = self:K6()
  local f8 = f7 and self:C_()
  if not (f7 and f8) then
    return
  end
  self.NT = bq.id_af8690
  pcall(function()
    f8:InvokeServer(f7)
  end)
end
function ev:_x()
  local f6 = os.clock()
  if f6 - (self.YK or 0) < 1 then
    return
  end
  local f9 = self:M3()
  if not f9 then
    return
  end
  self.YK = f6
  pcall(function()
    f9:FireServer("REMOVE")
  end)
end
function ev:wP()
  local ct = P:FindFirstChild("PlayerGui")
  local cu = ct and ct:FindFirstChild("Main")
  local cv = cu and cu:FindFirstChild("MainGameFrame")
  if cv and cv:IsA("GuiObject") then
    pcall(function()
      cv.Visible = false
    end)
  end
end
function ev:vc(fa)
  if I or not self.id_eefb95 then
    return
  end
  local bq = self:I9()
  if bq and bq.id_f52ad0 then
    self:IQ()
    self:OW()
    self:Nj(bq)
    return
  end
  local f1 = eO(self.D6)
  self:eY(f1)
  if not f1 then
    return
  end
  if f0(self.D6) then
    return
  end
  if not fa and os.clock() - self.ZB < 0.5 then
    return
  end
  local bl = be(P)
  local bn = bh(P)
  if f1 and bl and bn then
    pcall(function()
      bl.AssemblyAngularVelocity = Vector3.zero
      self:_x()
      self:wP()
      bn:MoveTo(f1.Position)
    end)
    self.ZB = os.clock()
  end
end
function ev:Dl()
  if self:PH() then
    return false
  end
  if f0(self.D6) then
    return false
  end
  return true
end
function ev:Vc()
  if I or not self.id_eefb95 then
    return
  end
  local bq = self:I9()
  if bq and bq.id_f52ad0 then
    self:IQ()
    self:OW()
    self:Nj(bq)
    return
  end
  if self:Dl() then
    self:vc()
  else
    self:eY(eO(self.D6))
  end
end
function ev:id_c6a804()
  if I or self.id_eefb95 then
    return
  end
  self.id_eefb95 = true
  self.vy = 0
  self.z3:id_d91afa(P:GetAttributeChangedSignal("Game"):Connect(function()
    task.defer(function()
      if I or not self.id_eefb95 then
        return
      end
      self:Vc()
    end)
  end))
  self.z3:id_d91afa(P:GetAttributeChangedSignal("Map"):Connect(function()
    task.defer(function()
      if I or not self.id_eefb95 then
        return
      end
      self:Vc()
    end)
  end))
  self.z3:id_d91afa(P:GetAttributeChangedSignal("Team"):Connect(function()
    task.defer(function()
      if I or not self.id_eefb95 then
        return
      end
      self:Vc()
    end)
  end))
  self.z3:id_d91afa(bx:id_a7a13d(function(bq, br)
    task.defer(function()
      if I or not self.id_eefb95 then
        return
      end
      self:Vc()
    end)
  end))
  self.z3:id_d91afa(L.Heartbeat:Connect(function(bw)
    if I or not self.id_eefb95 then
      return
    end
    self.vy = self.vy + bw
    if self.vy < 0.5 then
      return
    end
    self.vy = 0
    self:Vc()
  end))
  self:id_ab3c6e()
end
function ev:id_d7eac1()
  self.id_eefb95 = false
  self.z3:id_e2a4c4()
  self:IQ()
end
function ev:id_ab3c6e()
  if I or not self.id_eefb95 then
    return
  end
  self:vc(true)
end
local fb = ev.new("Main", ey.Main)
local fc = ev.new("Alt", ey.Alt)
pcall(function()
  getgenv()[H] = function()
    I = true
    a8.id_db7d1a.id_eac970 = false
    a8.id_db7d1a.id_a0792b = false
    if fb then
      fb:id_d7eac1()
    end
    if fc then
      fc:id_d7eac1()
    end
  end
end)
local fd = {}
fd.__index = fd
function fd.new()
  return setmetatable({ id_eefb95 = false, z3 = a3.new(), vy = 0 }, fd)
end
function fd:lI(bl)
  if type(firetouchinterest) ~= "function" or not bl then
    return
  end
  local fe = workspace:FindFirstChild("SpawnablesClient")
  if not fe then
    return
  end
  for Y, ff in ipairs(fe:GetChildren()) do
    local fg = ff:FindFirstChild("Touch", true)
    if fg and fg:IsA("BasePart") then
      pcall(function()
        firetouchinterest(bl, fg, 0)
        firetouchinterest(bl, fg, 1)
      end)
    end
  end
end
function fd:tO(bw)
  self.vy = self.vy + bw
  if self.vy < 0.5 then
    return
  end
  self.vy = 0
  local bq = bx:id_e26235()
  if not (bq.id_c72e2e and bq.id_a3aa92 and bq.id_e265ce) then
    return
  end
  self:lI(bq.id_e265ce)
end
function fd:id_c6a804()
  if self.id_eefb95 then
    return
  end
  self.id_eefb95 = true
  self.vy = 0
  self.z3:id_d91afa(L.Heartbeat:Connect(function(bw)
    if self.id_eefb95 then
      self:tO(bw)
    end
  end))
end
function fd:id_d7eac1()
  if not self.id_eefb95 then
    return
  end
  self.id_eefb95 = false
  self.vy = 0
  self.z3:id_e2a4c4()
end
local fh = fd.new()
local function fi(cy)
  if not (cy and cy:IsA("Tool")) then
    return false
  end
  local fj = cy:FindFirstChild("fire")
  if fj and fj:IsA("RemoteEvent") then
    return true
  end
  local fk = cy:FindFirstChild("showBeam")
  if fk and fk:IsA("RemoteEvent") then
    return true
  end
  return false
end
local function fl(cy)
  if not (cy and cy:IsA("Tool")) then
    return false
  end
  local fm = cy:FindFirstChild("kill")
  local fn = tostring(cy.Name or ""):lower()
  return fm and fm:IsA("RemoteEvent") or fn:find("knife", 1, true) ~= nil
end
local function fo(bf, fp)
  if not bf then
    return nil
  end
  for Y, bv in ipairs(bf:GetChildren()) do
    if fp(bv) then
      return bv
    end
  end
  return nil
end
local function fq(bf)
  return fo(bf, fi)
end
local function fr(bf)
  return fo(bf, fl)
end
local function fs()
  local ft = a8.id_c1632a.id_a00ab8 == true
  local fu = a8.id_c1632a.id_f7ca6b == true
  if not ft and not fu then
    return true
  end
  local bf = P.Character
  return ft and fq(bf) ~= nil or fu and fr(bf) ~= nil
end
local function fv(a1)
  local bf = a1 and a1.Character
  if not bf then
    return nil
  end
  return bf:FindFirstChild("Head")
    or bf:FindFirstChild("UpperTorso")
    or bf:FindFirstChild("HumanoidRootPart")
    or bf:FindFirstChildWhichIsA("BasePart")
end
local fw = {
  "Head",
  "LeftLowerArm",
  "LeftHand",
  "LeftLowerLeg",
  "LeftFoot",
  "LeftUpperArm",
  "LeftUpperLeg",
  "LowerTorso",
  "RightLowerArm",
  "RightHand",
  "RightLowerLeg",
  "RightFoot",
  "RightUpperArm",
  "RightUpperLeg",
  "UpperTorso",
}
local fx = {
  {
    Name = "Head",
    Label = "H",
    X = 68 + 34,
    Y = 34,
    id_f9bd5d = 74,
    id_ded8e2 = 42,
  },
  {
    Name = "LeftUpperArm",
    Label = "LUA",
    X = 34,
    Y = 80,
    id_f9bd5d = 44,
    id_ded8e2 = 56,
  },
  {
    Name = "LeftLowerArm",
    Label = "LLA",
    X = 34,
    Y = 141,
    id_f9bd5d = 44,
    id_ded8e2 = 34,
  },
  {
    Name = "LeftHand",
    Label = "LH",
    X = 34,
    Y = 180,
    id_f9bd5d = 44,
    id_ded8e2 = 20,
  },
  {
    Name = "RightUpperArm",
    Label = "RUA",
    X = 200,
    Y = 80,
    id_f9bd5d = 44,
    id_ded8e2 = 56,
  },
  {
    Name = "RightLowerArm",
    Label = "RLA",
    X = 200,
    Y = 141,
    id_f9bd5d = 44,
    id_ded8e2 = 34,
  },
  {
    Name = "RightHand",
    Label = "RH",
    X = 200,
    Y = 4 * 45,
    id_f9bd5d = 44,
    id_ded8e2 = 20,
  },
  {
    Name = "UpperTorso",
    Label = "UT",
    X = 82,
    Y = 80,
    id_f9bd5d = 114,
    id_ded8e2 = 74,
  },
  {
    Name = "LowerTorso",
    Label = "LT",
    X = 86,
    Y = 53 * 3,
    id_f9bd5d = 106,
    id_ded8e2 = 28,
  },
  {
    Name = "LeftUpperLeg",
    Label = "LUL",
    X = 94,
    Y = 198,
    id_f9bd5d = 40,
    id_ded8e2 = 72,
  },
  {
    Name = "LeftLowerLeg",
    Label = "LLL",
    X = 94,
    Y = 275,
    id_f9bd5d = 40,
    id_ded8e2 = 26,
  },
  {
    Name = "LeftFoot",
    Label = "LF",
    X = 94,
    Y = 306,
    id_f9bd5d = 40,
    id_ded8e2 = 16,
  },
  {
    Name = "RightUpperLeg",
    Label = "RUL",
    X = 3 + 141,
    Y = 198,
    id_f9bd5d = 40,
    id_ded8e2 = 72,
  },
  {
    Name = "RightLowerLeg",
    Label = "RLL",
    X = 251 - 107,
    Y = 55 * 5,
    id_f9bd5d = 40,
    id_ded8e2 = 26,
  },
  {
    Name = "RightFoot",
    Label = "RF",
    X = 223 - 79,
    Y = 296 + 10,
    id_f9bd5d = 40,
    id_ded8e2 = 16,
  },
}
local fy = {}
for Y, fz in ipairs(fw) do
  fy[fz] = true
end
local fA = {
  Accent = Color3.fromHex("#18181b"),
  Background = Color3.fromHex("#101010"),
  Text = Color3.fromHex("#FFFFFF"),
  Button = Color3.fromHex("#52525b"),
  Icon = Color3.fromHex("#a1a1aa"),
  Selected = Color3.fromHex("#4FC3F7"),
}
local function fB()
  if type(a8.id_c1632a.id_f507e2) ~= "table" then
    a8.id_c1632a.id_f507e2 = {}
  end
  for fz, ab in pairs(a8.id_c1632a.id_f507e2) do
    if fy[fz] == nil then
      a8.id_c1632a.id_f507e2[fz] = nil
    elseif type(ab) ~= "boolean" then
      a8.id_c1632a.id_f507e2[fz] = ab == true
    end
  end
  for Y, fz in ipairs(fw) do
    if a8.id_c1632a.id_f507e2[fz] == nil then
      a8.id_c1632a.id_f507e2[fz] = fy[fz] == true
    end
  end
end
local function fC()
  fB()
  if not a8.id_c1632a.id_f0abef then
    return { "Head", "UpperTorso", "HumanoidRootPart" }
  end
  local ap = {}
  for Y, fz in ipairs(fw) do
    if a8.id_c1632a.id_f507e2[fz] == true then
      ap[#ap + 1] = fz
    end
  end
  if #ap == 0 then
    return { "UpperTorso", "HumanoidRootPart" }
  end
  return ap
end
local function fD(a1, fE)
  local bf = a1 and a1.Character
  if not bf then
    return nil
  end
  fE = fE or fC()
  local fF = {}
  for Y, fz in ipairs(fE) do
    local cm = bf:FindFirstChild(fz)
    if cm and cm:IsA("BasePart") then
      fF[#fF + 1] = cm
    end
  end
  if #fF == 0 then
    return nil
  end
  return fF
end
local fG = nil
local fH = false
local function fI(fJ)
  if fG and fH == fJ then
    return fG
  end
  local dq = fG
  if not dq then
    dq = RaycastParams.new()
    dq.FilterType = Enum.RaycastFilterType.Exclude
    dq.IgnoreWater = true
    fG = dq
  end
  dq.FilterDescendantsInstances = fJ and { fJ } or {}
  fH = fJ
  return dq
end
local function fK(fL, en)
  local fJ = P.Character
  local fM = be(P)
  local fN = fL and fL.Character
  if not (fJ and fM and fN and en and en:IsA("BasePart")) then
    return false
  end
  local fO = en.Position - fM.Position
  if fO.Magnitude <= 0 then
    return false
  end
  local dr = workspace:Raycast(fM.Position, fO, fI(fJ))
  return not dr or dr.Instance and dr.Instance:IsDescendantOf(fN)
end
local fP = {}
fP.__index = fP
function fP.new()
  return setmetatable({
    id_eefb95 = false,
    z3 = a3.new(),
    Z_ = 0,
    pZ = 0.06,
    Kc = nil,
    F7 = nil,
    eN = nil,
  }, fP)
end
function fP:eb(fQ)
  local f6 = os.clock()
  if
    self.Kc
    and self.eN == fQ
    and f6 - (self.Z_ or 0) < self.pZ
    and ci(self.Kc)
    and dX(self.Kc)
    and self.F7
    and self.F7.Parent
    and self.F7:IsDescendantOf(self.Kc.Character)
  then
    return self.Kc, self.F7
  end
  self.Z_ = f6
  self.Kc = nil
  self.F7 = nil
  self.eN = fQ
  local fM = be(P)
  if not fM then
    return nil, nil
  end
  local fR = nil
  local fS = nil
  local fT = math.huge
  for Y, a1 in ipairs(K:GetPlayers()) do
    if a1 ~= P and ci(a1) and dX(a1) then
      local en = fv(a1)
      if en and (not fQ or fK(a1, en)) then
        local cr = (fM.Position - en.Position).Magnitude
        if cr < fT then
          fR = a1
          fS = en
          fT = cr
        end
      end
    end
  end
  self.Kc = fR
  self.F7 = fS
  return fR, fS
end
function fP:id_c6a804()
  if self.id_eefb95 then
    return
  end
  self.id_eefb95 = true
  self.Z_ = 0
  self.Kc = nil
  self.F7 = nil
  self.eN = nil
  self.z3:id_d91afa(L.RenderStepped:Connect(function()
    if not self.id_eefb95 then
      return
    end
    if not fs() then
      return
    end
    local U = workspace.CurrentCamera
    local Y, en = self:eb(a8.id_c1632a.id_b6ad50 == true)
    if U and en then
      U.CFrame = CFrame.new(U.CFrame.Position, en.Position)
    end
  end))
end
function fP:id_d7eac1()
  if not self.id_eefb95 then
    return
  end
  self.id_eefb95 = false
  self.Kc = nil
  self.F7 = nil
  self.eN = nil
  self.z3:id_e2a4c4()
end
local fU = fP.new()
local fV = {}
fV.__index = fV
function fV.new()
  return setmetatable({ id_eefb95 = false, z3 = a3.new(), uI = 0, Z_ = 0, Uc = 2.5, pZ = 0.06 }, fV)
end
function fV:fL(aW)
  local dd = aW
  while dd and dd ~= workspace do
    local a1 = K:GetPlayerFromCharacter(dd)
    if a1 then
      return a1
    end
    dd = dd.Parent
  end
  return nil
end
function fV:cP()
  local U = workspace.CurrentCamera
  local fJ = P.Character
  if not U or not fJ then
    return nil, nil
  end
  local fW = M:GetMouseLocation()
  local fX = U:ViewportPointToRay(fW.X, fW.Y)
  local dr = workspace:Raycast(fX.Origin, fX.Direction * 10000, fI(fJ))
  if not dr then
    return nil, nil
  end
  return self:fL(dr.Instance), dr.Instance
end
function fV:ut(fL)
  return fL and ci(fL) and dX(fL)
end
function fV:Ua()
  local f6 = os.clock()
  if f6 - (self.Z_ or 0) < self.pZ then
    return
  end
  self.Z_ = f6
  if f6 - (self.uI or 0) < self.Uc then
    return
  end
  local cy = fq(P.Character)
  if not cy then
    return
  end
  local fL, fY = self:cP()
  if not self:ut(fL) then
    return
  end
  if not (fY and fY:IsDescendantOf(fL.Character)) then
    return
  end
  if not fK(fL, fY) then
    return
  end
  self.uI = f6
  pcall(function()
    cy:Activate()
  end)
end
function fV:id_c6a804()
  if self.id_eefb95 then
    return
  end
  self.id_eefb95 = true
  self.uI = 0
  self.Z_ = 0
  self.z3:id_d91afa(L.RenderStepped:Connect(function()
    if self.id_eefb95 then
      self:Ua()
    end
  end))
end
function fV:id_d7eac1()
  if not self.id_eefb95 then
    return
  end
  self.id_eefb95 = false
  self.z3:id_e2a4c4()
end
local fZ = fV.new()
local f_ = {}
f_.__index = f_
f_.gT = 0.03
f_.Yk = 0.45
f_.Gs = {
  UpperTorso = 34,
  LowerTorso = 22,
  HumanoidRootPart = 22,
  Head = 14,
  LeftUpperArm = 5,
  RightUpperArm = 5,
  LeftUpperLeg = 5,
  RightUpperLeg = 5,
  LeftLowerArm = 3,
  RightLowerArm = 3,
  LeftLowerLeg = 3,
  RightLowerLeg = 3,
  LeftHand = 2,
  RightHand = 2,
  LeftFoot = 2,
  RightFoot = 2,
}
function f_.new()
  return setmetatable({
    id_eefb95 = false,
    Fm = false,
    dQ = nil,
    iz = false,
    z3 = a3.new(),
    Z_ = 0,
    F7 = nil,
    hD = nil,
    EB = 0,
    xl = true,
    rn = true,
  }, f_)
end
function f_:id_c89189()
  if self.dQ then
    return self.dQ
  end
  local R, e6 = pcall(function()
    return P:GetMouse()
  end)
  if R and e6 then
    self.dQ = e6
  end
  return self.dQ
end
function f_:WO(g0, U, g1, g2)
  local g3, g4 = nil, nil
  for Y, cm in ipairs(g0) do
    if cm and cm:IsA("BasePart") then
      local g5, g6 = U:WorldToViewportPoint(cm.Position)
      if g6 then
        local cr = (Vector2.new(g5.X, g5.Y) - g1).Magnitude
        if cr <= g2 then
          g3 = g3 or {}
          g3[#g3 + 1] = cm
          if not g4 or cr < g4 then
            g4 = cr
          end
        end
      end
    end
  end
  return g3, g4
end
function f_.Wj(g0, g7)
  local g8, g9, ga = {}, {}, 0
  for Y, cm in ipairs(g0) do
    local gb = f_.Gs[cm.Name] or 1
    g8[#g8 + 1] = cm
    g9[#g9 + 1] = gb
    ga = ga + gb
  end
  while #g8 > 0 and ga > 0 do
    local gc, gd = math.random() * ga, #g8
    local ge = 0
    for a5 = 1, #g8 do
      ge = ge + g9[a5]
      if gc <= ge then
        gd = a5
        break
      end
    end
    local cm = g8[gd]
    if g7(cm) then
      return cm
    end
    ga = ga - g9[gd]
    table.remove(g8, gd)
    table.remove(g9, gd)
  end
  return nil
end
function f_:Xa(g0, a1)
  return f_.Wj(g0, function(cm)
    return fK(a1, cm)
  end)
end
function f_:EV()
  local U = workspace.CurrentCamera
  if not U then
    return nil, nil
  end
  local g1 = c1()
  local g2 = math.huge
  if a8.id_c1632a.id_b7ba43 then
    g2 = tonumber(a8.id_c1632a.id_f2d9c0) or 200
  end
  local gf = fC()
  local gg = nil
  for Y, a1 in ipairs(K:GetPlayers()) do
    if a1 ~= P and ci(a1) and dX(a1) then
      local fF = fD(a1, gf)
      if fF then
        local g3, g4 = self:WO(fF, U, g1, g2)
        if g3 then
          gg = gg or {}
          gg[#gg + 1] = {
            id_fc1ecf = a1,
            id_bc32f4 = g3,
            id_f45223 = g4,
          }
        end
      end
    end
  end
  if not gg then
    return nil, nil
  end
  table.sort(gg, function(gh, at)
    return gh.id_f45223 < at.id_f45223
  end)
  for Y, c4 in ipairs(gg) do
    local cm = self:Xa(c4.id_bc32f4, c4.id_fc1ecf)
    if cm then
      return cm, c4.id_fc1ecf
    end
  end
  return nil, nil
end
function f_:qe()
  local cm = self.F7
  local a1 = self.hD
  if not (cm and a1 and cm.Parent) then
    return false
  end
  local bf = a1.Character
  return bf ~= nil and cm:IsDescendantOf(bf) and ci(a1) and dX(a1)
end
function f_.LR()
  local gi = math.clamp(tonumber(a8.id_c1632a.id_f28945) or 50 * 2, 0, 100)
  if gi >= 100 then
    return true
  end
  if gi <= 0 then
    return false
  end
  return math.random() * (21 + 79) <= gi
end
function f_:tJ()
  return f_.LR()
end
function f_:Kn()
  self.xl = true
end
function f_:id_b978c6()
  local f6 = os.clock()
  if f6 - (self.Z_ or 0) < f_.gT then
    if self.rn and self:qe() then
      return self.F7
    end
    return nil
  end
  self.Z_ = f6
  local gj = not self.xl and f6 < (self.EB or 0) and self:qe()
  if gj then
    return self.rn and self.F7 or nil
  end
  self.xl = false
  self.EB = f6 + f_.Yk
  local cm, a1 = self:EV()
  self.F7, self.hD = cm, a1
  self.rn = cm ~= nil and self:tJ()
  return self.rn and cm or nil
end
function f_:LM()
  if self.Fm then
    return true
  end
  if type(getrawmetatable) ~= "function" or type(setreadonly) ~= "function" then
    if not self.iz then
      self.iz = true
      bD("Silent Aim", "Executor not supported.", "alert-triangle", 4)
    end
    return false
  end
  local gk = self
  local gl = type(newcclosure) == "function" and newcclosure or function(gm)
    return gm
  end
  local R = pcall(function()
    local gn = getrawmetatable(game)
    local go = gn.__index
    local gp = gl(function(gq, gr)
      if gk.id_eefb95 and (gr == "Hit" or gr == "Target") and gq == gk:id_c89189() then
        local en = not I4:KO() and gk:id_b978c6() or nil
        if en then
          return gr == "Hit" and en.CFrame or en
        end
      end
      return go(gq, gr)
    end)
    setreadonly(gn, false)
    gn.__index = gp
    setreadonly(gn, true)
    gk.id_af9d2f = go
    gk.id_f6ebd9 = gp
  end)
  if R then
    self.Fm = true
  end
  return self.Fm
end
function f_:id_c6a804()
  if not self:LM() then
    return
  end
  if self.id_eefb95 then
    return
  end
  self.id_eefb95 = true
  self.Z_ = 0
  self.EB = 0
  self.xl = true
  self.rn = true
  self.F7 = nil
  self.hD = nil
  self.z3:id_d91afa(M.InputBegan:Connect(function(aN)
    if aN.UserInputType == Enum.UserInputType.MouseButton1 or aN.UserInputType == Enum.UserInputType.Touch then
      self:Kn()
    end
  end))
end
function f_:id_d7eac1()
  if not self.id_eefb95 then
    return
  end
  self.id_eefb95 = false
  self.F7 = nil
  self.hD = nil
  self.Z_ = 0
  self.EB = 0
  self.xl = true
  self.rn = true
  self.z3:id_e2a4c4()
end
function f_:id_aa5392()
  if not self.Fm then
    return
  end
  pcall(function()
    local gn = getrawmetatable(game)
    if self.id_f6ebd9 and self.id_af9d2f and rawequal(gn.__index, self.id_f6ebd9) then
      setreadonly(gn, false)
      gn.__index = self.id_af9d2f
      setreadonly(gn, true)
    end
  end)
  self.Fm = false
  self.id_af9d2f = nil
  self.id_f6ebd9 = nil
end
local gs = f_.new()
I4 = {
  Fm = false,
  iz = false,
  id_f47b4a = nil,
  Ac = false,
  id_fcc684 = 5000,
  id_b822eb = 20,
}
function I4:Set(cm)
  self.id_f47b4a = cm
end
function I4:iK()
  local cQ = self.id_f47b4a
  return cQ ~= nil and cQ.Parent ~= nil
end
function I4:Ip(ab)
  self.Ac = ab == true
end
function I4:KO()
  return self.Ac == true or self:iK()
end
function I4:PT(gt)
  if self.Fm then
    return true
  end
  if
    type(getrawmetatable) ~= "function"
    or type(setreadonly) ~= "function"
    or type(getnamecallmethod) ~= "function"
    or type(checkcaller) ~= "function"
  then
    if not self.iz then
      self.iz = true
      bD(gt or "Aim", "Executor not supported.", "alert-triangle", 4)
    end
    return false
  end
  local gu = self
  local gl = type(newcclosure) == "function" and newcclosure or function(gm)
    return gm
  end
  local R = pcall(function()
    local gn = getrawmetatable(game)
    local gv = gn.__namecall
    local gp = gl(function(gq, ...)
      local cQ = gu.id_f47b4a
      if cQ and cQ.Parent and gq == workspace and not checkcaller() then
        local gw = getnamecallmethod()
        if gw == "Raycast" then
          local gx, fO, dq = ...
          if typeof(fO) == "Vector3" and fO.Magnitude > gu.id_b822eb then
            local gy = (cQ.Position - gx).Unit * gu.id_fcc684
            return gv(gq, gx, gy, dq)
          end
        elseif string.find(gw, "FindPartOnRay") then
          local fX, gz, gA, gB = ...
          if typeof(fX) == "Ray" and fX.Direction.Magnitude > gu.id_b822eb then
            local gy = Ray.new(fX.Origin, (cQ.Position - fX.Origin).Unit * gu.id_fcc684)
            return gv(gq, gy, gz, gA, gB)
          end
        end
      end
      return gv(gq, ...)
    end)
    setreadonly(gn, false)
    gn.__namecall = gp
    setreadonly(gn, true)
    gu.id_b445a3 = gv
    gu.id_f6ebd9 = gp
  end)
  if R then
    self.Fm = true
  end
  return self.Fm
end
function I4:id_aa5392()
  if not self.Fm then
    return
  end
  pcall(function()
    local gn = getrawmetatable(game)
    if self.id_f6ebd9 and self.id_b445a3 and rawequal(gn.__namecall, self.id_f6ebd9) then
      setreadonly(gn, false)
      gn.__namecall = self.id_b445a3
      setreadonly(gn, true)
    end
  end)
  self.Fm = false
  self.id_b445a3 = nil
  self.id_f6ebd9 = nil
end
function I4:S_(cm, gC, dq)
  local eG = cm.Size
  local gD = {
    Vector3.zero,
    Vector3.new(eG.X / 2.1, 0, 0),
    Vector3.new(-eG.X / 2.1, 0, 0),
    Vector3.new(0, eG.Y / 2.1, 0),
    Vector3.new(0, -eG.Y / 2.1, 0),
  }
  for Y, gE in ipairs(gD) do
    local eW = cm.CFrame * gE
    if not workspace:Raycast(gC, eW - gC, dq) then
      return true
    end
  end
  return false
end
lK = {}
lK.__index = lK
lK.gT = 0.1
lK.ke = 0.2
lK.Ws = 0.05
function lK.new()
  return setmetatable({ id_eefb95 = false, z3 = a3.new(), az = nil, vy = 0, uI = 0, nw = nil }, lK)
end
function lK:nF()
  local gF = P.Character
  local co = be(P)
  if not (gF and co) then
    return nil
  end
  local dq = self.nw
  if not dq then
    dq = RaycastParams.new()
    dq.FilterType = Enum.RaycastFilterType.Exclude
    dq.IgnoreWater = true
    self.nw = dq
  end
  local gx = co.Position
  local eg = gF:FindFirstChild("Head")
  local gC = eg and eg.Position or gx
  local gf = fC()
  local gG, cq = nil, math.huge
  for Y, a1 in ipairs(K:GetPlayers()) do
    if ci(a1) and dX(a1) then
      local fF = fD(a1, gf)
      if fF then
        dq.FilterDescendantsInstances = { gF, a1.Character }
        for Y, cm in ipairs(fF) do
          local cr = (cm.Position - gx).Magnitude
          if cr < cq and I4:S_(cm, gC, dq) then
            gG, cq = cm, cr
          end
        end
      end
    end
  end
  return gG
end
function lK:tO(bw)
  self.vy = (self.vy or 0) + bw
  if self.vy < lK.gT then
    return
  end
  self.vy = 0
  local cy = fq(P.Character)
  if not cy then
    self.az = nil
    I4:Set(nil)
    return
  end
  local en = self:nF()
  self.az = en
  I4:Set(en)
  if not en then
    return
  end
  local f6 = os.clock()
  if f6 - (self.uI or 0) < lK.ke then
    return
  end
  self.uI = f6
  pcall(function()
    cy:Activate()
  end)
  task.delay(lK.Ws, function()
    if cy.Parent == P.Character then
      pcall(function()
        cy:Deactivate()
      end)
    end
  end)
end
function lK:id_c6a804()
  if not I4:PT("Auto Shoot") then
    return
  end
  if self.id_eefb95 then
    return
  end
  self.id_eefb95 = true
  self.vy = 0
  self.uI = 0
  self.az = nil
  self.z3:id_d91afa(L.Heartbeat:Connect(function(bw)
    if self.id_eefb95 then
      self:tO(bw)
    end
  end))
end
function lK:id_d7eac1()
  if not self.id_eefb95 then
    return
  end
  self.id_eefb95 = false
  self.az = nil
  I4:Set(nil)
  self.z3:id_e2a4c4()
end
Aa = lK.new()
id = {}
id.__index = id
id.gT = 0.1
id.Uw = 0.05
id.GP = 0.12
id.Sa = 20
id.u_ = 0.25
function id.new()
  return setmetatable({
    id_eefb95 = false,
    z3 = a3.new(),
    qr = nil,
    vy = 0,
    sX = false,
    qm = nil,
    Wi = 0,
    nw = nil,
  }, id)
end
function id:kk()
  local co = be(P)
  if not (P.Character and co) then
    return nil
  end
  local gx = co.Position
  local gf = fC()
  local gg = nil
  for Y, a1 in ipairs(K:GetPlayers()) do
    if ci(a1) and dX(a1) then
      local fF = fD(a1, gf)
      if fF then
        local g4 = math.huge
        for Y, cm in ipairs(fF) do
          local cr = (cm.Position - gx).Magnitude
          if cr < g4 then
            g4 = cr
          end
        end
        gg = gg or {}
        gg[#gg + 1] = {
          id_fc1ecf = a1,
          id_bc32f4 = fF,
          id_f45223 = g4,
        }
      end
    end
  end
  if not gg then
    return nil
  end
  table.sort(gg, function(gh, at)
    return gh.id_f45223 < at.id_f45223
  end)
  return gg
end
function id:AF()
  local gg = self.qr
  if not gg then
    return nil
  end
  local gF = P.Character
  local co = be(P)
  if not (gF and co) then
    return nil
  end
  local dq = self.nw
  if not dq then
    dq = RaycastParams.new()
    dq.FilterType = Enum.RaycastFilterType.Exclude
    dq.IgnoreWater = true
    self.nw = dq
  end
  local eg = gF:FindFirstChild("Head")
  local gC = eg and eg.Position or co.Position
  for Y, c4 in ipairs(gg) do
    local bm = c4.id_fc1ecf.Character
    if bm and dX(c4.id_fc1ecf) and ci(c4.id_fc1ecf) then
      dq.FilterDescendantsInstances = { gF, bm }
      local cm = f_.Wj(c4.id_bc32f4, function(gH)
        return gH.Parent ~= nil and I4:S_(gH, gC, dq)
      end)
      if cm then
        return cm
      end
    end
  end
  return nil
end
function id:Ah()
  local cB = fq(P.Character)
  if cB then
    return cB
  end
  local cz = P:FindFirstChildOfClass("Backpack")
  if cz then
    for Y, cy in ipairs(cz:GetChildren()) do
      if fi(cy) then
        return cy
      end
    end
  end
  return nil
end
function id:iP()
  if not self.id_eefb95 or self.sX then
    return
  end
  local bm = P.Character
  local bn = bh(P)
  if not (bm and bn and bn.Health > 0) then
    return
  end
  local gI = self:Ah()
  if not gI then
    return
  end
  local en = self:AF()
  if not (en and en.Parent) then
    return
  end
  local gy = f_.LR()
  I4:Set(gy and en or nil)
  I4:Ip(true)
  self.sX = true
  task.spawn(function()
    local cz = P:FindFirstChildOfClass("Backpack")
    local gJ = gI.Parent == bm
    pcall(function()
      if not gJ then
        bn:EquipTool(gI)
        task.wait(id.Uw)
      end
      gI:Activate()
    end)
    task.wait(id.GP)
    if not gJ and gI.Parent == P.Character and cz then
      pcall(function()
        gI.Parent = cz
      end)
    end
    I4:Set(nil)
    I4:Ip(false)
    self.sX = false
  end)
end
function id:tO(bw)
  self.vy = (self.vy or 0) + bw
  if self.vy < id.gT then
    return
  end
  self.vy = 0
  self.qr = self:kk()
end
function id:id_c6a804()
  if not I4:PT("Macro") then
    return
  end
  if self.id_eefb95 then
    return
  end
  self.id_eefb95 = true
  self.vy = 0
  self.sX = false
  self.qr = nil
  self.z3:id_d91afa(L.Heartbeat:Connect(function(bw)
    if self.id_eefb95 then
      self:tO(bw)
    end
  end))
  self.z3:id_d91afa(M.InputBegan:Connect(function(aN, gK)
    if not self.id_eefb95 or gK then
      return
    end
    if aN.UserInputType == Enum.UserInputType.MouseButton1 then
      self:iP()
    elseif aN.UserInputType == Enum.UserInputType.Touch then
      self.qm = aN.Position
      self.Wi = os.clock()
    end
  end))
  self.z3:id_d91afa(M.InputEnded:Connect(function(aN, gK)
    if not self.id_eefb95 or gK or aN.UserInputType ~= Enum.UserInputType.Touch then
      return
    end
    if not self.qm then
      return
    end
    local gL = (aN.Position - self.qm).Magnitude
    local gM = os.clock() - (self.Wi or 0)
    self.qm = nil
    if gL < id.Sa and gM < id.u_ then
      self:iP()
    end
  end))
end
function id:id_d7eac1()
  if not self.id_eefb95 then
    return
  end
  self.id_eefb95 = false
  self.qr = nil
  self.qm = nil
  I4:Set(nil)
  I4:Ip(false)
  self.z3:id_e2a4c4()
end
ug = id.new()
local gN = {}
gN.__index = gN
function gN.new()
  return setmetatable({ z3 = a3.new(), Ay = nil, q8 = nil, mB = false }, gN)
end
function gN:gk()
  if type(gethui) == "function" then
    local R, e1 = pcall(gethui)
    if R and e1 then
      return e1
    end
  end
  local R, e2 = pcall(function()
    return game:GetService("CoreGui")
  end)
  if R and e2 then
    return e2
  end
  return P:FindFirstChild("PlayerGui")
end
function gN:RO()
  if self.q8 and self.q8.Parent then
    return self.q8
  end
  local R, gO = pcall(function()
    local gP = Instance.new("ScreenGui")
    gP.Name = "dc697c096e046b9920d0"
    gP.ResetOnSpawn = false
    gP.IgnoreGuiInset = true
    gP.DisplayOrder = 7 * 142857
    gP.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gP.Enabled = false
    gP.Parent = self:gk()
    local gQ = Instance.new("Frame")
    gQ.Name = "Ring"
    gQ.AnchorPoint = Vector2.new(0.5, 0.5)
    gQ.BackgroundTransparency = 1
    gQ.BorderSizePixel = 0
    gQ.Size = UDim2.fromOffset(5 * 80, 450 - 50)
    gQ.Parent = gP
    local aE = Instance.new("UICorner")
    aE.CornerRadius = UDim.new(1, 0)
    aE.Parent = gQ
    local aA = Instance.new("UIStroke")
    aA.Thickness = 1.5
    aA.Color = Color3.fromRGB(255, 255, 255)
    aA.Transparency = 0
    aA.Parent = gQ
    self.Ay = gP
    return gQ
  end)
  if R and gO then
    self.q8 = gO
    self.z3:id_d91afa(self.Ay)
    return gO
  end
  return nil
end
function gN:mb()
  self.q8 = nil
  local gP = self.Ay
  self.Ay = nil
  if gP then
    pcall(function()
      gP:Destroy()
    end)
  end
end
function gN:pd()
  return a8.id_c1632a.id_b7ba43 == true and a8.id_c1632a.id_e82f73 == true
end
function gN:WH()
  if not self:pd() then
    if self.Ay then
      self.Ay.Enabled = false
    end
    return
  end
  local gO = self:RO()
  if not gO then
    return
  end
  local gR = c1()
  local gS = math.max(1, tonumber(a8.id_c1632a.id_f2d9c0) or 200)
  gO.Size = UDim2.fromOffset(gS * 2, gS * 2)
  gO.Position = UDim2.fromOffset(gR.X, gR.Y)
  self.Ay.Enabled = true
end
function gN:Start()
  if self.mB then
    return
  end
  self.mB = true
  self.z3:id_d91afa(L.RenderStepped:Connect(function()
    self:WH()
  end))
end
function gN:Destroy()
  self.mB = false
  self.z3:id_e2a4c4()
  self:mb()
end
local gT = gN.new()
gT:Start()
pcall(function()
  getgenv()[H] = function()
    I = true
    a8.id_db7d1a.id_eac970 = false
    a8.id_db7d1a.id_a0792b = false
    a8.id_c1632a.id_b385e1 = false
    a8.id_c1632a.id_fda17e = false
    a8.id_c1632a.id_b0732d = false
    a8.id_c1632a.id_df8e49 = false
    a8.id_c1632a.id_d741b8 = false
    if fb then
      fb:id_d7eac1()
    end
    if fc then
      fc:id_d7eac1()
    end
    if fU then
      fU:id_d7eac1()
    end
    if fZ then
      fZ:id_d7eac1()
    end
    if gs then
      gs:id_d7eac1()
    end
    if Aa then
      Aa:id_d7eac1()
    end
    if ug then
      ug:id_d7eac1()
    end
    if gT then
      gT:Destroy()
    end
  end
end)
local gU = {}
gU.__index = gU
function gU.new()
  return setmetatable({ id_eefb95 = false, z3 = a3.new(), HE = nil, Th = nil }, gU)
end
function gU:gy()
  return aZ(P)
end
function gU:o6(bn)
  if not bn or bn == self.HE then
    return
  end
  self.HE = bn
  self.Th = { UseJumpPower = bn.UseJumpPower, JumpPower = bn.JumpPower, JumpHeight = bn.JumpHeight }
end
function gU:sF()
  local bf = P.Character
  if not bf then
    return nil
  end
  local bn = bf:FindFirstChildOfClass("Humanoid")
  if bn then
    self:o6(bn)
  end
  return bn
end
function gU:Rb(bn)
  bn = bn or self:sF()
  if not bn or not self.Th then
    return
  end
  pcall(function()
    bn.UseJumpPower = self.Th.UseJumpPower
    if self.Th.UseJumpPower then
      bn.JumpPower = self.Th.JumpPower
    else
      bn.JumpHeight = self.Th.JumpHeight
    end
  end)
end
function gU:dq(bn)
  bn = bn or self:sF()
  if not bn then
    return
  end
  self:o6(bn)
  if a8.id_c2960b.id_fa7ccf and self:gy() then
    local gV = math.max(0, tonumber(a8.id_c2960b.id_f4716b) or 25)
    pcall(function()
      bn.UseJumpPower = true
      bn.JumpPower = gV * 2
    end)
  else
    self:Rb(bn)
  end
end
function gU:id_ae5ef0()
  local gX = a8.id_c2960b.id_fa7ccf or a8.id_c2960b.id_d21688
  if gX then
    self:id_c6a804()
  else
    self:id_d7eac1()
    return
  end
  self:dq()
end
function gU:id_c6a804()
  if self.id_eefb95 then
    return
  end
  self.id_eefb95 = true
  self.z3:id_d91afa(bx:id_a7a13d(function()
    if not self.id_eefb95 then
      return
    end
    self:dq()
  end))
  self.z3:id_d91afa(P.CharacterAdded:Connect(function(bf)
    task.defer(function()
      local bn = a_(bf, "Humanoid", 5)
      if bn and bn:IsA("Humanoid") then
        self.HE = nil
        self:dq(bn)
      end
    end)
  end))
  self.z3:id_d91afa(M.JumpRequest:Connect(function()
    if not a8.id_c2960b.id_d21688 then
      return
    end
    if not self:gy() then
      return
    end
    local bn = self:sF()
    if not bn then
      return
    end
    pcall(function()
      bn:ChangeState(Enum.HumanoidStateType.Jumping)
    end)
  end))
end
function gU:id_d7eac1()
  if not self.id_eefb95 then
    self:Rb()
    return
  end
  self.id_eefb95 = false
  self.z3:id_e2a4c4()
  self:Rb()
end
local gY = gU.new()
local gZ = {}
gZ.__index = gZ
function gZ.new()
  return setmetatable({ id_eefb95 = false, z3 = a3.new(), HE = nil, kg = nil, gb = nil, UQ = nil }, gZ)
end
function gZ:zK(bn)
  if not bn or bn == self.HE then
    return
  end
  self.HE = bn
  self.kg = bn.WalkSpeed
end
function gZ:xR()
  return math.max(0, tonumber(a8.id_c2960b.id_ba7ec6) or 24)
end
function gZ:gy()
  return aZ(P)
end
function gZ:f3()
  if self.gb then
    pcall(function()
      self.gb:Disconnect()
    end)
    self.gb = nil
  end
  self.UQ = nil
end
function gZ:Bo(bn)
  if not bn or bn == self.UQ then
    return
  end
  self:f3()
  self.UQ = bn
  self.gb = bn:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    if not self.id_eefb95 or not a8.id_c2960b.id_d05c51 then
      return
    end
    if not self:gy() then
      return
    end
    local g_ = self:xR()
    if math.abs((tonumber(bn.WalkSpeed) or 0) - g_) > 0.01 then
      pcall(function()
        bn.WalkSpeed = g_
      end)
    end
  end)
end
function gZ:sF()
  local bf = P.Character
  if not bf then
    return nil
  end
  local bn = bf:FindFirstChildOfClass("Humanoid")
  if bn then
    self:zK(bn)
  end
  return bn
end
function gZ:dq(bn)
  bn = bn or self:sF()
  if not bn then
    return
  end
  self:zK(bn)
  self:Bo(bn)
  if a8.id_c2960b.id_d05c51 and self:gy() then
    local dC = self:xR()
    pcall(function()
      bn.WalkSpeed = dC
    end)
  else
    self:Rb(bn)
  end
end
function gZ:Rb(bn)
  bn = bn or self:sF()
  if not bn or self.kg == nil then
    return
  end
  pcall(function()
    bn.WalkSpeed = self.kg
  end)
end
function gZ:id_ae5ef0()
  if a8.id_c2960b.id_d05c51 then
    self:id_c6a804()
    self:dq()
  else
    self:id_d7eac1()
  end
end
function gZ:id_c6a804()
  if self.id_eefb95 then
    return
  end
  self.id_eefb95 = true
  self.z3:id_d91afa(bx:id_a7a13d(function()
    if not self.id_eefb95 then
      return
    end
    if a8.id_c2960b.id_d05c51 then
      self:dq()
    else
      self:Rb()
    end
  end))
  self.z3:id_d91afa(P.CharacterAdded:Connect(function(bf)
    task.defer(function()
      local bn = a_(bf, "Humanoid", 5)
      if bn and bn:IsA("Humanoid") then
        self.HE = nil
        self:dq(bn)
      end
    end)
  end))
end
function gZ:id_d7eac1()
  if not self.id_eefb95 then
    self:Rb()
    return
  end
  self.id_eefb95 = false
  self:f3()
  self.z3:id_e2a4c4()
  self:Rb()
end
local h0 = gZ.new()
local h1 = {}
h1.__index = h1
local h2 = Vector3.new(16, 1, 16)
local h3 = 4
local h4 = -200
local h5 = 2000
local h6 = 3
local h7 = 0.15
function h1.new()
  return setmetatable({
    id_eefb95 = false,
    fn = false,
    z3 = a3.new(),
    vM = nil,
    Vl = nil,
    mq = nil,
    YB = nil,
    BW = {},
  }, h1)
end
function h1:uD()
  local bf = P.Character
  if not bf then
    return nil
  end
  local bl = bf:FindFirstChild("HumanoidRootPart")
  if bl and bl:IsA("BasePart") then
    return bl
  end
  return nil
end
function h1:v5(bf, b2)
  bf = bf or P.Character
  if not bf then
    return nil
  end
  local bl = bf:FindFirstChild("HumanoidRootPart")
  if bl then
    return bl
  end
  local R, dr = pcall(function()
    return bf:WaitForChild("HumanoidRootPart", b2 or 5)
  end)
  if R then
    return dr
  end
  return nil
end
function h1:gy()
  return aZ(P)
end
function h1:qL()
  local gE = math.clamp(tonumber(a8.id_d20c9a.id_fb990f) or 0, h4, h5)
  a8.id_d20c9a.id_fb990f = gE
  return math.clamp((self.Vl or 0) + gE, h4, h5)
end
function h1:du()
  if self.vM and self.vM.Parent then
    return self.vM
  end
  local h8 = Instance.new("Part")
  h8.Name = "c3e5c8f38004b0debeff"
  h8.Size = h2
  h8.Anchored = true
  h8.CanCollide = true
  h8.Transparency = 1
  h8.Material = Enum.Material.SmoothPlastic
  h8.Parent = workspace
  self.vM = h8
  return h8
end
function h1:yG()
  if self.vM then
    pcall(function()
      self.vM:Destroy()
    end)
    self.vM = nil
  end
end
function h1:Xo()
  if not self.id_eefb95 then
    return
  end
  local bl = self:uD()
  if not bl then
    return
  end
  if not self.Vl then
    self.Vl = bl.Position.Y - h3
  end
  local h8 = self:du()
  h8.CFrame = CFrame.new(bl.Position.X, self:qL(), bl.Position.Z)
end
function h1:_6(bl)
  if not bl or not self.Vl then
    return
  end
  local dF = self:qL()
  bl.AssemblyLinearVelocity = Vector3.zero
  bl.AssemblyAngularVelocity = Vector3.zero
  if bl.Position.Y < dF + h3 then
    bl.CFrame = CFrame.new(bl.Position.X, dF + h3, bl.Position.Z)
  end
end
function h1:bN(bf)
  if not self.id_eefb95 then
    return
  end
  local bl = self:v5(bf, 5)
  if not bl then
    return
  end
  a8.id_d20c9a.id_fb990f = 0
  self.Vl = bl.Position.Y - h3
  self:du()
  self:Xo()
  self:_6(bl)
  task.spawn(function()
    local h9 = os.clock()
    while self.id_eefb95 and os.clock() - h9 < h6 do
      local ha = self:uD()
      if ha then
        self.Vl = ha.Position.Y - h3
        self:Xo()
        self:_6(ha)
      end
      task.wait(h7)
    end
  end)
end
function h1:Qn()
  if self.YB and self.YB.Parent then
    return self.YB
  end
  local e3 = Instance.new("Folder")
  e3.Name = "f71a668e309982131900"
  e3.Parent = O
  self.YB = e3
  return e3
end
local hb = { "Collisions", "Map", "Spawns", "GeometryBundles" }
function h1:IM()
  if not self:gy() then
    return nil
  end
  local hc = workspace:FindFirstChild("ActiveMaps")
  if not hc then
    return nil
  end
  local hd = P:GetAttribute("MatchId")
  if typeof(hd) == "string" and hd ~= "" then
    local c4 = hc:FindFirstChild(hd)
    local he = c4 and c4:FindFirstChild("Map")
    if he and #he:GetChildren() > 0 then
      return c4, hd
    end
  end
  local bl = be(P)
  local hf = bl and bl.Position
  local hg, hh, hi = nil, nil, nil
  for Y, c4 in ipairs(hc:GetChildren()) do
    local he = c4:FindFirstChild("Map")
    if he and #he:GetChildren() > 0 then
      local hj = 0
      if hf then
        local R, dD = pcall(function()
          return c4:GetBoundingBox()
        end)
        hj = R and dD and (dD.Position - hf).Magnitude or math.huge
      end
      if hi == nil or hj < hi then
        hg, hh, hi = c4, c4.Name, hj
      end
    end
  end
  if hg then
    return hg, hh
  end
  return nil
end
function h1:t5()
  local c4, f7 = self:IM()
  if not c4 then
    self.fn = false
    return
  end
  self:AT()
  local hk = self:Qn()
  for Y, hl in ipairs(hb) do
    local e3 = c4:FindFirstChild(hl)
    if e3 then
      self.BW[e3] = e3.Parent
      e3.Parent = hk
    end
  end
  self.mq = f7
  self.fn = true
end
function h1:Zo()
  if not self.fn then
    return
  end
  local hm = P:GetAttribute("MatchId")
  if not self:gy() or tostring(hm) ~= tostring(self.mq) then
    self:AT()
  end
end
function h1:AT()
  for aW, hn in pairs(self.BW) do
    if aW and aW.Parent then
      local ho = false
      pcall(function()
        ho = hn ~= nil and hn:IsDescendantOf(game)
      end)
      if ho then
        pcall(function()
          aW.Parent = hn
        end)
      else
        pcall(function()
          aW:Destroy()
        end)
      end
    end
  end
  table.clear(self.BW)
  self.mq = nil
  self.fn = false
  if self.YB and self.YB.Parent and #self.YB:GetChildren() == 0 then
    pcall(function()
      self.YB:Destroy()
    end)
    self.YB = nil
  end
end
function h1:id_c04e86(e5)
  a8.id_d20c9a.id_bac88e = e5 == true
  if a8.id_d20c9a.id_bac88e then
    if not a8.id_d20c9a.Enabled then
      a8.id_d20c9a.Enabled = true
      ax(Bz, true)
    end
    self:id_c6a804()
    self:t5()
  else
    self:AT()
  end
end
function h1:ChangeHeight(aP)
  local bl = self:uD()
  if not self.Vl then
    self.Vl = bl and bl.Position.Y - h3 or 0
  end
  local hp = math.clamp((tonumber(a8.id_d20c9a.id_fb990f) or 0) + aP, h4 - self.Vl, h5 - self.Vl)
  local hq = hp - (tonumber(a8.id_d20c9a.id_fb990f) or 0)
  a8.id_d20c9a.id_fb990f = hp
  if bl and math.abs(hq) > 0 then
    bl.AssemblyLinearVelocity = Vector3.zero
    bl.AssemblyAngularVelocity = Vector3.zero
    bl.CFrame = bl.CFrame + Vector3.new(0, hq, 0)
  end
  self:Xo()
end
function h1:id_ae5ef0()
  if a8.id_d20c9a.Enabled then
    self:id_c6a804()
  else
    self:id_d7eac1()
  end
  self:id_c04e86(a8.id_d20c9a.id_bac88e)
end
function h1:id_c6a804()
  if self.id_eefb95 then
    self:Xo()
    return
  end
  self.id_eefb95 = true
  a8.id_d20c9a.id_fb990f = 0
  local bl = self:v5(P.Character, 5)
  if bl then
    self.Vl = bl.Position.Y - h3
  end
  self:du()
  self:Xo()
  self.z3:id_d91afa(L.Heartbeat:Connect(function()
    self:Xo()
    if a8.id_d20c9a.id_bac88e and not self.fn then
      self:t5()
    end
  end))
  self.z3:id_d91afa(P.CharacterAdded:Connect(function(bf)
    self:bN(bf)
  end))
  self.z3:id_d91afa(bx:id_a7a13d(function()
    self:Zo()
  end))
end
function h1:id_d7eac1()
  if a8.id_d20c9a.id_bac88e then
    a8.id_d20c9a.Enabled = true
    ax(Bz, true)
    return
  end
  if not self.id_eefb95 then
    self:yG()
    return
  end
  self.id_eefb95 = false
  self.z3:id_e2a4c4()
  self.Vl = nil
  a8.id_d20c9a.id_fb990f = 0
  self:yG()
end
function h1:Destroy()
  a8.id_d20c9a.id_bac88e = false
  self:AT()
  if self.YB and self.YB.Parent then
    pcall(function()
      self.YB:Destroy()
    end)
    self.YB = nil
  end
  self.id_eefb95 = false
  self.z3:id_e2a4c4()
  self.Vl = nil
  a8.id_d20c9a.id_fb990f = 0
  self:yG()
end
local hr = h1.new()
local hs = {}
hs.__index = hs
local ht = {
  "Knife Box #1",
  "Knife Box #2",
  "Gun Box #1",
  "Gun Box #2",
  "Mythic Box #1",
  "Mythic Box #2",
  "Mythic Box #3",
  "Mythic Box #4",
}
local function hu(fn)
  if type(fn) == "string" and string.find(fn, "Mythic", 1, true) then
    return 52 + 1448
  end
  return 468 + 32
end
local function hv(fn)
  if type(fn) ~= "string" or fn == "" then
    return
  end
  a8.id_eb081e.Selected = fn
  a8.id_eb081e.id_aad55a = hu(fn)
end
function hs.new()
  return setmetatable({ id_eefb95 = false, z3 = a3.new(), vy = 0, qz = nil }, hs)
end
function hs:Ye()
  if self.qz and self.qz.Parent then
    return self.qz
  end
  local b7 = N:FindFirstChild("Packages") or a_(N, "Packages", 2)
  local b8 = b7 and (b7:FindFirstChild("Networking") or a_(b7, "Networking", 2))
  local bd = b8 and (b8:FindFirstChild("RF/Shop/BuyCase") or a_(b8, "RF/Shop/BuyCase", 2))
  if bd and bd:IsA("RemoteFunction") then
    self.qz = bd
    return bd
  end
  local hw = b5("BuyCase", 2)
  if hw and hw:IsA("RemoteFunction") then
    self.qz = hw
    return hw
  end
  return nil
end
function hs:jg()
  local cK = P:FindFirstChild("Cash")
  if cK and (cK:IsA("IntValue") or cK:IsA("NumberValue")) then
    return tonumber(cK.Value)
  end
  local cL = P:FindFirstChild("leaderstats")
  if cL then
    for Y, hx in ipairs({ "Cash", "Coins", "Money" }) do
      local cM = cL:FindFirstChild(hx)
      if cM and (cM:IsA("IntValue") or cM:IsA("NumberValue")) then
        return tonumber(cM.Value)
      end
    end
  end
  for Y, hy in ipairs({ "Cash", "Coins", "Money" }) do
    local hz = tonumber(P:GetAttribute(hy))
    if hz ~= nil then
      return hz
    end
  end
  return nil
end
function hs:id_d08e5f()
  local bd = self:Ye()
  if not bd then
    return false, "missing_remote"
  end
  local ap = tostring(a8.id_eb081e.Selected or "")
  if ap == "" then
    return false, "missing_selection"
  end
  local hA = tonumber(a8.id_eb081e.id_aad55a) or hu(ap)
  local hB = self:jg()
  if hB and hB < hA then
    return false, "insufficient_cash"
  end
  local R = pcall(function()
    bd:InvokeServer(ap)
  end)
  if not R then
    return false, "invoke_failed"
  end
  return true, "ok"
end
function hs:tO(bw)
  self.vy = self.vy + bw
  if self.vy < 1 then
    return
  end
  self.vy = 0
  self:id_d08e5f()
end
function hs:id_c6a804()
  if self.id_eefb95 then
    return
  end
  self.id_eefb95 = true
  self.vy = 0
  self.z3:id_d91afa(L.Heartbeat:Connect(function(bw)
    if not self.id_eefb95 then
      return
    end
    self:tO(bw)
  end))
end
function hs:id_d7eac1()
  if not self.id_eefb95 then
    return
  end
  self.id_eefb95 = false
  self.z3:id_e2a4c4()
end
local hC = hs.new()
hv(a8.id_eb081e.Selected)
local hD = G:CreateWindow({
  Title = "Murderers VS Sheriffs",
  Icon = "swords",
  Author = "RysHub 🇦🇷",
  Folder = "Ryshub/Configs",
  Theme = "Dark",
  NewElements = true,
})
hD:Tag({ Title = "v4.4.0 16/08", Icon = "github", Color = Color3.fromHex("#4FC3F7"), Radius = 13 })
hD:EditOpenButton({
  Title = "RysHub",
  Icon = "",
  CornerRadius = UDim.new(0, 16),
  StrokeThickness = 2,
  Color = ColorSequence.new(Color3.fromHex("FF0F7B"), Color3.fromHex("F89B29")),
  OnlyMobile = true,
  Enabled = true,
  Draggable = true,
})
local hE = hD.ConfigManager
local hF = hE:CreateConfig("bfeef630676ef2d1fc6fcd0c7f25")
local hG = false
local hH = true
local function hI()
  if not hG and not hH then
    hF:Save()
  end
end
local function hJ(hK, ab)
  if not hK then
    return false
  end
  if hK.SetToggleKey then
    local R = pcall(function()
      hK:SetToggleKey(ab)
    end)
    if R then
      return true
    end
  end
  if hK.SetValue then
    local R = pcall(function()
      hK:SetValue(ab)
    end)
    if R then
      return true
    end
  end
  if hK.Set then
    local R = pcall(function()
      hK:Set(ab)
    end)
    if R then
      return true
    end
  end
  return false
end
local hL = 0
u5 = L.Heartbeat:Connect(function(bw)
  hL = hL + bw
  if hL < 5 then
    return
  end
  hL = 0
  hI()
end)
local hM = hD:Tab({ Title = "Settings", Icon = "cog" })
hM:Select()
hM:Toggle({
  Title = "loc:f4a3863c373d15c1f0f057a0d262b1f3",
  Desc = "loc:e00aede412f4e0fa8adac1db28824008",
  Value = false,
  Callback = function(hN)
    V.i1(hN)
    if av.id_a79299 or hG or hH then
      return
    end
    if hN then
      G:Notify({
        Title = "Bubbles",
        Content = "Edit mode ON. Drag the bubbles, then turn this off to save.",
        Icon = "move",
        Duration = 4,
      })
    else
      G:Notify({ Title = "Bubbles", Content = "Bubble positions saved.", Icon = "check", Duration = 3 })
    end
  end,
})
hM:Button({
  Title = "loc:aa5920a455bff5305f21430c2a5ca989",
  Desc = "loc:c40968cf77426597fc1002e19ba13c70",
  Callback = function()
    V.P7()
    G:Notify({ Title = "Bubbles", Content = "Bubble positions reset to default.", Icon = "rotate-ccw", Duration = 3 })
  end,
})
hM:Space()
hM:Paragraph({
  Title = "loc:b5548857bfbe74e3a90f2f2a91fd521b",
  Thumbnail = "https://i.pinimg.com/736x/35/ee/85/35ee85bde9ee7e0d3a5d976ea2788c43.jpg",
  ThumbnailSize = 56,
  Buttons = {
    {
      Title = "Copy Discord Invite",
      Callback = function()
        if setclipboard then
          setclipboard(F)
          G:Notify({
            Title = "Discord Invite",
            Content = "Discord link copied to clipboard!",
            Duration = 3,
            Icon = "link",
          })
        else
          G:Notify({ Title = "Discord Invite", Content = F })
        end
      end,
    },
  },
})
hM:Space()
local hO = hM:Toggle({
  Title = "loc:af644bdec3050256e4b089633ec7c1bb",
  Flag = "bc32704af9fc342e554ca987b9c2e630",
  Value = true,
  Callback = function(hN)
    hD:SetPanelBackground(hN)
    hI()
  end,
})
local hP = hM:Toggle({
  Title = "loc:e5a0ad311db35c09d2a8d31d61682588",
  Flag = "d2510fc563adef1efb8d01411bbd67fb",
  Value = false,
  Callback = function(hN)
    a8.id_db8efe.id_a04ad4 = hN
    hI()
  end,
})
local hR = hM:Dropdown({
  Title = "loc:ad3272e69caac43330718b23d4955751",
  Flag = "fb601a6c2a8b2c20a716f3fc5397cd24",
  Values = { "English", "Espanol" },
  Value = ad(),
  Callback = function(hS)
    local hT = ah(hS)
    ao()
    au()
    if not hG and not hH then
      G:Notify({
        Title = ai("id_c2849a"),
        Content = ai("id_fcd3a1", hT),
        Icon = "languages",
        Duration = 3,
      })
    end
    hI()
  end,
})
hM:Space()
local hU = hM:Keybind({
  Title = "loc:e79ad110a867753729b046fb34f41cd0",
  Flag = "ae7e2edd09a3339eadd9477e9ef4b755",
  Value = a8.id_f749bd.id_b965cd,
  Callback = function(hV)
    hD:SetToggleKey(Enum.KeyCode[hV])
    hI()
  end,
})
hM:Button({
  Title = "loc:f0ef1a4885fed39ccf4049e5ae59c844",
  Desc = "loc:c860ffe2aa0bc8f2f19751378a6d513b",
  Callback = function()
    local R = hJ(hU, a8.id_f749bd.id_b965cd)
    hD:SetToggleKey(Enum.KeyCode[a8.id_f749bd.id_b965cd])
    hI()
    if R then
      G:Notify({
        Title = "Keybind Reset",
        Content = "Toggle UI keybind reset to default.",
        Icon = "check",
        Duration = 3,
      })
    else
      G:Notify({
        Title = "Keybind Reset",
        Content = "No setter in WindUI. Click the keybind and press RightControl.",
        Icon = "alert-triangle",
        Duration = 4,
      })
    end
  end,
})
hM:Button({
  Title = "loc:d9aa593520ade55efa3d5e80a07b4cf4",
  Desc = "loc:e1ec8181631ee4df350de6caf9d8602a",
  Callback = function()
    local R, ga, hW = pcall(NS)
    hI()
    if not R then
      G:Notify({
        Title = "Keybind Reset",
        Content = "Could not reset all keybinds: " .. tostring(ga),
        Icon = "alert-triangle",
        Duration = 4,
      })
      return
    end
    local hY = hW or 0
    if hY > 0 then
      local hZ = (ga or 0) - hY
      G:Notify({
        Title = "Keybind Reset",
        Content = ("Reset with issues (%d/%d applied)."):format(hZ, ga or 0),
        Icon = "alert-triangle",
        Duration = 4,
      })
    else
      G:Notify({ Title = "Keybind Reset", Content = "All keybinds reset to default.", Icon = "check", Duration = 3 })
    end
  end,
})
hM:Space()
hM:Divider()
hM:Space()
function xp()
  pcall(hI)
  local h_ = nil
  pcall(function()
    h_ = getgenv()[H]
  end)
  if type(h_) ~= "function" then
    return false
  end
  pcall(h_)
  pcall(function()
    getgenv()[H] = nil
  end)
  if not pcall(function()
    hD:Destroy()
  end) then
    pcall(function()
      hD:Close()
    end)
  end
  return true
end
hM:Button({
  Title = "loc:b06dde438a08f90c210d3de482271695",
  Desc = "loc:f05c53f426488e96cb51805e5ff6cca9",
  Callback = function()
    if not G or type(G.Popup) ~= "function" then
      xp()
      return
    end
    local bN = pcall(function()
      G:Popup({
        Title = ai("id_e78f80"),
        Icon = "log-out",
        Content = ai("id_a5c3a6"),
        Buttons = {
          { Title = ai("id_efdbbd"), Variant = "Tertiary" },
          {
            Title = ai("id_fefe73"),
            Icon = "arrow-right",
            Variant = "Primary",
            Callback = function()
              if not xp() then
                bD(ai("id_e78f80"), ai("id_a930a6"), "alert-triangle", 4)
              end
            end,
          },
        },
      })
    end)
    if not bN then
      xp()
    end
  end,
})
function V.sg()
  local i0 = {}
  for aj, i1 in pairs(V.D7) do
    if typeof(i1) == "UDim2" then
      i0[aj] = { i1.X.Scale, i1.X.Offset, i1.Y.Scale, i1.Y.Offset }
    end
  end
  hF:Set("ab9c7b69553f83b71e4db8c6b061", i0)
  if av.id_a79299 or hG or hH then
    return
  end
  hI()
end
function V.i1(e5)
  V.OH = e5 == true
  V.P_()
  if not V.OH then
    V.sg()
  end
end
function V.P7()
  for aj, i2 in pairs(V.Th) do
    V.D7[aj] = nil
    local az = V.Pd[aj]
    if i2 and az and az.Parent then
      az.Position = i2
    end
  end
  hF:Set("ab9c7b69553f83b71e4db8c6b061", {})
  if av.id_a79299 or hG or hH then
    return
  end
  hI()
end
hD:Divider()
local i3 = hD:Tab({ Title = "Player Cheats", Icon = "user" })
local i4 = 4
Bz = nil
xS = nil
Ef = nil
GC = nil
G6 = nil
aB = nil
Uc = nil
uW = nil
u2 = nil
zF = nil
EN = nil
EL = nil
vU = nil
WA = nil
ne = nil
CP = nil
Mi = nil
ki = nil
qM = nil
Tu = nil
G7 = nil
hX = nil
Jf = nil
e_ = false
zU = 0
QY = nil
RU = nil
qB = nil
nh = nil
gW = nil
w6 = nil
YP = nil
_h = nil
a4 = nil
nN = nil
MJ = nil
jr = nil
KR = nil
t8 = nil
yV = nil
K5 = nil
IX = nil
function Y5(i5, i6)
  if not i5 then
    return
  end
  local i7 = i6 and "Lock" or "Unlock"
  if type(i5[i7]) == "function" then
    local R = pcall(function()
      i5[i7](i5)
    end)
    if R then
      return
    end
  end
  if type(i5.SetLocked) == "function" then
    local R = pcall(function()
      i5:SetLocked(i6)
    end)
    if R then
      return
    end
  end
  pcall(function()
    i5.Locked = i6
  end)
end
function Nl(ab)
  a8.id_c1632a.id_e1993c = ab
  if ab then
    WV:id_c6a804()
  else
    WV:id_d7eac1()
  end
  if hX then
    ax(hX, ab)
  end
  if gW then
    gW()
  end
end
function mn()
  zU = (zU or 0) + 1
  local i8 = zU
  task.spawn(function()
    while e_ and i8 == zU and not I do
      if not a8.id_c1632a.id_e1993c or not WV.id_eefb95 then
        pcall(Nl, true)
      end
      task.wait(1)
    end
  end)
end
local function i9()
  if e_ then
    return
  end
  local ia = not a8.id_c1632a.id_e1993c
  a8.id_c1632a.id_e1993c = ia
  if hX then
    hX:Set(ia)
  end
  if gW then
    gW()
  end
end
gW = function()
  if not nh then
    return
  end
  nh.Text = "KA"
  if a8.id_c1632a.id_e1993c then
    nh.BackgroundColor3 = Color3.fromRGB(30, 156, 88)
    nh.TextColor3 = Color3.fromRGB(255, 255, 266 - 11)
  else
    nh.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    nh.TextColor3 = Color3.fromRGB(235, 235, 47 * 5)
  end
end
RU = function()
  if a8.id_a627a2.id_b739bd ~= true then
    if qB then
      pcall(function()
        qB:Destroy()
      end)
      qB = nil
      nh = nil
    end
    return
  end
  local ct = P:FindFirstChildOfClass("PlayerGui")
  if not ct then
    ct = a_(P, "PlayerGui", 10)
  end
  if not ct then
    task.delay(1, function()
      if a8.id_a627a2.id_b739bd and RU then
        pcall(RU)
      end
    end)
    return
  end
  local ib = ct:FindFirstChild("c62869b994494733ccac")
  if ib then
    pcall(function()
      ib:Destroy()
    end)
  end
  local gP = Instance.new("ScreenGui")
  gP.Name = "c62869b994494733ccac"
  gP.ResetOnSpawn = false
  gP.IgnoreGuiInset = true
  gP.DisplayOrder = 2147483646
  gP.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  gP.Parent = ct
  local az = Instance.new("TextButton")
  az.Name = "Button"
  az.AnchorPoint = Vector2.new(1, 1)
  az.Position = UDim2.new(1, -12, 1, -(47 + 141))
  az.Size = UDim2.new(0, 48, 0, 48)
  az.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
  az.BorderSizePixel = 0
  az.AutoButtonColor = true
  az.Font = Enum.Font.GothamBold
  az.TextSize = 12
  az.TextWrapped = true
  az.Text = "KA"
  az.TextColor3 = Color3.fromRGB(235, 235, 235)
  az.Parent = gP
  local aE = Instance.new("UICorner")
  aE.CornerRadius = UDim.new(1, 0)
  aE.Parent = az
  local aA = Instance.new("UIStroke")
  aA.Thickness = 1
  aA.Color = Color3.fromRGB(115, 151 - 36, 5 * 23)
  aA.Parent = az
  aC(az, i9)
  qB = gP
  nh = az
  gW()
end
local function ic()
  local ia = not a8.id_c1632a.id_c41ca6
  a8.id_c1632a.id_c41ca6 = ia
  if w6 then
    w6:Set(ia)
  end
  if MJ then
    MJ()
  end
end
MJ = function()
  if not nN then
    return
  end
  nN.Text = "INV"
  if a8.id_c1632a.id_c41ca6 then
    nN.BackgroundColor3 = Color3.fromRGB(30, 156, 88)
    nN.TextColor3 = Color3.fromRGB(115 + 140, 255, 48 + 207)
  else
    nN.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    nN.TextColor3 = Color3.fromRGB(235, 126 + 109, 287 - 52)
  end
end
_h = function()
  if a8.id_a627a2.id_cc0919 ~= true then
    if a4 then
      pcall(function()
        a4:Destroy()
      end)
      a4 = nil
      nN = nil
    end
    return
  end
  local ct = P:FindFirstChildOfClass("PlayerGui")
  if not ct then
    ct = a_(P, "PlayerGui", 10)
  end
  if not ct then
    task.delay(1, function()
      if a8.id_a627a2.id_cc0919 and _h then
        pcall(_h)
      end
    end)
    return
  end
  local ib = ct:FindFirstChild("f67221be3a35218754c0")
  if ib then
    pcall(function()
      ib:Destroy()
    end)
  end
  local gP = Instance.new("ScreenGui")
  gP.Name = "f67221be3a35218754c0"
  gP.ResetOnSpawn = false
  gP.IgnoreGuiInset = true
  gP.DisplayOrder = 2147483646
  gP.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  gP.Parent = ct
  local az = Instance.new("TextButton")
  az.Name = "Button"
  az.AnchorPoint = Vector2.new(1, 1)
  az.Position = UDim2.new(1, -12, 1, -244)
  az.Size = UDim2.new(0, 48, 0, 48)
  az.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
  az.BorderSizePixel = 0
  az.AutoButtonColor = true
  az.Font = Enum.Font.GothamBold
  az.TextSize = 12
  az.TextWrapped = true
  az.Text = "INV"
  az.TextColor3 = Color3.fromRGB(235, 235, 235)
  az.Parent = gP
  local aE = Instance.new("UICorner")
  aE.CornerRadius = UDim.new(1, 0)
  aE.Parent = az
  local aA = Instance.new("UIStroke")
  aA.Thickness = 1
  aA.Color = Color3.fromRGB(115, 4 + 111, 115)
  aA.Parent = az
  aC(az, ic)
  a4 = gP
  nN = az
  MJ()
end
local function ie()
  local ia = not a8.id_c1632a.id_f25bb1
  a8.id_c1632a.id_f25bb1 = ia
  if jr then
    jr:Set(ia)
  end
  if IX then
    IX()
  end
end
IX = function()
  if not K5 then
    return
  end
  K5.Text = "DSY"
  if a8.id_c1632a.id_f25bb1 then
    K5.BackgroundColor3 = Color3.fromRGB(30, 156, 88)
    K5.TextColor3 = Color3.fromRGB(255, 255, 51 * 5)
  else
    K5.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    K5.TextColor3 = Color3.fromRGB(235, 235, 235)
  end
end
t8 = function()
  if a8.id_a627a2.id_e32658 ~= true then
    if yV then
      pcall(function()
        yV:Destroy()
      end)
      yV = nil
      K5 = nil
    end
    return
  end
  local ct = P:FindFirstChildOfClass("PlayerGui")
  if not ct then
    ct = a_(P, "PlayerGui", 10)
  end
  if not ct then
    task.delay(1, function()
      if a8.id_a627a2.id_e32658 and t8 then
        pcall(t8)
      end
    end)
    return
  end
  local ib = ct:FindFirstChild("fff5d1452ee85b3fc0d7")
  if ib then
    pcall(function()
      ib:Destroy()
    end)
  end
  local gP = Instance.new("ScreenGui")
  gP.Name = "fff5d1452ee85b3fc0d7"
  gP.ResetOnSpawn = false
  gP.IgnoreGuiInset = true
  gP.DisplayOrder = 2147483646
  gP.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  gP.Parent = ct
  local az = Instance.new("TextButton")
  az.Name = "Button"
  az.AnchorPoint = Vector2.new(1, 1)
  az.Position = UDim2.new(1, -12, 1, -300)
  az.Size = UDim2.new(0, 48, 0, 48)
  az.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
  az.BorderSizePixel = 0
  az.AutoButtonColor = true
  az.Font = Enum.Font.GothamBold
  az.TextSize = 12
  az.TextWrapped = true
  az.Text = "DSY"
  az.TextColor3 = Color3.fromRGB(235, 235, 235)
  az.Parent = gP
  local aE = Instance.new("UICorner")
  aE.CornerRadius = UDim.new(1, 0)
  aE.Parent = az
  local aA = Instance.new("UIStroke")
  aA.Thickness = 1
  aA.Color = Color3.fromRGB(8 + 107, 5 * 23, 5 * 23)
  aA.Parent = az
  aC(az, ie)
  yV = gP
  K5 = az
  IX()
end
local function ig(aP)
  hr:ChangeHeight(aP)
end
GC = function()
  if a8.id_d20c9a.Enabled ~= true then
    if Ef then
      pcall(function()
        Ef:Destroy()
      end)
      Ef = nil
    end
    return
  end
  local ct = P:FindFirstChildOfClass("PlayerGui")
  if not ct then
    ct = a_(P, "PlayerGui", 10)
  end
  if not ct then
    task.delay(1, function()
      if a8.id_d20c9a.Enabled and GC then
        pcall(GC)
      end
    end)
    return
  end
  local ib = ct:FindFirstChild("de3d6007afee783becb5")
  if ib then
    pcall(function()
      ib:Destroy()
    end)
  end
  local gP = Instance.new("ScreenGui")
  gP.Name = "de3d6007afee783becb5"
  gP.ResetOnSpawn = false
  gP.IgnoreGuiInset = true
  gP.DisplayOrder = 2147483645
  gP.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  gP.Parent = ct
  local gQ = Instance.new("Frame")
  gQ.Name = "Controls"
  gQ.AnchorPoint = Vector2.new(1, 0.5)
  gQ.Position = UDim2.new(1, -18, 0.5, 0)
  gQ.Size = UDim2.new(0, 247 - 59, 0, 54)
  gQ.Active = true
  gQ.BackgroundColor3 = Color3.fromRGB(14, 17, 24)
  gQ.BorderSizePixel = 0
  gQ.Parent = gP
  local ih = Instance.new("UICorner")
  ih.CornerRadius = UDim.new(0, 8)
  ih.Parent = gQ
  local eX = Instance.new("UIPadding")
  eX.PaddingTop = UDim.new(0, 8)
  eX.PaddingBottom = UDim.new(0, 8)
  eX.PaddingLeft = UDim.new(0, 8)
  eX.PaddingRight = UDim.new(0, 8)
  eX.Parent = gQ
  local ii = Instance.new("UIListLayout")
  ii.FillDirection = Enum.FillDirection.Horizontal
  ii.HorizontalAlignment = Enum.HorizontalAlignment.Center
  ii.VerticalAlignment = Enum.VerticalAlignment.Center
  ii.Padding = UDim.new(0, 8)
  ii.SortOrder = Enum.SortOrder.LayoutOrder
  ii.Parent = gQ
  local function ij(fn, dA, ik, bt)
    local az = Instance.new("TextButton")
    az.Name = fn
    az.LayoutOrder = ik
    az.Size = UDim2.new(0, 82, 1, 0)
    az.BackgroundColor3 = Color3.fromRGB(30, 35, 47)
    az.BorderSizePixel = 0
    az.AutoButtonColor = true
    az.Font = Enum.Font.GothamBold
    az.Text = dA
    az.TextColor3 = Color3.fromRGB(238, 242, 250)
    az.TextSize = 18
    az.Parent = gQ
    local aE = Instance.new("UICorner")
    aE.CornerRadius = UDim.new(0, 6)
    aE.Parent = az
    local aH = false
    local aI = nil
    local function aM(aN)
      return aN.UserInputType == Enum.UserInputType.MouseButton1 or aN.UserInputType == Enum.UserInputType.Touch
    end
    az.InputBegan:Connect(function(aN)
      if not aM(aN) then
        return
      end
      aH = false
      aI = aN.Position
    end)
    local aO = M.InputChanged:Connect(function(aN)
      if not aI then
        return
      end
      local a6 = aN.UserInputType
      if a6 ~= Enum.UserInputType.Touch and a6 ~= Enum.UserInputType.MouseMovement then
        return
      end
      if (aN.Position - aI).Magnitude > 6 then
        aH = true
      end
    end)
    local aR = M.InputEnded:Connect(function(aN)
      if aM(aN) then
        aI = nil
      end
    end)
    az.Destroying:Connect(function()
      if aO then
        aO:Disconnect()
      end
      if aR then
        aR:Disconnect()
      end
    end)
    aS(gQ, az)
    az.Activated:Connect(function()
      if aH then
        return
      end
      bt()
    end)
    return az
  end
  ij("DownButton", "v", 1, function()
    ig(-i4)
  end)
  ij("UpButton", "^", 2, function()
    ig(i4)
  end)
  aS(gQ, gQ)
  Ef = gP
end
CX = hD:Tab({ Title = "loc:db13ef6667ab0f152d5660909506238a", Icon = "skull" })
hX = CX:Toggle({
  Title = "loc:b8b6acb1ef3ec71564db220b83bee34e",
  Value = a8.id_c1632a.id_e1993c,
  Callback = function(il)
    if e_ and not il then
      task.defer(function()
        if e_ then
          Nl(true)
        end
      end)
      return
    end
    a8.id_c1632a.id_e1993c = il
    if il then
      WV:id_c6a804()
    else
      WV:id_d7eac1()
    end
    if gW then
      gW()
    end
  end,
})
Jf = CX:Toggle({
  Title = "loc:aedb3de438c31e73809d044271ca6f83",
  Desc = "loc:d7a31c7a9773f67ced082a3ebce2278b",
  Value = false,
  Callback = function(il)
    e_ = il
    if il then
      Nl(true)
      pcall(function()
        hX.LockedTitle = ai("id_a66c27")
      end)
      Y5(hX, true)
      mn()
    else
      Y5(hX, false)
    end
  end,
})
QY = CX:Toggle({
  Title = "loc:d769493da6cac80a80e345c26e3276e6",
  Flag = "df5e59dd3ae5126c487d2ffba1f1f6c2",
  Value = a8.id_a627a2.id_b739bd,
  Callback = function(il)
    a8.id_a627a2.id_b739bd = il
    if RU then
      RU()
    end
    if av.id_a79299 or hG or hH then
      return
    end
    hI()
  end,
})
CX:Space()
RU()
w6 = CX:Toggle({
  Title = "loc:a61d83f3d6f99e193d194ea9608a5d59",
  Value = a8.id_c1632a.id_c41ca6,
  Callback = function(il)
    a8.id_c1632a.id_c41ca6 = il
    if il then
      ir:id_c6a804()
    else
      ir:id_d7eac1()
    end
    if MJ then
      MJ()
    end
  end,
})
YP = CX:Toggle({
  Title = "loc:f2761e3cd59401fb77a07540758e4efb",
  Flag = "a7f47401b27ef3a4e767651a016dc6c5",
  Value = a8.id_a627a2.id_cc0919,
  Callback = function(il)
    a8.id_a627a2.id_cc0919 = il
    if _h then
      _h()
    end
    if av.id_a79299 or hG or hH then
      return
    end
    hI()
  end,
})
_h()
CX:Space()
jr = CX:Toggle({
  Title = "loc:c7e7d88b539b76efc3e741e408422e42",
  Value = a8.id_c1632a.id_f25bb1,
  Callback = function(il)
    a8.id_c1632a.id_f25bb1 = il
    if il then
      oj:id_c6a804()
    else
      oj:id_d7eac1()
    end
    if IX then
      IX()
    end
  end,
})
KR = CX:Toggle({
  Title = "loc:e1cb9fca42e476daca64fe5bd94b7f5d",
  Flag = "cfb7cf24d56fb72e3e62e9964b62c4e3",
  Value = a8.id_a627a2.id_e32658,
  Callback = function(il)
    a8.id_a627a2.id_e32658 = il
    if t8 then
      t8()
    end
    if av.id_a79299 or hG or hH then
      return
    end
    hI()
  end,
})
t8()
Bz = i3:Toggle({
  Title = "loc:fba977a40b22b988e9dded1417cad3a5",
  Value = a8.id_d20c9a.Enabled,
  Callback = function(il)
    if not il and a8.id_d20c9a.id_bac88e then
      a8.id_d20c9a.Enabled = true
      ax(Bz, true)
      if GC then
        GC()
      end
      return
    end
    a8.id_d20c9a.Enabled = il
    hr:id_ae5ef0()
    if GC then
      GC()
    end
  end,
})
xS = i3:Toggle({
  Title = "loc:d1345f0cda656de47d5e6474b9f08d8a",
  Value = a8.id_d20c9a.id_bac88e,
  Callback = function(il)
    a8.id_d20c9a.id_bac88e = il
    if il and not a8.id_d20c9a.Enabled then
      a8.id_d20c9a.Enabled = true
      ax(Bz, true)
      if GC then
        GC()
      end
    end
    hr:id_c04e86(il)
  end,
})
i3:Space()
G6 = i3:Toggle({
  Title = "loc:ebefa948038ac07ea78172a3c8133ebf",
  Value = a8.id_c2960b.id_fa7ccf,
  Callback = function(il)
    a8.id_c2960b.id_fa7ccf = il
    gY:id_ae5ef0()
  end,
})
aB = i3:Slider({
  Title = "loc:a5583643fe7eb46f11b783b7abd23751",
  Step = 1,
  Value = {
    Min = 0,
    Max = 100,
    Default = a8.id_c2960b.id_f4716b,
  },
  Callback = function(ab)
    a8.id_c2960b.id_f4716b = ab
    gY:id_ae5ef0()
  end,
})
Uc = i3:Toggle({
  Title = "loc:b5763258a150e11677fab2ce65d43228",
  Value = a8.id_c2960b.id_d21688,
  Callback = function(il)
    a8.id_c2960b.id_d21688 = il
    gY:id_ae5ef0()
  end,
})
i3:Space()
uW = i3:Toggle({
  Title = "loc:d16d4182c7d070152d2c44dee9267832",
  Value = a8.id_c2960b.id_d05c51,
  Callback = function(il)
    a8.id_c2960b.id_d05c51 = il
    h0:id_ae5ef0()
  end,
})
u2 = i3:Slider({
  Title = "loc:c4d9ce265bee45ab1a00d1d66b15c89f",
  Step = 1,
  Value = {
    Min = 0,
    Max = 66 + 34,
    Default = a8.id_c2960b.id_ba7ec6,
  },
  Callback = function(ab)
    a8.id_c2960b.id_ba7ec6 = ab
    h0:id_ae5ef0()
  end,
})
local im = hD:Tab({ Title = "Aim Legit", Icon = "crosshair" })
local io = nil
local ip = nil
local iq = nil
local is = nil
local it = nil
local iu = nil
local iv = nil
local iw = nil
local ix = nil
Nh = nil
Ti = nil
local function iy(iz)
  if not (a8.id_c1632a.id_fda17e and a8.id_c1632a.id_b0732d) then
    return
  end
  if iz == "triggerbot" then
    a8.id_c1632a.id_b0732d = false
    if iq then
      ax(iq, false)
    end
    if WA then
      WA()
    end
  else
    a8.id_c1632a.id_fda17e = false
    if ip then
      ax(ip, false)
    end
  end
end
local function iA()
  iy()
  if a8.id_c1632a.id_b385e1 then
    fU:id_c6a804()
  else
    fU:id_d7eac1()
  end
  if a8.id_c1632a.id_fda17e then
    fZ:id_c6a804()
  else
    fZ:id_d7eac1()
  end
  if a8.id_c1632a.id_b0732d then
    gs:id_c6a804()
  else
    gs:id_d7eac1()
  end
  if a8.id_c1632a.id_df8e49 then
    Aa:id_c6a804()
  else
    Aa:id_d7eac1()
  end
  if a8.id_c1632a.id_d741b8 then
    ug:id_c6a804()
  else
    ug:id_d7eac1()
  end
end
Nh = im:Toggle({
  Title = "loc:e311dde60ce68fbdebaff476605de4f5",
  Value = a8.id_c1632a.id_d741b8,
  Callback = function(il)
    a8.id_c1632a.id_d741b8 = il
    iA()
    if av.id_a79299 or hG or hH then
      return
    end
    bD("Macro", il and "Enabled" or "Disabled", il and "crosshair" or "info")
  end,
})
Ti = im:Keybind({
  Title = "loc:aa2b3dd10e5280896abb08c2ad5d9a6e",
  Flag = "ef9489e349a67b386c4dcbc937f1bce9",
  Value = a8.id_f749bd.id_d741b8,
  Callback = function()
    if Nh then
      Nh:Set(not a8.id_c1632a.id_d741b8)
    end
  end,
})
im:Space()
ip = im:Toggle({
  Title = "loc:efb1b5c3c854c7ae166c10648e3a6901",
  Flag = "d67cc3120a8a7c878f044d5dd4b77516",
  Value = a8.id_c1632a.id_fda17e,
  Callback = function(il)
    a8.id_c1632a.id_fda17e = il
    if il then
      iy("triggerbot")
    end
    iA()
    if av.id_a79299 or hG or hH then
      return
    end
    bD("Triggerbot", il and "Enabled" or "Disabled", il and "crosshair" or "info")
    hI()
  end,
})
iw = im:Keybind({
  Title = "loc:da8a12d3b3bf5148980f746a147eec84",
  Flag = "d7293031bf862c3a43ba19082c989a61",
  Value = a8.id_f749bd.id_fda17e,
  Callback = function()
    if ip then
      ip:Set(not a8.id_c1632a.id_fda17e)
    end
  end,
})
im:Space()
im:Divider()
im:Space()
io = im:Toggle({
  Title = "loc:e19908b67b5b1a911c69e7e250136f05",
  Desc = "loc:c6401e2c5000958ba6cf1284224f7033",
  Flag = "bae7f597d824ba587fd32c9854b9aa2b",
  Value = a8.id_c1632a.id_b385e1,
  Callback = function(il)
    a8.id_c1632a.id_b385e1 = il
    iA()
    if av.id_a79299 or hG or hH then
      return
    end
    bD("Aim Follow", il and "Enabled" or "Disabled", il and "crosshair" or "info")
    hI()
  end,
})
iv = im:Keybind({
  Title = "loc:e528eff1f02a3cf87c3c4c72ed4d935c",
  Flag = "a3643904bdad1abb53d0f8e02449f314",
  Value = a8.id_f749bd.id_b385e1,
  Callback = function()
    if io then
      io:Set(not a8.id_c1632a.id_b385e1)
    end
  end,
})
is = im:Toggle({
  Title = "loc:dc814b083f1afdc4c7eb89e54f4b54c2",
  Flag = "db6d2c29aa63128a6f09229070f3a8dd",
  Value = a8.id_c1632a.id_a00ab8,
  Callback = function(il)
    a8.id_c1632a.id_a00ab8 = il == true
    if av.id_a79299 or hG or hH then
      return
    end
    bD("Aim Follow", il and "Only firearm enabled" or "Only firearm disabled", il and "crosshair" or "info")
    hI()
  end,
})
it = im:Toggle({
  Title = "loc:c3115e4b7e12defdd991a24770b1f2ad",
  Flag = "c33df0617a959865f03ea5c639b2f34d",
  Value = a8.id_c1632a.id_f7ca6b,
  Callback = function(il)
    a8.id_c1632a.id_f7ca6b = il == true
    if av.id_a79299 or hG or hH then
      return
    end
    bD("Aim Follow", il and "Only knife enabled" or "Only knife disabled", il and "crosshair" or "info")
    hI()
  end,
})
iu = im:Toggle({
  Title = "loc:b9a2b7f7c5dde9640074167ff8c74290",
  Flag = "e1858f1cb1214a18dd5e720745c5762d",
  Value = a8.id_c1632a.id_b6ad50,
  Callback = function(il)
    a8.id_c1632a.id_b6ad50 = il == true
    if av.id_a79299 or hG or hH then
      return
    end
    bD("Aim Follow", il and "Raycast enabled" or "Raycast disabled", il and "crosshair" or "info")
    hI()
  end,
})
local iB = hD:Tab({ Title = "Aim Bannable", Icon = "crosshair" })
local iC = nil
local iD = nil
local iE = {}
local iF = nil
local function iG()
  hF:Set("ad8bd401d817b1543bdd43e7383c", a8.id_c1632a.id_f507e2)
  if av.id_a79299 or hG or hH then
    return
  end
  hI()
end
local function iH()
  if not iC then
    return
  end
  fB()
  for Y, iI in ipairs(fx) do
    local az = iE[iI.Name]
    if az then
      local iJ = a8.id_c1632a.id_f507e2[iI.Name] == true
      az.BackgroundColor3 = iJ and fA.Selected or fA.Accent
      local aA = az:FindFirstChild("StateStroke")
      if aA and aA:IsA("UIStroke") then
        aA.Color = iJ and fA.Selected or fA.Icon
        aA.Transparency = iJ and 0.05 or 0.3
      end
    end
  end
end
local function iK()
  if not iC then
    return
  end
  if iF then
    iF:Disconnect()
    iF = nil
  end
  pcall(function()
    iC:Destroy()
  end)
  iC = nil
  iD = nil
  iE = {}
end
local function iL()
  fB()
  if iC and iC.Parent then
    iC.Enabled = true
    iH()
    return
  end
  if iC then
    iK()
  end
  local ct = P:FindFirstChildOfClass("PlayerGui")
  if not ct then
    ct = a_(P, "PlayerGui", 10)
  end
  if not ct then
    return
  end
  local gP = Instance.new("ScreenGui")
  gP.Name = "adbd31b1cab6af100c17"
  gP.ResetOnSpawn = false
  gP.IgnoreGuiInset = true
  gP.DisplayOrder = 2147483646
  gP.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  gP.Parent = ct
  local iM = 0.85
  local function iN(iO)
    return math.floor(iO * iM + 0.5)
  end
  local iP = Instance.new("Frame")
  iP.Name = "Panel"
  iP.AnchorPoint = Vector2.new(0.5, 0.5)
  iP.Position = UDim2.fromScale(0.5, 0.5)
  iP.Size = UDim2.fromOffset(iN(318), iN(392))
  iP.BackgroundColor3 = fA.Background
  iP.BorderSizePixel = 0
  iP.Parent = gP
  iD = iP
  local iQ = Instance.new("UICorner")
  iQ.CornerRadius = UDim.new(0, iN(16))
  iQ.Parent = iP
  local iR = Instance.new("UIStroke")
  iR.Color = fA.Icon
  iR.Thickness = 1
  iR.Transparency = 0.45
  iR.Parent = iP
  local iS = Instance.new("Frame")
  iS.Name = "DragHandle"
  iS.BackgroundTransparency = 1
  iS.Position = UDim2.fromOffset(0, 0)
  iS.Size = UDim2.new(1, iN(-52), 0, iN(46))
  iS.Parent = iP
  local bE = Instance.new("TextLabel")
  bE.BackgroundTransparency = 1
  bE.Position = UDim2.fromOffset(iN(18), iN(14))
  bE.Size = UDim2.fromOffset(iN(210), iN(24))
  bE.Font = Enum.Font.GothamBold
  bE.Text = "Body Part Editor"
  bE.TextColor3 = fA.Text
  bE.TextSize = iN(16)
  bE.TextXAlignment = Enum.TextXAlignment.Left
  bE.Parent = iP
  local iT = Instance.new("TextButton")
  iT.Name = "Close"
  iT.AnchorPoint = Vector2.new(1, 0)
  iT.Position = UDim2.new(1, iN(-16), 0, iN(13))
  iT.Size = UDim2.fromOffset(iN(20), iN(22))
  iT.BackgroundTransparency = 1
  iT.BorderSizePixel = 0
  iT.Text = "X"
  iT.Font = Enum.Font.GothamBold
  iT.TextSize = iN(16)
  iT.TextColor3 = fA.Icon
  iT.Parent = iP
  iT.Activated:Connect(iK)
  local iU = Instance.new("Frame")
  iU.Name = "BodyCanvas"
  iU.Position = UDim2.fromOffset(iN(20), iN(48))
  iU.Size = UDim2.fromOffset(iN(278), iN(330))
  iU.BackgroundTransparency = 1
  iU.BorderSizePixel = 0
  iU.ClipsDescendants = true
  iU.Parent = iP
  local iV = Instance.new("UICorner")
  iV.CornerRadius = UDim.new(0, iN(12))
  iV.Parent = iU
  local iW = Instance.new("UIStroke")
  iW.Color = fA.Icon
  iW.Thickness = 1
  iW.Transparency = 0.2
  iW.Parent = iU
  for Y, iI in ipairs(fx) do
    local az = Instance.new("TextButton")
    az.Name = iI.Name
    az.Position = UDim2.fromOffset(iN(iI.X), iN(iI.Y))
    az.Size = UDim2.fromOffset(iN(iI.id_f9bd5d), iN(iI.id_ded8e2))
    az.BackgroundColor3 = fA.Accent
    az.BorderSizePixel = 0
    az.AutoButtonColor = true
    az.Text = iI.Label
    az.Font = Enum.Font.GothamBold
    az.TextSize = iN(11)
    az.TextColor3 = fA.Text
    az.Parent = iU
    local aE = Instance.new("UICorner")
    aE.CornerRadius = UDim.new(0, iN(8))
    aE.Parent = az
    local aA = Instance.new("UIStroke")
    aA.Name = "StateStroke"
    aA.Color = fA.Icon
    aA.Thickness = 1
    aA.Transparency = 0.3
    aA.Parent = az
    az.Activated:Connect(function()
      a8.id_c1632a.id_f507e2[iI.Name] = not a8.id_c1632a.id_f507e2[iI.Name]
      iH()
      iG()
    end)
    iE[iI.Name] = az
  end
  local aG = false
  local aI = nil
  local iX = nil
  local function iY(aN)
    aG = true
    aI = aN.Position
    iX = iP.Position
  end
  local function iZ(aN)
    if not aG or not aI or not iX then
      return
    end
    local aP = aN.Position - aI
    iP.Position = UDim2.new(iX.X.Scale, iX.X.Offset + aP.X, iX.Y.Scale, iX.Y.Offset + aP.Y)
  end
  iS.InputBegan:Connect(function(aN)
    if aN.UserInputType == Enum.UserInputType.MouseButton1 or aN.UserInputType == Enum.UserInputType.Touch then
      iY(aN)
    end
  end)
  iS.InputEnded:Connect(function(aN)
    if aN.UserInputType == Enum.UserInputType.MouseButton1 or aN.UserInputType == Enum.UserInputType.Touch then
      aG = false
    end
  end)
  iF = M.InputChanged:Connect(function(aN)
    if aN.UserInputType == Enum.UserInputType.MouseMovement or aN.UserInputType == Enum.UserInputType.Touch then
      iZ(aN)
    end
  end)
  iC = gP
  iH()
end
iB:Button({
  Title = "loc:fab02cd9c966ed2772485f348952b37d",
  Desc = "loc:b94bf0d66d694b714394f964262adc0f",
  Callback = function()
    iL()
  end,
})
iB:Space()
iq = iB:Toggle({
  Title = "loc:c10a3756d8b0d11b72b4f7d5a35fafeb",
  Desc = "loc:a09fbfecc4939ad3f4c2dacb6f092ff0",
  Value = a8.id_c1632a.id_b0732d,
  Callback = function(il)
    a8.id_c1632a.id_b0732d = il
    if il then
      iy("silentaim")
    end
    iA()
    if WA then
      WA()
    end
    if av.id_a79299 or hG or hH then
      return
    end
    bD("Silent Aim", il and "Enabled" or "Disabled", il and "crosshair" or "info")
  end,
})
zF = iB:Toggle({
  Title = "loc:fc15d13bac5f83470ac97d1b4a0ad04e",
  Flag = "b377f02f680b4ad9b58e7b61ac5144f9",
  Value = a8.id_a627a2.id_b8cf17,
  Callback = function(il)
    a8.id_a627a2.id_b8cf17 = il
    if EN then
      EN()
    end
    hI()
  end,
})
ix = iB:Keybind({
  Title = "loc:fdd4d952584aa7289d9caa39706da583",
  Flag = "e192da3910ce216c8737318073a8c46f",
  Value = a8.id_f749bd.id_b0732d,
  Callback = function()
    if iq then
      iq:Set(not a8.id_c1632a.id_b0732d)
    end
  end,
})
iB:Space()
iB:Divider()
iB:Space()
ne = iB:Toggle({
  Title = "loc:e5a210e23c31db476cf7851c616879fb",
  Value = a8.id_c1632a.id_df8e49,
  Callback = function(il)
    a8.id_c1632a.id_df8e49 = il
    iA()
    if G7 then
      G7()
    end
    if av.id_a79299 or hG or hH then
      return
    end
    bD("Auto Shoot", il and "Enabled" or "Disabled", il and "crosshair" or "info")
  end,
})
Mi = iB:Toggle({
  Title = "loc:afb83060b4c8e1b3501f41f439bb366f",
  Flag = "f534145bb7d9ab9d94d24a1bbd8fe1a5",
  Value = a8.id_a627a2.id_b2f78b,
  Callback = function(il)
    a8.id_a627a2.id_b2f78b = il
    if ki then
      ki()
    end
    if av.id_a79299 or hG or hH then
      return
    end
    hI()
  end,
})
CP = iB:Keybind({
  Title = "loc:c1c6c3f6eb15738a2d406de633e61a75",
  Flag = "ccc473a1a9afe7f430f3cdbe57ab807f",
  Value = a8.id_f749bd.id_df8e49,
  Callback = function()
    if ne then
      ne:Set(not a8.id_c1632a.id_df8e49)
    end
  end,
})
iB:Space()
iB:Divider()
iB:Space()
hF:Register(
  "cb4e74d0522527185793bf065ba3eebc",
  iB:Toggle({
    Title = "loc:f603d87f683ddfe7e8e794c98a55a86e",
    Desc = "loc:e53a42bc00372607cd31759543111ef9",
    Value = a8.id_c1632a.id_b7ba43,
    Callback = function(il)
      a8.id_c1632a.id_b7ba43 = il == true
      if av.id_a79299 or hG or hH then
        return
      end
      hI()
    end,
  })
)
hF:Register(
  "e4173ca5c6975a353688ad68454f7c1a",
  iB:Toggle({
    Title = "loc:b06bb8f8eedbb99d7c9ba438324b0c6e",
    Desc = "loc:cbbbf53ca3a6245e7948906fdd94fc4d",
    Value = a8.id_c1632a.id_e82f73,
    Callback = function(il)
      a8.id_c1632a.id_e82f73 = il == true
      if av.id_a79299 or hG or hH then
        return
      end
      hI()
    end,
  })
)
hF:Register(
  "d70a31b0a278305fa5ccb404c7bfbaa7",
  iB:Slider({
    Title = "loc:d15dff7b239795d01569811d5d3465a8",
    Step = 5,
    Value = {
      Min = 20,
      Max = 600,
      Default = a8.id_c1632a.id_f2d9c0,
    },
    Callback = function(ab)
      a8.id_c1632a.id_f2d9c0 = ab
      if av.id_a79299 or hG or hH then
        return
      end
      hI()
    end,
  })
)
hF:Register(
  "ac23d28ba949498b7182e89f997d08b4",
  iB:Slider({
    Title = "loc:cc0f01f735dbd74a02e45530aac64416",
    Desc = "loc:a436b9219e3de9a9b903b23ba1cd8bf6",
    Step = 5,
    Value = {
      Min = 0,
      Max = 25 * 4,
      Default = a8.id_c1632a.id_f28945,
    },
    Callback = function(ab)
      a8.id_c1632a.id_f28945 = math.clamp(tonumber(ab) or 100, 0, 100)
      if av.id_a79299 or hG or hH then
        return
      end
      hI()
    end,
  })
)
local function i_()
  a8.id_c1632a.id_b0732d = not a8.id_c1632a.id_b0732d
  if iq then
    iq:Set(a8.id_c1632a.id_b0732d)
  else
    iA()
  end
  if WA then
    WA()
  end
end
WA = function()
  if not vU then
    return
  end
  vU.Text = "SA"
  if a8.id_c1632a.id_b0732d then
    vU.BackgroundColor3 = Color3.fromRGB(30, 156, 88)
    vU.TextColor3 = Color3.fromRGB(255, 255, 255)
  else
    vU.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    vU.TextColor3 = Color3.fromRGB(235, 235, 347 - 112)
  end
end
EN = function()
  if a8.id_a627a2.id_b8cf17 ~= true then
    if EL then
      pcall(function()
        EL:Destroy()
      end)
      EL = nil
      vU = nil
    end
    return
  end
  local ct = P:FindFirstChildOfClass("PlayerGui")
  if not ct then
    ct = a_(P, "PlayerGui", 10)
  end
  if not ct then
    task.delay(1, function()
      if a8.id_a627a2.id_b8cf17 and EN then
        pcall(EN)
      end
    end)
    return
  end
  local ib = ct:FindFirstChild("bd0c0a368357d585d4c2")
  if ib then
    pcall(function()
      ib:Destroy()
    end)
  end
  local gP = Instance.new("ScreenGui")
  gP.Name = "bd0c0a368357d585d4c2"
  gP.ResetOnSpawn = false
  gP.IgnoreGuiInset = true
  gP.DisplayOrder = 2147483646
  gP.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  gP.Parent = ct
  local az = Instance.new("TextButton")
  az.Name = "Button"
  az.AnchorPoint = Vector2.new(1, 1)
  az.Position = UDim2.new(1, -12, 1, -(2 * 66))
  az.Size = UDim2.new(0, 48, 0, 48)
  az.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
  az.BorderSizePixel = 0
  az.AutoButtonColor = true
  az.Font = Enum.Font.GothamBold
  az.TextSize = 12
  az.TextWrapped = true
  az.Text = "SA"
  az.TextColor3 = Color3.fromRGB(5 * 47, 235, 235)
  az.Parent = gP
  local aE = Instance.new("UICorner")
  aE.CornerRadius = UDim.new(1, 0)
  aE.Parent = az
  local aA = Instance.new("UIStroke")
  aA.Thickness = 1
  aA.Color = Color3.fromRGB(23 * 5, 115, 115)
  aA.Parent = az
  aC(az, i_)
  EL = gP
  vU = az
  WA()
end
EN()
local function j0()
  a8.id_c1632a.id_df8e49 = not a8.id_c1632a.id_df8e49
  if ne then
    ne:Set(a8.id_c1632a.id_df8e49)
  else
    iA()
  end
  if G7 then
    G7()
  end
end
G7 = function()
  if not Tu then
    return
  end
  Tu.Text = "AS"
  if a8.id_c1632a.id_df8e49 then
    Tu.BackgroundColor3 = Color3.fromRGB(30, 156, 88)
    Tu.TextColor3 = Color3.fromRGB(255, 3 * 85, 255)
  else
    Tu.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Tu.TextColor3 = Color3.fromRGB(235, 409 - 174, 235)
  end
end
ki = function()
  if a8.id_a627a2.id_b2f78b ~= true then
    if qM then
      pcall(function()
        qM:Destroy()
      end)
      qM = nil
      Tu = nil
    end
    return
  end
  local ct = P:FindFirstChildOfClass("PlayerGui")
  if not ct then
    ct = a_(P, "PlayerGui", 10)
  end
  if not ct then
    task.delay(1, function()
      if a8.id_a627a2.id_b2f78b and ki then
        pcall(ki)
      end
    end)
    return
  end
  local ib = ct:FindFirstChild("c6bfad8f157ceca6628b")
  if ib then
    pcall(function()
      ib:Destroy()
    end)
  end
  local gP = Instance.new("ScreenGui")
  gP.Name = "c6bfad8f157ceca6628b"
  gP.ResetOnSpawn = false
  gP.IgnoreGuiInset = true
  gP.DisplayOrder = 2147483646
  gP.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  gP.Parent = ct
  local az = Instance.new("TextButton")
  az.Name = "Button"
  az.AnchorPoint = Vector2.new(1, 1)
  az.Position = UDim2.new(1, -12, 1, -(4 * 89))
  az.Size = UDim2.new(0, 48, 0, 48)
  az.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
  az.BorderSizePixel = 0
  az.AutoButtonColor = true
  az.Font = Enum.Font.GothamBold
  az.TextSize = 12
  az.TextWrapped = true
  az.Text = "AS"
  az.TextColor3 = Color3.fromRGB(235, 242 - 7, 235)
  az.Parent = gP
  local aE = Instance.new("UICorner")
  aE.CornerRadius = UDim.new(1, 0)
  aE.Parent = az
  local aA = Instance.new("UIStroke")
  aA.Thickness = 1
  aA.Color = Color3.fromRGB(23 * 5, 115, 115)
  aA.Parent = az
  aC(az, j0)
  qM = gP
  Tu = az
  G7()
end
ki()
iA()
local j1 = hD:Tab({ Title = "ESP", Icon = "eye" })
bT = j1:Toggle({
  Title = "loc:fb954fe1209e7e4af448a870ce9052d1",
  Desc = "loc:afb474e43c9abba8f2a424546978c7ae",
  Value = a8.id_b2d046.Enabled,
  Callback = function(il)
    a8.id_b2d046.Enabled = il
    if av.id_a79299 then
      return
    end
    bD("ESP", il and "Enabled" or "Disabled", "scan-eye")
    if il then
      e8:id_c6a804()
    else
      e8:id_d7eac1()
    end
  end,
})
pN = j1:Toggle({
  Title = "loc:c5d2cdd263fd3634ef88b70defbc6bea",
  Flag = "bc977d8924da874697d4efc829622351",
  Value = a8.id_b2d046.id_a9e7ee,
  Callback = function(il)
    a8.id_b2d046.id_a9e7ee = il
    if a8.id_b2d046.Enabled then
      e8:id_fd7854()
    end
    if av.id_a79299 or hG or hH then
      return
    end
    hI()
  end,
})
JJ = j1:Toggle({
  Title = "loc:e81d972ea3f11c21b37da930230b091c",
  Desc = "loc:e60736bc519b7966e29628d36ef08187",
  Value = a8.id_b2d046.id_de5c26,
  Callback = function(il)
    a8.id_b2d046.id_de5c26 = il
    if av.id_a79299 then
      return
    end
    if il then
      ep:id_c6a804()
    else
      ep:id_d7eac1()
    end
  end,
})
Qv = j1:Colorpicker({
  Title = "loc:f8c12ba436a35d1990a8bc3c8e77944e",
  Desc = "Tap to change the ESP color.",
  Default = aq(a8.id_b2d046.Color, Color3.fromRGB(0, 255, 0)),
  Transparency = 0,
  Callback = function(j2)
    a8.id_b2d046.Color = aq(j2, a8.id_b2d046.Color or Color3.fromRGB(0, 311 - 56, 0))
    if a8.id_b2d046.Enabled then
      e8:id_fd7854()
    end
    hI()
  end,
})
mR = j1:Colorpicker({
  Title = "loc:e16764d65cf84aa798a554206d5be719",
  Desc = "Tap to change the ESP lines color.",
  Default = aq(a8.id_b2d046.id_d6b5ab, Color3.fromRGB(0, 172 + 83, 0)),
  Transparency = 0,
  Callback = function(j2)
    a8.id_b2d046.id_d6b5ab = aq(j2, a8.id_b2d046.id_d6b5ab or Color3.fromRGB(0, 255, 0))
    hI()
  end,
})
qY = j1:Keybind({
  Title = "loc:be9e408aec0c298c761ae8cdf9072f03",
  Flag = "deef32ce02600bd29074294411b3869e",
  Value = a8.id_f749bd.id_b2d046,
  Callback = function()
    if bT then
      bT:Set(not a8.id_b2d046.Enabled)
    end
  end,
})
local j3 = hD:Tab({ Title = "Hitbox", Icon = "box" })
Rm = j3:Toggle({
  Title = "loc:d5e0016ed741d5ce98b888aaa3d5807a",
  Desc = "loc:b153bf65ab7cda2aa2735a2f07547f13",
  Value = a8.id_e1110a.Enabled,
  Callback = function(il)
    a8.id_e1110a.Enabled = il
    if av.id_a79299 then
      return
    end
    if il then
      eu:id_c6a804()
      eu:id_f8a136()
    else
      eu:id_d7eac1()
    end
    bD("Hitbox", il and "Enabled" or "Disabled", "box")
  end,
})
nU = j3:Slider({
  Title = "loc:da30125c0dd7c41bf841a8681f4f5190",
  IsTooltip = true,
  Step = 1,
  Value = { Min = 1, Max = 50, Default = a8.id_e1110a.Size },
  Callback = function(ab)
    a8.id_e1110a.Size = ab
    if a8.id_e1110a.Enabled then
      eu:id_f8a136()
    end
    hI()
  end,
})
hQ = j3:Colorpicker({
  Title = "loc:d1d20253ec2d3d00bc55958d04bf0377",
  Desc = "Tap to change the hitbox color.",
  Default = aq(a8.id_e1110a.Color, Color3.fromRGB(255, 0, 0)),
  Transparency = 0,
  Callback = function(j2)
    a8.id_e1110a.Color = aq(j2, a8.id_e1110a.Color or Color3.fromRGB(255, 0, 0))
    if a8.id_e1110a.Enabled then
      eu:id_f8a136()
    end
    hI()
  end,
})
MM = j3:Slider({
  Title = "loc:b95e7c4d764ee540d887165836d439fa",
  IsTooltip = true,
  Step = 0.5,
  Value = {
    Min = 0,
    Max = 10,
    Default = a8.id_e1110a.id_aab82c,
  },
  Callback = function(ab)
    a8.id_e1110a.id_aab82c = ab
    if a8.id_e1110a.Enabled then
      eu:id_f8a136()
    end
    hI()
  end,
})
Rw = j3:Toggle({
  Title = "loc:f5fd069150c2314bfb00c744505dd4d3",
  Value = a8.id_e1110a.Show,
  Callback = function(ab)
    a8.id_e1110a.Show = ab
    if a8.id_e1110a.Enabled then
      eu:id_f8a136()
    end
    hI()
  end,
})
ks = j3:Keybind({
  Title = "loc:f031f64fd927124f2749a994d2db2523",
  Flag = "f1af53b8ee358d33f9cc52c389d63cfb",
  Value = a8.id_f749bd.id_e1110a,
  Callback = function()
    if Rm then
      Rm:Set(not a8.id_e1110a.Enabled)
    end
  end,
})
hD:Divider()
local j4 = ai("id_c10dbc")
mo = "https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"
wp = string.format('loadstring(game:HttpGet("%s"))()', mo)
function QP()
  return ai("id_e9c271")
end
function wx()
  return ai("id_b9e052")
end
local function j5()
  return ai("id_c4f2a0")
end
local function j6(i5, bE, j7)
  if not i5 then
    return
  end
  pcall(function()
    if i5.Edit then
      local j8 = { Title = bE }
      if j7 ~= nil then
        j8.Desc = j7
      end
      i5:Edit(j8)
      return
    end
    if i5.SetTitle then
      i5:SetTitle(bE)
    end
    if j7 ~= nil then
      if i5.SetDesc then
        i5:SetDesc(j7)
      elseif i5.SetDescription then
        i5:SetDescription(j7)
      end
    end
  end)
end
local j9 = hD:Tab({ Title = j4, Icon = "link" })
ve = j9:Button({
  Title = QP(),
  Desc = wx(),
  Callback = function()
    bI(QP(), mo)
  end,
})
rJ = j9:Button({
  Title = j5(),
  Callback = function()
    bR(QP(), wp)
  end,
})
wa = j9:Toggle({
  Title = ai("id_e7d11c"),
  Desc = ai("id_bb8ad7"),
  Flag = "e9ecbb80cf0a850948684d192e6e066f",
  Value = a8.id_e4985c.id_bbbf32,
  Callback = function(il)
    a8.id_e4985c.id_bbbf32 = il == true
    if av.id_a79299 or hG or hH then
      return
    end
    hI()
  end,
})
au = function()
  j6(j9, ai("id_c10dbc"))
  j6(ve, QP(), wx())
  j6(rJ, j5())
  j6(wa, ai("id_e7d11c"), ai("id_bb8ad7"))
end
local function ja()
  if a8.id_db7d1a.id_c40070 then
    fh:id_c6a804()
  else
    fh:id_d7eac1()
  end
end
local jb = hD:Tab({ Title = "Events & Boxes", Icon = "gift" })
Fc = jb:Toggle({
  Title = "loc:c2b092443cd7cf784af8fd5431ae53bd",
  Desc = "loc:de6fb023e8fc7a8ab7675ccc3c640284",
  Value = a8.id_db7d1a.id_c40070,
  Callback = function(il)
    a8.id_db7d1a.id_c40070 = il
    ja()
    if av.id_a79299 or hG or hH then
      return
    end
    bD("Event Farm", il and "Auto-farm activado." or "Auto-farm desactivado.", "gift")
  end,
})
ja()
jb:Space()
jb:Divider()
jb:Space()
VK = jb:Dropdown({
  Title = "loc:d8f43decc8733fe46ef97509913f9f49",
  Desc = "loc:d3a79b50f6ee54a51e87dd6d783ef946",
  Flag = "e43f8bdb2264677bdae01ee0107d62fe",
  Values = ht,
  Value = a8.id_eb081e.Selected,
  Callback = function(hS)
    hv(hS)
    hI()
  end,
})
jb:Button({
  Title = "loc:d057768612c13c7cec145ef544aaa0e9",
  Desc = "loc:e6b0c75f7f453e79992e64f08b5c9756",
  Callback = function()
    local R, jc = hC:id_d08e5f()
    if R then
      bD("Boxes", "Bought " .. tostring(a8.id_eb081e.Selected), "package")
      return
    end
    if jc == "insufficient_cash" then
      bD("Boxes", "Not enough cash for selected box.", "circle-dollar-sign")
    elseif jc == "missing_remote" then
      bD("Boxes", "BuyCase remote not found.", "alert-triangle")
    else
      bD("Boxes", "Could not buy the selected box.", "alert-triangle")
    end
  end,
})
aw = jb:Toggle({
  Title = "loc:cc6f88fdc0f140aada975b395249475c",
  Desc = "loc:d805b76f713b15d54843d142ca179701",
  Flag = "c35ae94439e7c390f1ffd10d946aaa14",
  Value = a8.id_eb081e.id_aaf026,
  Callback = function(il)
    a8.id_eb081e.id_aaf026 = il
    if il then
      hC:id_c6a804()
    else
      hC:id_d7eac1()
    end
    if av.id_a79299 or hG or hH then
      return
    end
    bD("Boxes", il and "Auto Buy enabled" or "Auto Buy disabled", "box")
    hI()
  end,
})
local jd = hD:Tab({ Title = "Auto Teleport", Icon = "repeat" })
ZH = nil
HZ = nil
mB = nil
Ru = nil
vu = nil
_O = nil
I1 = nil
lq = nil
local function je(gk, e5)
  if e5 then
    gk:id_c6a804()
    gk:id_ab3c6e()
  else
    gk:id_d7eac1()
  end
end
ZH = jd:Toggle({
  Title = "Auto Teleport Main",
  Desc = "loc:a25316ff5856541049ba2a6e9d08b425",
  Value = a8.id_db7d1a.id_eac970,
  Callback = function(il)
    a8.id_db7d1a.id_eac970 = il
    if il then
      a8.id_db7d1a.id_a0792b = false
      ax(Ru, false)
      fc:id_d7eac1()
    end
    if av.id_a79299 or hG or hH then
      return
    end
    je(fb, il)
  end,
})
Ru = jd:Toggle({
  Title = "Auto Teleport Alt",
  Desc = "loc:a25316ff5856541049ba2a6e9d08b425",
  Value = a8.id_db7d1a.id_a0792b,
  Callback = function(il)
    a8.id_db7d1a.id_a0792b = il
    if il then
      a8.id_db7d1a.id_eac970 = false
      ax(ZH, false)
      fb:id_d7eac1()
    end
    if av.id_a79299 or hG or hH then
      return
    end
    je(fc, il)
  end,
})
HZ = jd:Dropdown({
  Title = "loc:ddd3ac562d6393093032e19d46508255",
  Flag = ey.Main.id_a71128,
  Values = { "1v1", "2v2", "3v3", "4v4" },
  Value = eF(ey.Main),
  Callback = function(il)
    a8.id_db7d1a.id_a82937 = ex["Right Platforms"][il] and il or "1v1"
    if av.id_a79299 or hG or hH then
      return
    end
    if a8.id_db7d1a.id_eac970 then
      fb:id_ab3c6e()
    end
    if a8.id_db7d1a.id_a0792b then
      fc:id_ab3c6e()
    end
    hI()
  end,
})
mB = jd:Dropdown({
  Title = "loc:d44bb4f6c0bb3f7089939029cbc816ca",
  Flag = ey.Main.id_c314e2,
  Values = ew,
  Value = eI(ey.Main),
  Callback = function(il)
    a8.id_db7d1a.id_a5d67b = ex[il] and il or "Right Platforms"
    if av.id_a79299 or hG or hH then
      return
    end
    if a8.id_db7d1a.id_eac970 then
      fb:id_ab3c6e()
    end
    if a8.id_db7d1a.id_a0792b then
      fc:id_ab3c6e()
    end
    hI()
  end,
})
jd:Space()
jd:Divider()
jd:Space()
_O = jd:Toggle({
  Title = "loc:e31dda5e42067eacd1de46e6d1c3e6dd",
  Desc = "loc:e5d883e875425461f7d4877a65230048",
  Flag = "e333e3d26232b04e3fdf6bbcb6453678",
  Value = a8.id_db7d1a.id_aaf372,
  Callback = function(il)
    a8.id_db7d1a.id_aaf372 = il
  end,
})
I1 = jd:Slider({
  Title = "loc:ae1cddf7fd913336e01555ff8192b1b8",
  Step = 1,
  Value = {
    Min = 0,
    Max = 4,
    Default = a8.id_db7d1a.id_f39539,
  },
  Callback = function(ab)
    a8.id_db7d1a.id_f39539 = math.clamp(math.floor(tonumber(ab) or 4), 0, 4)
  end,
})
jd:Space()
vu = jd:Toggle({
  Title = "loc:a7ca395c40cc789197158e4a75cf2661",
  Desc = "loc:b8a78f6003d84bfeb95e6b0a4c8bb466",
  Flag = "a2c21ed1427f695f52b208b6597be661",
  Value = a8.id_db7d1a.id_f5ec1a,
  Callback = function(il)
    a8.id_db7d1a.id_f5ec1a = il
  end,
})
lq = jd:Slider({
  Title = "loc:a91065ff20998adf9c1c8836c53fd7eb",
  Step = 1,
  Value = {
    Min = 0,
    Max = 500,
    Default = a8.id_db7d1a.id_fa0986,
  },
  Callback = function(ab)
    a8.id_db7d1a.id_fa0986 = math.clamp(math.floor(tonumber(ab) or 1), 0, 2 * 250)
  end,
})
function CE()
  if a8.id_db7d1a.id_eac970 and a8.id_db7d1a.id_a0792b then
    a8.id_db7d1a.id_a0792b = false
    ax(Ru, false)
  end
  if a8.id_db7d1a.id_eac970 then
    fb:id_c6a804()
  else
    fb:id_d7eac1()
  end
  if a8.id_db7d1a.id_a0792b then
    fc:id_c6a804()
  else
    fc:id_d7eac1()
  end
end
function NS()
  local ga = 0
  local hY = 0
  local function jf(jg, jh)
    if not jg then
      return
    end
    ga = ga + 1
    if not hJ(jg, jh) then
      hY = hY + 1
    end
  end
  jf(qY, a8.id_f749bd.id_b2d046)
  jf(ks, a8.id_f749bd.id_e1110a)
  jf(iv, a8.id_f749bd.id_b385e1)
  jf(iw, a8.id_f749bd.id_fda17e)
  jf(ix, a8.id_f749bd.id_b0732d)
  jf(CP, a8.id_f749bd.id_df8e49)
  jf(Ti, a8.id_f749bd.id_d741b8)
  return ga, hY
end
function LB(ji, i5)
  if i5 then
    hF:Register(ji, i5)
  end
end
hF:Register("deef32ce02600bd29074294411b3869e", qY)
hF:Register("bc977d8924da874697d4efc829622351", pN)
hF:Register("f4edafe316b3f9ff3dab5167fabb91e9", JJ)
hF:Register("c367872ffafecefb7d5dcbf1118d9e58", Qv)
hF:Register("cc4e78baa2ab088fa8b608539395a77c", mR)
hF:Register("f1af53b8ee358d33f9cc52c389d63cfb", ks)
hF:Register("e078b1f657b4f0f0ea8dc53f4de45ff4", nU)
hF:Register("f290ba24c91e2e8a5ff83768145e31ae", hQ)
hF:Register("efc96e389f38ab1bd7e2202bba9173a4", MM)
hF:Register("f95240889df374bfd790159725ac5190", Rw)
hF:Register("bae7f597d824ba587fd32c9854b9aa2b", io)
hF:Register("a3643904bdad1abb53d0f8e02449f314", iv)
hF:Register("db6d2c29aa63128a6f09229070f3a8dd", is)
hF:Register("c33df0617a959865f03ea5c639b2f34d", it)
hF:Register("e1858f1cb1214a18dd5e720745c5762d", iu)
hF:Register("d67cc3120a8a7c878f044d5dd4b77516", ip)
hF:Register("d7293031bf862c3a43ba19082c989a61", iw)
hF:Register("e192da3910ce216c8737318073a8c46f", ix)
hF:Register("ccc473a1a9afe7f430f3cdbe57ab807f", CP)
hF:Register("ef9489e349a67b386c4dcbc937f1bce9", Ti)
hF:Register("b377f02f680b4ad9b58e7b61ac5144f9", zF)
hF:Register("f534145bb7d9ab9d94d24a1bbd8fe1a5", Mi)
hF:Register("df5e59dd3ae5126c487d2ffba1f1f6c2", QY)
hF:Register("a7f47401b27ef3a4e767651a016dc6c5", YP)
hF:Register("cfb7cf24d56fb72e3e62e9964b62c4e3", KR)
hF:Register("ae7e2edd09a3339eadd9477e9ef4b755", hU)
hF:Register("bc32704af9fc342e554ca987b9c2e630", hO)
hF:Register("d2510fc563adef1efb8d01411bbd67fb", hP)
hF:Register("fb601a6c2a8b2c20a716f3fc5397cd24", hR)
hF:Register("f750e2ffe08f8aa3008f031cecea6614", Fc)
LB("e9ecbb80cf0a850948684d192e6e066f", wa)
LB("auto_teleport_main_zone", HZ)
LB(ey.Main.id_c314e2, mB)
hF:Register("a2c21ed1427f695f52b208b6597be661", vu)
hF:Register("ce36e064830d5e71aeace1349bdc54a9", lq)
hF:Register("e333e3d26232b04e3fdf6bbcb6453678", _O)
hF:Register("a69c9728e3a26d8e849c230e07f0cf7b", I1)
hF:Register("e43f8bdb2264677bdae01ee0107d62fe", VK)
hG = true
hF:Load()
hG = false
a8.id_db7d1a.id_eac970 = false
a8.id_db7d1a.id_a0792b = false
ax(ZH, false)
ax(Ru, false)
a8.id_b2d046.Color = aq(Qv.Default, a8.id_b2d046.Color or Color3.fromRGB(0, 31 + 224, 0))
a8.id_b2d046.id_d6b5ab = aq(mR.Default, a8.id_b2d046.id_d6b5ab or Color3.fromRGB(0, 255, 0))
a8.id_e1110a.Color = aq(hQ.Default, a8.id_e1110a.Color or Color3.fromRGB(255, 0, 0))
do
  a8.id_c1632a.id_f0abef = true
  local jj = hF:Get("ad8bd401d817b1543bdd43e7383c")
  if type(jj) == "table" then
    a8.id_c1632a.id_f507e2 = jj
  end
  fB()
  hF:Set("ad8bd401d817b1543bdd43e7383c", a8.id_c1632a.id_f507e2)
end
do
  local jk = hF:Get("ab9c7b69553f83b71e4db8c6b061")
  if type(jk) == "table" then
    for aj, jl in pairs(jk) do
      if type(jl) == "table" and #jl >= 4 then
        V.D7[aj] = UDim2.new(jl[1], jl[2], jl[3], jl[4])
      end
    end
  end
end
ja()
CE()
iA()
EN()
if WA then
  WA()
end
ki()
if G7 then
  G7()
end
RU()
if gW then
  gW()
end
_h()
if MJ then
  MJ()
end
t8()
if IX then
  IX()
end
a8.id_eb081e.id_aaf026 = false
ax(aw, false)
hC:id_d7eac1()
a8.id_c2960b.id_fa7ccf = false
a8.id_c2960b.id_f4716b = 25
a8.id_c2960b.id_d21688 = false
a8.id_c2960b.id_d05c51 = false
a8.id_c2960b.id_ba7ec6 = 24
a8.id_d20c9a.Enabled = false
a8.id_d20c9a.id_bac88e = false
a8.id_d20c9a.id_fb990f = 0
ax(G6, false)
ax(Uc, false)
ax(uW, false)
ax(Bz, false)
ax(xS, false)
gY:id_d7eac1()
h0:id_d7eac1()
hr:Destroy()
hv(a8.id_eb081e.Selected)
if a8.id_eb081e.id_aaf026 then
  hC:id_c6a804()
else
  hC:id_d7eac1()
end
if a8.id_b2d046.id_de5c26 then
  ep:id_c6a804()
else
  ep:id_d7eac1()
end
gY:id_ae5ef0()
h0:id_ae5ef0()
do
  ah(a8.id_db8efe.Language)
  ao()
  au()
end
hH = false
task.delay(2, function()
  if I or a8.id_e4985c.id_bbbf32 ~= true then
    return
  end
  uZ(QP(), mo)
end)
pcall(function()
  getgenv()[H] = function()
    I = true
    e_ = false
    zU = (zU or 0) + 1
    a8.id_db7d1a.id_eac970 = false
    a8.id_db7d1a.id_a0792b = false
    a8.id_db7d1a.id_c40070 = false
    a8.id_c1632a.id_b385e1 = false
    a8.id_c1632a.id_fda17e = false
    a8.id_c1632a.id_b0732d = false
    a8.id_c1632a.id_df8e49 = false
    a8.id_c1632a.id_d741b8 = false
    a8.id_c1632a.id_e1993c = false
    a8.id_c1632a.id_c41ca6 = false
    a8.id_c1632a.id_f25bb1 = false
    a8.id_b2d046.Enabled = false
    a8.id_b2d046.id_de5c26 = false
    a8.id_e1110a.Enabled = false
    a8.id_c2960b.id_fa7ccf = false
    a8.id_c2960b.id_d21688 = false
    a8.id_c2960b.id_d05c51 = false
    a8.id_d20c9a.Enabled = false
    a8.id_d20c9a.id_bac88e = false
    a8.id_eb081e.id_aaf026 = false
    local function jm(gk, i7)
      if not gk then
        return
      end
      pcall(function()
        local gw = gk[i7]
        if type(gw) == "function" then
          gw(gk)
        end
      end)
    end
    jm(fb, "id_d7eac1")
    jm(fc, "id_d7eac1")
    jm(fU, "id_d7eac1")
    jm(fZ, "id_d7eac1")
    jm(gs, "id_d7eac1")
    jm(Aa, "id_d7eac1")
    jm(ug, "id_d7eac1")
    jm(WV, "id_d7eac1")
    jm(ir, "id_d7eac1")
    jm(oj, "id_d7eac1")
    jm(e8, "id_d7eac1")
    jm(ep, "id_d7eac1")
    jm(eu, "id_d7eac1")
    jm(gY, "id_d7eac1")
    jm(h0, "id_d7eac1")
    jm(hC, "id_d7eac1")
    jm(fh, "id_d7eac1")
    jm(dI, "id_d7eac1")
    jm(hr, "Destroy")
    jm(gT, "Destroy")
    jm(bx, "Stop")
    jm(gs, "id_aa5392")
    jm(I4, "id_aa5392")
    if u5 then
      pcall(function()
        u5:Disconnect()
      end)
      u5 = nil
    end
    local function jn(gP)
      if not gP then
        return
      end
      pcall(function()
        gP:Destroy()
      end)
    end
    jn(qB)
    jn(a4)
    jn(yV)
    jn(EL)
    jn(qM)
    jn(Ef)
    jn(iC)
    qB, nh = nil, nil
    a4, nN = nil, nil
    yV, K5 = nil, nil
    EL, vU = nil, nil
    qM, Tu = nil, nil
    Ef = nil
  end
end)
IG = function()
  if hI then
    hI()
  end
end
hD:OnDestroy(function()
  IG()
end)
