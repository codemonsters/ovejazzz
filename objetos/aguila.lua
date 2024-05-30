function nuevo_aguila(pos_x_inicial, pos_y_inicial)
    local aguila = {
        -- inicio configuración
        x = pos_x_inicial,  -- x del hitbox
        y = pos_y_inicial,  -- y del hitbox
        ancho = 8,          -- ancho del hitbox
        alto = 8,          -- alto del hitbox
        desplz_img_x = -79,
        desplz_img_y = -28,
        imagenes = {
            love.graphics.newImage("imagenes/aguila_01.png"),
            love.graphics.newImage("imagenes/aguila_02.png"),
            love.graphics.newImage("imagenes/aguila_03.png"),
            love.graphics.newImage("imagenes/aguila_04.png"),
            love.graphics.newImage("imagenes/aguila_05.png"),
            love.graphics.newImage("imagenes/aguila_06.png"),
            love.graphics.newImage("imagenes/aguila_07.png"),
            love.graphics.newImage("imagenes/aguila_06.png"),
            love.graphics.newImage("imagenes/aguila_05.png"),
            love.graphics.newImage("imagenes/aguila_04.png"),
            love.graphics.newImage("imagenes/aguila_03.png"),
            love.graphics.newImage("imagenes/aguila_02.png"),
        },
        fps = 7,
        -- fin configuración
        num_imagen_actual = 1,
        tiempo_ejecutandose = 0,
        update = function(self, dt)
            -- cambiar de dibujo
            self.tiempo_ejecutandose = self.tiempo_ejecutandose + dt
            local fotograma = math.floor(self.tiempo_ejecutandose * self.fps)
            self.num_imagen_actual = 1 + fotograma % #self.imagenes
        end,
        draw = function(self)
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.imagenes[self.num_imagen_actual], self.x + self.desplz_img_x, self.y + self.desplz_img_y)
        end,
        draw_hitbox = function(self)
            love.graphics.setColor(1, 0, 0, 0.3)
            love.graphics.rectangle("line", self.x, self.y, self.ancho, self.alto)
        end
    }

    return aguila
end