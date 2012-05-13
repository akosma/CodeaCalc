function setup()
    standardCalculator = StandardCalculator()
end

function draw()
    standardCalculator:draw()
end

function touched(touch)
    standardCalculator:touched(touch)
end

