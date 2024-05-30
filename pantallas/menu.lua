local menu = {
    update = function(dt)
        -- lógica del menú
    end,
    draw = function()
        -- dibujamos el frame del menú
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(imagen_menu_titulo, 0, 0)

        if mobile then
            --love.graphics.print("- espacio para jugar -", 20, 80)
            love.graphics.draw(imagen_menu_texto_movil, 0, 0)
        else
            love.graphics.draw(imagen_menu_texto_escritorio, 0, 0)
        end
    end,
    se_ha_pulsado_una_tecla = function(tecla)
        if tecla == "space" then
            pantalla = "partida"
            -- inicializamos la partida
            heroe = require "objetos/heroe"
            heroe.velocidad_x = 100 -- velocidad con la que corre inicialmente del héroe (en píxeles por segundo)
            tiempo_partida = 0      -- el tiempo que está durante la partida actual (inicialmente es cero y el código automáticamente actualiza este valor)
            distancia_recorrida = 0 -- la distancia que el héroe lleva recorrida (en píxeles)
            tiempo_creacion_siguiente_obstaculo = 0   -- siguiente momento en el que se creará un obstáculo
            tiempo_creacion_siguiente_aguila = 999   -- siguiente momento en el que se creará la siguiente águila
            obstaculos = {}    -- inicialmente no hay obstáculos creados (se crearán automáticamente cada cierto tiempo)
            tiempo_minimo_entre_obstaculos = 0.7 -- en segundos
            tiempo_maximo_entre_obstaculos = 1.5 -- en segundos
            puntos = 0
            heroe.velocidad_y = 0
            heroe.y = heroe.y_suelo
            salto_pulsado = false
            muerto = false -- el código pone a true esta variable cuando el héroe pierde una vida (porque cuando está muerto no puede saltar, se usa otro dibujo, se dejan de generar obstáculos, etc)
            -- fin inicialización partida
        end
    end,
    se_ha_soltado_una_tecla = function(tecla)
        -- de momento no nos interesa incluir nada en esta función
    end
}

return menu
