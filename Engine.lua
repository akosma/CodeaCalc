Engine = class()

IDLE = 0
INPUT = 1

function Engine:init()
    self.stack = {}
    self.state = IDLE
    self.current = "0.0"
    self.dot = false
    self.memory = 0
end

function Engine:operate(operator)
    
    function default()
        table.insert(self.stack, self.current)
        table.insert(self.stack, operator)
        self.current = "0.0"
        self.dot = false
    end
    
    function reset()
        self.stack = {}
        self.state = IDLE
        self.dot = false
    end
    
    if operator == "=" then
        table.insert(self.stack, self.current)
        self:calculate()
        reset()
    elseif operator == "." then
        if not self.dot then
            self.dot = true
            self:input(".")
        end
    elseif operator == "+" then
        default()
    elseif operator == "-" then
        default()
    elseif operator == "*" then
        default()
    elseif operator == "/" then
        default()
    elseif operator == "AC" then
        reset()
        self.current = "0.0"
    elseif operator == "MR" then
        self.current = self.memory
    elseif operator == "M+" then
        local increment = "return " .. self.memory .. " + " .. self.current
        local f = loadstring(increment)
        self.memory = f()
        self.state = IDLE
    else
        return
    end
end

function Engine:input(number)
    if self.current == "0.0" then
        self.current = ""
    end
    
    if self.state == IDLE then
        self.state = INPUT
        self.current = ""
    end
    
    if string.len(self.current) < 10 then
        self.current = self.current .. number
    end
end

function Engine:update(display)
    display.value = self.current
    display.memory = (self.memory ~= 0)
end

function Engine:calculate()
    local formula = table.concat(self.stack, " ")
    local f = loadstring("return " .. formula)
    local result = f()
    print(formula .. " = " .. result)
    self.current = result
end
