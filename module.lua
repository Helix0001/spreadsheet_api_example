--!strict

--[[ 
	Create your spreadsheet and set it up however you want,
	First get your spreadsheet ID, this is the string in the url after /d and before /edit
	Example: https://docs.google.com/spreadsheets/d/1Lw97X3EvOJDAn_vSNVUG09cNQLZUDrwhYNa6bJ-NsMM/edit#gid=0
	The spreadsheet ID is 1Lw97X3EvOJDAn_vSNVUG09cNQLZUDrwhYNa6bJ-NsMM

	You then need to create an API key if you haven't already which can be done here:
	https://console.developers.google.com/apis/credentials

	Make sure, if you haven't already that you have the Spreadsheet API enabled for that specific project, otherwise requests will be denied:
	https://console.cloud.google.com/apis/api/sheets.googleapis.com

	If you don't know your project ID, enter the request URL in your browser,
	there will be a link provided which takes you straight to where you need to be to enable it.
	
	If you recieve an error: 403 The caller does not have permission, I fixed this by clicking "Share" at the top right
	and setting the mode "Anyone who has a link"
]]

local HTTPService = game:GetService('HttpService')

local SpreadsheetID = '1Lw97X3EvOJDAn_vSNVUG09cNQLZUDrwhYNa6bJ-NsMM'
local API_KEY = 'AIzaSyBVYZNpLrzV9Rv1_Q8CyaDmT6UX8v_oyY4'

local request_url = 'https://sheets.googleapis.com/v4/spreadsheets/%s%s'  --Format with: SpreadsheetID, args

local module = {}
export type Type = typeof(module)

-- USAGE: handler:getValues('A1:Z10')
function module.getValues(self: Type, range: string): {['Returns a table of JSON data if successfull']:any}?
	local args = ("/values/%s?key=%s"):format(range, API_KEY)
	local url = string.format(request_url, SpreadsheetID, args)
	local success, response = pcall(function()
		return HTTPService:GetAsync(url)
	end)

	if success then
		return HTTPService:JSONDecode(response)
	else
		error(response)
		return {}
	end
end

return module
