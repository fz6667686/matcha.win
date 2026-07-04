-- ==========================================
-- ТЕСТОВЫЙ СКРИПТ ДЛЯ MATCHA LUAVM
-- ==========================================

-- 1. Проверяем вывод в консоль Matcha и название исполнителя
print("Привет от Matcha-latte!")
if identifyexecutor then
    local name, version = identifyexecutor()
    print("Исполнитель: " .. tostring(name) .. " | Версия: " .. tostring(version))
else
    print("Функция identifyexecutor не найдена.")
end

-- 2. Проверяем доступ к эмулируемым классам игры
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if LocalPlayer then
    print("Успешно подключились к игре! Твой ник: " .. tostring(LocalPlayer.Name))
else
    print("Не удалось получить LocalPlayer. Убедись, что ты в игре.")
end

-- 3. Тест Drawing API (Рисуем тестовый квадрат по центру экрана)
-- Если всё работает, на экране появится зелёная рамка
if Drawing then
    print("Тестируем Drawing API...")
    
    local testBox = Drawing.new("Square")
    testBox.Size = Vector2.new(150, 150)
    testBox.Position = Vector2.new(200, 200) -- Координаты на экране
    testBox.Color = Color3.fromRGB(0, 255, 0) -- Зелёный цвет
    testBox.Thickness = 2
    testBox.Filled = false
    testBox.Visible = true

    print("Зелёный квадрат должен появиться на экране!")
    
    -- Уберём его через 10 секунд, чтобы не мешал
    task.wait(10)
    testBox.Visible = false
    testBox:Remove()
    print("Тестовый квадрат удалён.")
else
    print("Drawing API недоступен в этой сборке.")
end
