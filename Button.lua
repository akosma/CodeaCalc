Button = class()

NUMBER = 0
OPERATOR = 1

function Button:init(value, position, size, kind, operation)
    self.value = value
    self.pos = position
    self.size = size
    self.touched = false
    self.kind = kind or NUMBER
    self.operation = operation
end

function Button:draw()
    if self.touched then
        fill(118, 71, 73, 255)
    else
        if self.kind == NUMBER then
            fill(192, 73, 79, 255)
        elseif self.kind == OPERATOR then
            fill(31, 44, 117, 255)
        end
    end
    rect(self.pos.x, self.pos.y, self.size.x, self.size.y)
    
    strokeWidth(4)
    stroke(34, 34, 34, 163)
    
    if self.touched then
        fill(115, 115, 115, 255)
    else
        fill(255, 255, 255, 255)
    end
    
    font("HelveticaNeue-Light")
    fontSize(40)
    textAlign(CENTER)
    textMode(CENTER)
    
    text(self.value, self.pos.x + self.size.x / 2, self.pos.y + self.size.y / 2)
end

function Button:hit(touch)
    local left = self.pos.x
    local right = self.pos.x + self.size.x
    local top = self.pos.y + self.size.y
    local bottom = self.pos.y
    if touch.x > left and touch.x < right
        and touch.y > bottom and touch.y < top then
        return true
    end
    return false
end
    
function Button:action()
    if self.kind == NUMBER then
        local value = self.value
        return function(engine)
            engine:input(value)
        end
    end
    
    local operation = self.operation
    return function(engine)
        engine:operate(operation)
    end
end
