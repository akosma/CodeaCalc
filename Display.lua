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
    font("HelveticaNeue-Light")
    fontSize(50) 
    textMode(CORNER)
    
    local width, height = textSize(self.value)
    local x = self.pos.x + self.size.x - width - 40
    local y = self.pos.y + self.size.y - height - 10
    text(self.value, x, y)
    
    if self.memory then
        font("HelveticaNeue-Bold")
        fontSize(20)
        textMode(CENTER)
        text("M", self.pos.x + self.size.x - 20, self.pos.y + self.size.y - 20)
    end
end
