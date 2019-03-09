--[[ 
;System Log monitor
;by immortalyzy
; Last update : 2019-02-28
; Created on  : 2019-02-28

;This is the lua script that manages the event log to an easier to read format
--]]
--[[ --------------------------------------------------------------------------------- 


--]]
--
--
--
--
--------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------

-- Rainmeter functions
--------------------------------------------------------------------------------------
function Initialize()
    -- Get the logs to extract from Rainmeter
    LogString = SKIN:GetMeasure('MeasureGetLogs')
end

function Update()
    _log = LogString:GetStringValue()
    local R = ''
    local Rs = {}
    local _logs = split(_log, 'Event%[.%]:')
    local n = #_logs
    -- Catch useful info and match final string
    -----------------------------------------------------------------
    for i = 1, n, 1 do
        local _logss = {}
        local _lines = split(_logs[i], '\n')
        local m = #_lines
        for j = 1, m, 1 do
            tmp = 0
            tmp = string.find(_lines[j], 'Log Name:')
            if (tmp ~= nil) then
                _logss['LogName'] = string.sub(_lines[j], tmp + 10)
            end

            tmp = string.find(_lines[j], 'Date:')
            if (tmp ~= nil) then
                _logss['Date'] = string.sub(_lines[j], tmp + 6)
            end

            tmp = string.find(_lines[j], 'Source:')
            if (tmp ~= nil) then
                _logss['Source'] = string.sub(_lines[j], tmp + 8)
            end

            tmp = string.find(_lines[j], 'Level:')
            if (tmp ~= nil) then
                _logss['Level'] = string.sub(_lines[j], tmp + 7)
            end
        end
        ------
        tmp = string.find(_logs[i], 'Description:')
        if (tmp ~= nil) then
            _logss['Description'] = string.sub(_logs[i], tmp + 13)
            local desps = split(_logss.Description, '\n')
            local desp = ''
            for k = 1, #desps, 1 do
                desp = desp .. desps[k]
            end
            _logss['Content'] = desp
        end
        -- Add to all logs
        tmps = ''
        tmps = tmps .. _logss.Date
        tmps = tmps .. ' -- '
        tmps = tmps .. _logss.LogName
        if (string.find(_logss.Level, 'Error')) then
            tmps = tmps .. ' \t-X '
        else
            tmps = tmps .. ' \t-- '
        end
        tmps = tmps .. _logss.Level
        tmps = tmps .. ' \t-- '
        tmps = tmps .. _logss.Content
        Rs[i] = tmps
        -- Build final string
        R = R .. '\n'
        R = R .. Rs[i]
        R = R .. '\n'
    end

    return R
end
--------------------------------------------------------------------------------------
