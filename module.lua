--!strict

--[[ 
	Create your spreadsheet and set it up however you want,
	First get your spreadsheet ID, this is the string in the url after /d and before /edit
	Example: https://docs.google.com/spreadsheets/d/ASD8ASDLKJASD1KJ1LKJ/edit#gid=0
	The spreadsheet ID is ASD8ASDLKJASD1KJ1LKJ

	You then need to create an API key if you haven't already which can be done here:
	https://console.developers.google.com/apis/credentials

	Make sure, if you haven't already that you have the Spreadsheet API enabled for that specific project, otherwise requests will be denied:
	https://console.cloud.google.com/apis/api/sheets.googleapis.com

	If you don't know your project ID, enter the request URL in your browser,
	there will be a link provided which takes you straight to where you need to be to enable it.
	
	If you recieve an error: 403 The caller does not have permission, I fixed this by clicking "Share" at the top right in the spreadsheet,
	and setting the viewing mode to "Anyone who has a link"
]]

local HTTP_SERVICE = game:GetService('HttpService')

local SPREADSHEET_ID = 'YourSpreadsheetID'
local API_KEY = 'YourAPIKey'

local REQUEST_URL = 'https://sheets.googleapis.com/v4/spreadsheets/%s%s'  --Format with: SpreadsheetID, args

local module = {}
export type Type = typeof(module)

-- USAGE: handler:getValues('A1:Z10')
function module.getValues(self: Type, range: string): {['Returns a table of JSON data if successful']:any}?
	local args = ("/values/%s?key=%s"):format(range, API_KEY)
	local url = string.format(REQUEST_URL, SPREADSHEET_ID, args)
	local success, response = pcall(function()
		return HTTP_SERVICE:GetAsync(url)
	end)

	if success then
		return HTTP_SERVICE:JSONDecode(response)
	else
		error(response)
		return {}
	end
end

return module
