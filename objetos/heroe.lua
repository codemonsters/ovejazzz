local heroe = {
    -- inicio configuración
    x = 16,         -- x del hitbox
    y = 60,         -- y del hitbox
    ancho = 15,     -- ancho del hitbox
    alto = 10,      -- alto del hitbox
    desplz_img_x = -11,
    desplz_img_y = -50,
    y_suelo = 60,   -- altura del suelo (posición vertical a partir de la cual ya no estamos saltando)
    imagenes_corriendo = {
        love.graphics.newImage("imagenes/oveja_01.png"),
        love.graphics.newImage("imagenes/oveja_02.png"),
        love.graphics.newImage("imagenes/oveja_03.png"),
    },
    imagenes_saltando = {
        love.graphics.newImage("imagenes/oveja_04.png"),
        love.graphics.newImage("imagenes/oveja_05.png"),
        love.graphics.newImage("imagenes/oveja_06.png"),
        love.graphics.newImage("imagenes/oveja_07.png"),
        love.graphics.newImage("imagenes/oveja_08.png"),
    },
    velocidad_inicial_salto = 110,
    gravedad = 270,
    fps = 9,
    -- fin configuración
    num_imagen_actual = 1,
    velocidad_y = 0,
    estado = "corriendo",   -- valores posibles: "corriendo", "saltando"
    tiempo_ejecutandose = 0,
    saltar = function()
        if heroe.estado == "corriendo" then
            heroe.estado = "saltando"
            heroe.tiempo_saltando = 0
            heroe.num_imagen_actual = 1
            heroe.velocidad_y = heroe.velocidad_inicial_salto
            heroe.estado = "saltando"
        end
    end,
    update = function(dt)
        heroe.tiempo_ejecutandose = heroe.tiempo_ejecutandose + dt

        -- movimiento vertical durante el salto
        if heroe.estado == "saltando" then
            heroe.tiempo_saltando = heroe.tiempo_saltando + dt
            heroe.y = heroe.y - heroe.velocidad_y * dt
            heroe.velocidad_y = heroe.velocidad_y - heroe.gravedad * dt -- aplicamos la gravedad
            -- si tocamos el suelo, dejamos de saltar
            if heroe.y >= heroe.y_suelo then
                heroe.estado = "corriendo"
                heroe.tiempo_corriendo = 0
                heroe.num_imagen_actual = 1
                heroe.y = heroe.y_suelo
            end
        end

        -- cambiar de fotograma
        if heroe.estado == "corriendo" then
            local fotograma = math.floor(heroe.tiempo_ejecutandose * heroe.fps)
            heroe.num_imagen_actual = 1 + fotograma % #heroe.imagenes_corriendo
        elseif heroe.estado == "saltando" then
            if heroe.num_imagen_actual < # heroe.imagenes_saltando then
                local fotograma = math.floor(heroe.tiempo_saltando * heroe.fps)
                heroe.num_imagen_actual = 1 + fotograma % #heroe.imagenes_saltando
            end
        end
    end,
    draw = function()
        love.graphics.setColor(1, 1, 1)
        if heroe.estado == "corriendo" then
            love.graphics.draw(heroe.imagenes_corriendo[heroe.num_imagen_actual], heroe.x + heroe.desplz_img_x, heroe.y + heroe.desplz_img_y)
        elseif heroe.estado == "saltando" then
            love.graphics.draw(heroe.imagenes_saltando[heroe.num_imagen_actual], heroe.x + heroe.desplz_img_x, heroe.y + heroe.desplz_img_y)
        end
    end,
    draw_hitbox = function()
        love.graphics.setColor(1, 0, 0, 0.3)
        love.graphics.rectangle("line", heroe.x, heroe.y, heroe.ancho, heroe.alto)
    end,
}

return heroe
