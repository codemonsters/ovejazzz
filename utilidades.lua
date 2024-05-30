if love.system.getOS() == 'iOS' or love.system.getOS() == 'Android' then
    mobile = true
else
    mobile = false
end

local utilidades = {
    configuraVentana = function(ancho_virtual, alto_virtual)
        utilidades.ancho_virtual = ancho_virtual
        utilidades.alto_virtual = alto_virtual
        love.graphics.setDefaultFilter("nearest") -- Cambiamos el filtro usado durante el escalado
        local resolucion_pantalla_x, resolucion_pantalla_y = love.graphics.getDimensions()
        local resolucion_ventana_x, resolucion_ventana_y = resolucion_pantalla_x * .7, resolucion_pantalla_y * .7 -- definimos el tamaño inicial de la ventana
        love.window.setMode(
            resolucion_ventana_x,
            resolucion_ventana_y,
            {
                vsync = true,
                resizable = true,
                centered = true
            }
        )
        love.window.setMode(resolucion_ventana_x, resolucion_ventana_y, {resizable=true, vsync=0, minwidth=utilidades.ancho_virtual, minheight=utilidades.alto_virtual})
        utilidades.actualizaVariablesEscalado(resolucion_ventana_x, resolucion_ventana_y)
    end,
    actualizaVariablesEscalado = function(resolucion_x, resolucion_y)
        local factor_escala_x = resolucion_x / utilidades.ancho_virtual
        local factor_escala_y = resolucion_y / utilidades.alto_virtual
        if factor_escala_x < factor_escala_y then
            utilidades.factor_escala = factor_escala_x
        else
            utilidades.factor_escala = factor_escala_y
        end
    
        utilidades.desplazamiento_x = (resolucion_x - utilidades.factor_escala * utilidades.ancho_virtual) / 2
        utilidades.desplazamiento_y = (resolucion_y - utilidades.factor_escala * utilidades.alto_virtual) / 2
    end,
    antesDeDibujar = function()
        -- prepara un canvas con el escalado y el desplazamiento necesarios
        love.graphics.push()
        love.graphics.setCanvas(mainCanvas)
        love.graphics.translate(utilidades.desplazamiento_x, utilidades.desplazamiento_y)
        love.graphics.scale(utilidades.factor_escala, utilidades.factor_escala)
    end,
    despuesDeDibujar = function()
        -- volvemos a dibujar en la ventana principal
        love.graphics.setCanvas()
        love.graphics.pop()    
    end
}

function love.resize(w, h)
    utilidades.actualizaVariablesEscalado(w, h)
end

-- devuelve un valor decimal aleatorio entre el mínimo y máximo indicados (ambos incluidos)
function rnd(min_value, max_value)
    return love.math.random(min_value * 1000, max_value * 1000) / 1000
end

function colisionando(obj1, obj2)
    return obj1.x < obj2.x + obj2.ancho and
        obj2.x < obj1.x + obj1.ancho and
        obj1.y < obj2.y + obj2.alto and
        obj2.y < obj1.y + obj1.alto
end

return utilidades