require "objetos/tronco"
require "objetos/aguila"

local partida = {
    update = function(dt)
        -- lógica de la partida

        tiempo_partida = tiempo_partida + dt

        if muerto then
            if tiempo_partida - momento_muerte >= 1 then    -- si estamos muertos, tras esta cantidad de tiempo volvemos al menú principal
                pantalla = "menu"
            end
            return
        end

        distancia_recorrida = distancia_recorrida + dt * heroe.velocidad_x
        
        if salto_pulsado then
            heroe.saltar()
        end

        -- decidimos si debemos crear un nuevo obstáculo
        if tiempo_partida >= tiempo_creacion_siguiente_obstaculo then
            table.insert(obstaculos, nuevo_tronco(164, 58))
            tiempo_creacion_siguiente_obstaculo = tiempo_partida + rnd(tiempo_minimo_entre_obstaculos, tiempo_maximo_entre_obstaculos)
            if rnd(0, 1) < 0.2 then
                if rnd(0, 1) < 0.5 then
                    tiempo_creacion_siguiente_aguila = tiempo_creacion_siguiente_obstaculo - 0.3
                else
                    tiempo_creacion_siguiente_aguila = tiempo_creacion_siguiente_obstaculo + 0.3
                end
            end
        end

        if tiempo_partida >= tiempo_creacion_siguiente_aguila then
            tiempo_creacion_siguiente_aguila = tiempo_partida + 999
            table.insert(obstaculos, nuevo_aguila(164,35))
        end


        local indices_obstaculos_a_eliminar = {}    -- lista para guardar los índices de los obstáculos que se salen por la izquierda de la pantalla (los eliminaremos posteriormente)
        -- actualizamos los obstáculos (los movemos, comprobamos colisiones y marcamos los que se deberían eliminar)
        for i, obstaculo in ipairs(obstaculos) do
            obstaculo:update(dt)

            obstaculo.x = obstaculo.x - heroe.velocidad_x * dt
            -- si el obstáculos se sale por la izquierda, actualizamos los puntos e insertamos su índice en la lista indices_obstaculos_a_eliminar
            if obstaculo.x < -10 then
                puntos = puntos + 1
                table.insert(indices_obstaculos_a_eliminar, i)
            end
            -- comprobamos si el héroe y el obstáculo están colisionando
            if colisionando(heroe, obstaculo) then
                if puntos > high_score then
                    high_score = puntos
                end
                muerto = true
                momento_muerte = tiempo_partida
            end
        end
        -- eliminamos los obstáculos insertados previamente en la lista indices_obstaculos_a_eliminar
        for i=#indices_obstaculos_a_eliminar,1,-1 do
            table.remove(obstaculos, i)
        end

        heroe.update(dt)
    end,
    draw = function()
        -- dibujamos el frame de la partida
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(imagen_suelo, 0 - distancia_recorrida % ANCHO_VIRTUAL, 0)
        love.graphics.draw(imagen_suelo, ANCHO_VIRTUAL - distancia_recorrida % ANCHO_VIRTUAL, 0)

        love.graphics.draw(imagen_cielo, 0, 0)
        love.graphics.setFont(font_hud)
        love.graphics.setColor(0.965, 0.839, 0.737)
        love.graphics.printf("SCORE: " .. puntos, 0, 0, ANCHO_VIRTUAL, "right")
        love.graphics.printf(" HI-SCORE: " .. high_score .. " ", 0, 0, ANCHO_VIRTUAL, "left")
        love.graphics.setColor(1, 1, 1)
        heroe.draw()
        if DIBUJAR_HITBOXES then
            heroe.draw_hitbox()
        end

        -- dibujamos los obstáculos
        for i, obstaculo in ipairs(obstaculos) do
            obstaculo:draw()
            if DIBUJAR_HITBOXES then
                obstaculo:draw_hitbox()
            end
        end

    end,
    se_ha_pulsado_una_tecla = function(tecla)
        if tecla == "space" then
            salto_pulsado = true
        end
    end,
    se_ha_soltado_una_tecla = function(tecla)
        if tecla == "space" then
            salto_pulsado = false
        end
    end
}

return partida
