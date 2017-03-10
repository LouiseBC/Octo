local mainGame = require('src.game')

menu = {}

function menu.init(menu, device, changeState)
   menu.mic = device
   menu.change = changeState
   menu.one_player_selected = true
   menu.octo = love.graphics.newImage('assets/octopus_intro.png')

   local font = love.graphics.newFont('assets/LadyRadical.ttf', 70)
   love.graphics.setFont(font)
end

function menu.update(state)
   function love.keypressed(key)
      if key == "escape" then
         love.event.quit()
      end

      if (key == 'down') or (key == 's') and menu.one_player_selected then
         menu.one_player_selected = false
      elseif (key == 'up') or (key == 'w') and menu.one_player_selected == false then
         menu.one_player_selected = true
      end

      if (key == "return") or (key == "space") then
         menu:change(mainGame) -- Changed because it's probably easier to just pass in playerCount argument than make new gamestate for 2-player
      end
   end
end

function menu.draw(state)
   love.graphics.setBackgroundColor(100, 130, 255)

   love.graphics.draw(menu.octo, love.graphics.getWidth()/2-menu.octo:getWidth()/4, love.graphics.getHeight()/2-menu.octo:getHeight()/4+25,0,0.5,0.5)

   local amplitude_to_alpha = math.floor((menu.mic:poll() or 1)/100*255-0.5)+75 --Turning amplitude to alpha
   love.graphics.setColor(255, 255,255, amplitude_to_alpha)
   love.graphics.printf('Octo-Octo', 0, 30, love.graphics.getWidth(), 'center')

   local mode_selected = menu.one_player_selected and {219, 78, 78} or {255, 255, 255}
   love.graphics.setColor(mode_selected)
   love.graphics.printf('1 Player', 0, love.graphics.getHeight()*0.55, love.graphics.getWidth(), 'center')

   local mode_selected = not menu.one_player_selected and {219, 78, 78} or {255, 255, 255}
   love.graphics.setColor(mode_selected)
   love.graphics.printf('Two Team Battle!', 0, love.graphics.getHeight()*0.65, love.graphics.getWidth(), 'center')
   love.graphics.setColor(255, 255, 255)
end

return menu
