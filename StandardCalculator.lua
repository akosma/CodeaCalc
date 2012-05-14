StandardCalculator = class()

OFFSET = 100
BUTTON_WIDTH = 100
BUTTON_HEIGHT = 80
PADDING = 5
INCREMENT_H = BUTTON_WIDTH + PADDING
INCREMENT_V = BUTTON_HEIGHT + PADDING
BUTTON_SIZE = vec2(BUTTON_WIDTH, BUTTON_HEIGHT)
BIG_BUTTON_SIZE = vec2(BUTTON_WIDTH * 2 + PADDING, BUTTON_HEIGHT)

function StandardCalculator:init()
    
    function position(x, y)
        return vec2(OFFSET + INCREMENT_H * x, OFFSET + INCREMENT_V * y)
    end

    local button0  = Button("0",  position(0, 0), BIG_BUTTON_SIZE)
    local button1  = Button("1",  position(0, 1), BUTTON_SIZE)
    local button2  = Button("2",  position(1, 1), BUTTON_SIZE)
    local button3  = Button("3",  position(2, 1), BUTTON_SIZE)
    local button4  = Button("4",  position(0, 2), BUTTON_SIZE)
    local button5  = Button("5",  position(1, 2), BUTTON_SIZE)
    local button6  = Button("6",  position(2, 2), BUTTON_SIZE)
    local button7  = Button("7",  position(0, 3), BUTTON_SIZE)
    local button8  = Button("8",  position(1, 3), BUTTON_SIZE)
    local button9  = Button("9",  position(2, 3), BUTTON_SIZE)
    local buttonAC = Button("AC", position(0, 4), BUTTON_SIZE, OPERATOR, "AC")
    local buttonMR = Button("M+", position(1, 4), BUTTON_SIZE, OPERATOR, "M+")
    local buttonMC = Button("MR", position(2, 4), BUTTON_SIZE, OPERATOR, "MR")
    
    local buttonDot =      Button(".", position(2, 0), BUTTON_SIZE, OPERATOR, ".")
    local buttonPlus =     Button("+", position(3, 1), BUTTON_SIZE, OPERATOR, "+")
    local buttonMinus =    Button("-", position(3, 2), BUTTON_SIZE, OPERATOR, "-")
    local buttonTimes =    Button("x", position(3, 3), BUTTON_SIZE, OPERATOR, "*")
    local buttonDivision = Button("÷", position(3, 4), BUTTON_SIZE, OPERATOR, "/")
    local buttonEqual =    Button("=", position(3, 0), BUTTON_SIZE, OPERATOR, "=")
    
    self.display = Display("0.0", 
                            position(0, 5),
                            vec2(INCREMENT_H * 4 - PADDING, BUTTON_HEIGHT))
                            
    self.engine = Engine()
    
    self.buttons = { button0, button1, button2, button3, 
                    button4, button5, button6, 
                    button7, button8, button9, 
                    buttonDot, buttonPlus, buttonMinus, 
                    buttonTimes, buttonDivision, buttonEqual,
                    buttonAC, buttonMR, buttonMC }
end

function StandardCalculator:draw()
    background(67, 67, 67, 210)

    -- Draw the buttons
    for index, button in pairs(self.buttons) do
        self.buttons[index]:draw()
    end
    
    -- Draw the display
    self.display:draw()
end

function StandardCalculator:touched(touch)
    local index, button
    for index, button in pairs(self.buttons) do
        if button:hit(touch) then
            if touch.state == BEGAN then
                button.touched = true
            elseif touch.state == ENDED then
                button.touched = false
                local action = button:action()
                action(self.engine)
                self.engine:update(self.display)
            end
        else
            button.touched = false
        end
    end
end