-- Moonloader SAMP Textdraw Detection Script for Android

local textdraws = {}

-- Function to scan all textdraws and store them in a table
function scanTextdraws()
    local totalTextdraws = getNumTextDraws()
    for i = 0, totalTextdraws - 1 do
        local id = i
        local text = getTextDrawString(id)
        if text ~= '' then
            textdraws[id] = text
        end
    end
end

-- Function to get textdraw by ID
function getTextdrawByID(id)
    return textdraws[id] or "Textdraw not found"
end

-- Function to log textdraws to a file
function logTextdraws()
    local file = io.open("textdraws_log.txt", "w")
    for id, text in pairs(textdraws) do
        file:write(string.format("ID: %d, Text: %s\n", id, text))
    end
    file:close()
end

-- Function to detect clicks on textdraws
function onClick(x, y)
    for id, text in pairs(textdraws) do
        if isMouseHoveringTextdraw(id, x, y) then
            return id  -- Return the ID of the clicked textdraw
        end
    end
end

-- Example usage of the functions
scanTextdraws()
logTextdraws()