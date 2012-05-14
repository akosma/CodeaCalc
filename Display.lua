Display = class()

function Display:init(value, position, size)
    self.value = value
    self.pos = position
    self.size = size
    self.memory = false
end

function Display:draw()
    fill(136, 130, 107, 255)
    rect(self.pos.x, self.pos.y, self.size.x, self.size.y)
    
    stroke(34, 34, 34, 163)
    strokeWidth(4)
    fill(0, 0, 0, 255)
    
    textAlign(LEFT)
    font("DBLCDTempBlack")
    fontSize(50) 
    textMode(CORNER)
    
    local width, height = textSize(self.value)
    local x = self.pos.x + self.size.x - width - 40
    local y = self.pos.y + self.size.y - height - 20
    text(self.value, x, y)
    
    if self.memory then
        font("HelveticaNeue-Bold")
        fontSize(20)
        textMode(CENTER)
        text("M", self.pos.x + self.size.x - 20, self.pos.y + self.size.y - 20)
    end
    
    -- get the current Y orientation
    gravY = Gravity.y
    if self.value == "5318008" and gravY > 0.4 then
        -- Oh no, user is trying to display a forbidden word
        -- hide it, and save the world from this infamy
        
        -- save the current graphic state
        pushMatrix()
        -- this font looks cool
        font("AmericanTypewriter-Condensed")
        
        -- text will be rotated
        translate(self.pos.x,self.pos.y - 10)
        rotate(5)
        
        -- fill a rect to display our text
        fill(0, 0, 0, 255)
        rect(0, 0, self.size.x, self.size.y)
        
        -- center the text
        local width, height = textSize("CENSORED")
        local x = (self.size.x - width)/2
        local y = (self.size.y - height)/2
        
        -- set the text color to red
        fill(255, 0, 0, 255)
        text("CENSORED", x, y)
        
        -- restore the graphic state
        popMatrix()
        
        -- Phewww, we've saved the world.
    end
        
end