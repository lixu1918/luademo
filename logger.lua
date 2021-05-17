-- Create a default log file named lualogging.log when the "logger" module is required.
-- Lualogging is dependent and add to this repo as a submodule.
-- cd lualogging
-- make install
--
-- Usage:
-- require("logger")
-- logger.info("msg")
-- logger.error("msg")

local modName = "logger"
local M = {}
_G[modName] = M
package.loaded[modName] =  M

require "logging.rolling_file"

local logfile;
if not logfile then
    logfile = logging.rolling_file {
        --filename = os.date("log-%Y%m%d-%X.log", os.time()),
        -- default filename: lualogging.log
        -- 10M * 50 = 500M log files totally
        -- lualogging.log.1
        -- lualogging.log.2
        -- ...
        -- lualogging.log.50
        maxFileSize = 1024*1024*10,
        maxBackupIndex = 50,
        datePattern = "%Y-%m-%d",
        timestampPattern = "%Y%m%d %X",
    }
end

local function __FILE__()
    return debug.getinfo(3, 'S').source
end

local function __LINE__()
    return debug.getinfo(3, 'l').currentline
end

local function __FUNC__()
    return debug.getinfo(3, 'n').name
end

function M.info(msg)
    local file = __FILE__()
    local line = __LINE__()
    local func = __FUNC__()
    local msg_str = ""
    if (func) then
        msg_str = file.." "..func.." "..line.." "..msg
    else
        msg_str = file.." "..line.." "..msg
    end
    logfile:info(msg_str)
end

function M.debug(msg)
    local file = __FILE__()
    local line = __LINE__()
    local func = __FUNC__()
    local msg_str = ""
    if (func) then
        msg_str = file.." "..func.." "..line.." "..msg
    else
        msg_str = file.." "..line.." "..msg
    end
    logfile:debug(msg_str)
end

function M.error(msg)
    local file = __FILE__()
    local line = __LINE__()
    local func = __FUNC__()
    local msg_str = ""
    if (func) then
        msg_str = file.." "..func.." "..line.." "..msg
    else
        msg_str = file.." "..line.." "..msg
    end
    logfile:error(msg_str)
end
