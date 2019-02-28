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
-- Get the log in /f:text format

-- local hanle = os.execute

-- Rainmeter functions
function Initialize()
    -- Get the logs to extract from Rainmeter
    LogString = SKIN:GetMeasure("MeasureGetLogs")
end

function Update()
    MyVariable = LogString:GetStringValue()
    return MyVariable
end
