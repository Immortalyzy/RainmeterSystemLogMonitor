--[[ 
;System Log monitor
;by immortalyzy
; Last update : 2019-02-28
; Created on  : 2019-02-28

; As Rainmeter does not provide loop functionalities, the scirpt will generate a command line
;   to get all the logs demanded
--]]
--[[ --------------------------------------------------------------------------------- 


--]]
--
--
--
--
--------------------------------------------------------------------------------------

-- Functions used
function mysplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

-- Rainmeter functions
---------------------------------------------------------------------------------------
function Initialize()
    -- Get the logs to extract from Rainmeter
    LogString = SKIN:GetVariable("Logs")

    -- Table of logs
    logs = mysplit(LogString, ",")
    n = #logs
end

function Update()
    Command = ""
    for i = 1, n, 1 do
        Command = Command .. "wevtutil qe "
        Command = Command .. logs[i]
        Command = Command .. " /c:5 /rd:true /f:text"
        if (i ~= n) then
            Command = Command .. " && "
        end
    end
    SKIN:Bang("!SetOption", "MeasureGetLogs", "Parameter", Command)
    return Command
end
---------------------------------------------------------------------------------------
