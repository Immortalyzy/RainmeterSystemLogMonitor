--[[ 
;System Log monitor
;by immortalyzy
; Last update : 2019-03-05
; Created on  : 2019-02-28

; the scirpt will generate a command line to get all the logs demanded
--]]
--
--
--

-- Functions used
----------------------------------------------------------------------------------
function split(str, pat)
    local t = {} -- NOTE: use {n = 0} in Lua-5.0
    local fpat = '(.-)' .. pat
    local last_end = 1
    local s, e, cap = str:find(fpat, 1)
    while s do
        if s ~= 1 or cap ~= '' then
            table.insert(t, cap)
        end
        last_end = e + 1
        s, e, cap = str:find(fpat, last_end)
    end
    if last_end <= #str then
        cap = str:sub(last_end)
        table.insert(t, cap)
    end
    return t
end
----------------------------------------------------------------------------------

-- Rainmeter functions
----------------------------------------------------------------------------------
function Initialize()
    -- Get the logs to extract from Rainmeter
    LogString = SKIN:GetVariable('Logs', 'System')

    -- Table of logs
    logs = split(LogString, ',')
    n = #logs
    Command = ''
    for i = 1, n, 1 do
        Command = Command .. 'wevtutil qe '
        Command = Command .. logs[i]
        Command = Command .. ' /c:4 /rd:true /f:text'
        if (i ~= n) then
            Command = Command .. ' && '
        end
    end
    SKIN:Bang('!SetVariable', 'CMD', Command)
    return Command
end
----------------------------------------------------------------------------------
