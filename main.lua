utilidades = require "utilidades"
pantalla_menu = require "pantallas/menu"
pantalla_partida = require "pantallas/partida"

ANCHO_VIRTUAL = 160
ALTO_VIRTUAL = 90
DIBUJAR_HITBOXES = false    -- si vale true entonces el juego dibuja el hitbox de todos los objetos

function love.load()
    utilidades.configuraVentana(ANCHO_VIRTUAL, ALTO_VIRTUAL)
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setTitle("Ovejazzz")
    imagen_menu_titulo = love.graphics.newImage("imagenes/menu_titulo.png")
    imagen_menu_texto_escritorio = love.graphics.newImage("imagenes/menu_texto_escritorio.png")
    imagen_menu_texto_movil = love.graphics.newImage("imagenes/menu_texto_movil.png")
    imagen_suelo = love.graphics.newImage("imagenes/suelo.png")
    imagen_cielo = love.graphics.newImage("imagenes/cielo.png")

    font_hud = love.graphics.newFont("fonts/pixelsix14.ttf", 14)    -- Fuente encontrada en: https://www.dafont.com/es/pixelsix.font
    pantalla = "menu"
    high_score = 0
end

function love.update(dt)
    if pantalla == "menu" then
        pantalla_menu.update(dt)
    elseif pantalla == "partida" then
        pantalla_partida.update(dt)
    else
        -- mostrar un error (pantalla no válida)
        print("Pantalla no válida: " .. pantalla)
    end
end

function love.draw()
    utilidades.antesDeDibujar()
    love.graphics.clear()
    
    if pantalla == "menu" then
        pantalla_menu.draw()
    elseif pantalla == "partida" then
        pantalla_partida.draw()
    end
    
    utilidades.despuesDeDibujar()
end

function love.keypressed(key)
    if pantalla == "menu" then
        pantalla_menu.se_ha_pulsado_una_tecla(key)
    elseif pantalla == "partida" then
        pantalla_partida.se_ha_pulsado_una_tecla(key)
    end
end

function love.keyreleased(key)
    if pantalla == "menu" then
        pantalla_menu.se_ha_soltado_una_tecla(key)
    elseif pantalla == "partida" then
        pantalla_partida.se_ha_soltado_una_tecla(key)
    end
end