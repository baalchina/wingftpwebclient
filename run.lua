package.path = package.path..";"..c_GetAppPath().."/lua/?.lua"
_COOKIE = {}
_SESSION = {}
_POST = {}
_GET = {}
_SERVER = {}
_SETCOOKIE = ""
_USERNAME = ""
_NOWPATH = ""
_CONTENTTYPE = "text/html"
_STARTCLOCK = os.clock()
_SESSION_ID = nil

WEB_USER_LOGIN_EVENT = 0
WEB_DIR_CREATE_EVENT = 1
WEB_DIR_DELETE_EVENT = 2
WEB_EXCEED_USERPASS_EVENT = 3
WEB_FILE_BANNED_EVENT = 4
WEB_FILE_DELETE_EVENT = 5
WEB_FILE_DOWNLOAD_EVENT = 6
WEB_FILE_RENAME_EVENT = 7
WEB_FILE_UPLOAD_EVENT = 8
WEB_QUOTA_EXCEED_EVENT = 9
WEB_TOOMANY_CONNECTION_PERIP_EVENT = 10
WEB_TOOMANY_CONNECTION_PERACCOUT_EVENT = 11
WEB_IP_BANNED_EVENT = 12
WEB_CHANGE_PASSWORD = 13
WEB_EXCEED_LIMIT = 14
WEB_EXCEED_MAX_SESSION_ON_GROUP = 15
WEB_EXCEED_MAX_SESSION_PER_IP_ON_GROUP = 16
WEB_EXCEED_MAX_SESSION_ON_DOMAIN = 17
WEB_EXCEED_MAX_SESSION_PER_IP_ON_DOMAIN = 18
WEB_USER_DISCONNECT_EVENT = 19

ERROR_PASS = -1
ERROR_MAX_CONNECT = -2
ERROR_MAX_IP = -3
ERROR_IP_BANNED = -4
ERROR_UNKNOWN = -5
ERROR_USER_EXPIRED = -6
ERROR_PROTOCOL_FORBIDDEN = -7
ERROR_ACCOUNT_DISABLED_WFTP = -8
ERROR_ACCESS_TIME = -9
ERROR_MAX_CONNECT_GROUP = -10
ERROR_MAX_IP_GROUP = -11
ERROR_MAX_CONNECT_DOMAIN = -12
ERROR_MAX_IP_DOMAIN = -13
ERROR_GUEST_ENABLED = -14
OK_CHECK_CONNECTION = 1

DOMAIN_LOG_WEB_COMMAND = 5
DOMAIN_LOG_WEB_RESPOND = 6


local function runpage()
	require("SessionModule")
	require("cgi")

	init_all()
	incfiles = {}
	include(filetorun)
	incfiles = nil

	package.loaded["SessionModule"] = nil
	package.loaded["cgi"] = nil
	setmetatable(_COOKIE,nil)
	setmetatable(_SESSION,nil)
end

local status,err = pcall(runpage)
if not status then
	print(string.format("<b>some internal error in %s!</b>",err))

	package.loaded["SessionModule"] = nil
	package.loaded["cgi"] = nil
	setmetatable(_COOKIE,nil)
	setmetatable(_SESSION,nil)
end