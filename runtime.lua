json = require('rapidjson')

--Controls
local hostname = Controls.Hostname
local ID = Controls.ID
local dnsServers = Controls.DNSServers
local dnsSearchDomains = Controls.DNSSearchDomains
local removeDNSServer = Controls.RemoveDNSServer
local removeSearchDomain = Controls.RemoveSearchDomain
local staticRoutesIP = Controls.StaticRoutesIP
local staticRoutesNetMask = Controls.StaticRoutesNetMask
local staticRoutesGateway = Controls.StaticRoutesGateway
local submitStaticRoute = Controls.SubmitStaticRoute
local staticRoutes = Controls.StaticRoutes
local macAddress = Controls.MacAddress
local chassis = Controls.Chassis
local linkSpeed = Controls.LinkSpeed
local mode = Controls.Mode
local ipAddress = Controls.IPAddress
local netMask = Controls.NetMask
local gateway = Controls.Gateway
local link = Controls.Link
local addedDNSServer = Controls.AddedDNSServer
local submitDNSServer = Controls.SubmitDNSServer
local addedSearchDomain = Controls.AddedSearchDomain
local submitSearchDomain = Controls.SubmitSearchDomain
local submit = Controls.Submit
local coreIP = Controls.CoreIP
local status = Controls.Status
local refresh = Controls.Refresh

local modeOptions = {"auto", "static", "off"}
local nics = {"LAN A", "LAN B", "AUX A", "AUX B"}
local dnsServersFromData = {}
local dnsSearchDomainsFromData = {}
local staticRoutesLanA = {}
local staticRoutesLanB = {}
local numOfInterfaces

function setInterfaceTbl()
  local interfaceTbl = {}
  for i = 1, numOfInterfaces do
    table.insert(interfaceTbl, {
      name = nics[i],
      id = nics[i],
      mode = mode[i].String,
      ipAddress = ipAddress[i].String,
      netMask = netMask[i].String,
      gateway = gateway[i].String,
      staticRoutes = parseStaticRoutes(staticRoutes[i].Choices)
      -- macAddress = macAddress[i].String,
      -- chassis = chassis[i].String,
      -- port = "",
      -- linkSpeed = linkSpeed[i].String,
      -- hasLink = true
    })
  end
  return interfaceTbl
end

function setDataVar()
  return json.encode({
    hostname = hostname.String,
    interfaces = setInterfaceTbl(),
    dnsServers = dnsServersFromData,
    dnsSearchDomains = dnsSearchDomainsFromData
  })
end

function setStatusForPut(err, code, data)
  if err ~= nil or code ~= 201 then 
    status.String = math.floor(code)..": "..err
    else status.String = "Successfully updated data"
  end
  if data.message ~= nil then 
    status.String = math.floor(code)..": "..data.message
  end
end

function setStatusForGet(err, code, data)
  if err ~= nil or code ~= 200 then 
    status.String = math.floor(code)..": "..err
    if code == 404 then 
      status.String = "404 Not Found"
    end
  end
  if data.message ~= nil then 
    status.String = math.floor(code)..": "..data.message
  end
end

function setLinkStatus(link)
  if link == true then 
    return ""
  else return "(No Link)"
  end
end

function createDNSServersTable(data)
  local dnsServersTable = {}
  for i, interface in ipairs(data.interfaces) do 
    if interface.gateway ~= "" and interface.mode == "auto" then 
      table.insert(dnsServersTable, interface.gateway)
    end
  end
  table.insert(dnsServersTable, "________________________")
  for i, dnsServer in ipairs(data.dnsServers) do 
    table.insert(dnsServersTable, dnsServer)
  end
  return dnsServersTable
end

function handleNetworkPut(tbl, code, d, e)
  print(string.format("Response Code for Network PUT: %i\t\tErrors: %s",code, e or "None"))
  setStatusForPut(e, code, json.decode(d))
  getNetworkData() 
end

function handleNetworkGet(tbl, code, d, e)
  print(string.format("Response Code for Network GET: %i\t\tErrors: %s",code, e or "None"))
  setStatusForGet(e, code, json.decode(d))
  local networkData = json.decode(d)
  numOfInterfaces = #networkData.interfaces
  hostname.String = networkData.hostname
  dnsServers.Choices = createDNSServersTable(networkData)
  dnsSearchDomains.Choices = networkData.dnsSearchDomains
  for i, nic in ipairs(networkData.interfaces) do
    macAddress[i].String = nic.macAddress
    linkSpeed[i].String = nic.linkSpeed
    chassis[i].String = nic.chassis
    mode[i].String = nic.mode
    ipAddress[i].String = nic.ipAddress
    netMask[i].String = nic.netMask
    gateway[i].String = nic.gateway
    link[i].String = setLinkStatus(nic.hasLink)
    staticRoutes[i].Choices = getStaticRoutesData(nic.staticRoutes)
  end
  dnsServersFromData = networkData.dnsServers
  dnsSearchDomainsFromData = networkData.dnsSearchDomains
  staticRoutesLanA = networkData.interfaces[1].staticRoutes
  staticRoutesLanB = networkData.interfaces[2].staticRoutes
end

function getStaticRoutesData(data) 
  local staticRoutesTbl = {}
  for i, v in ipairs(data) do 
    table.insert(staticRoutesTbl, v.ipAddress.." -- "..v.netMask.." -- "..v.gateway)
  end
  return staticRoutesTbl
end

function handleIDPut(tbl, code, d, e)
  print(string.format("Response Code for ID PUT: %i\t\tErrors: %s",code, e or "None"))
  -- setStatusForPut(e, json.decode(d).code, json.decode(d).message)
end

function handleIDGet(tbl, code, d, e)
  print(string.format("Response Code for ID GET: %i\t\tErrors: %s",code, e or "None"))
  setStatusForGet(e, code, json.decode(d))
  Controls.ID.Boolean = json.decode(d).mode
end

function setIDState()
  if Controls.ID.Boolean then 
    updateIDData(true)
  else 
    updateIDData(false)
  end
end

function setModeOptionsInit()
  for i = 1, 2 do 
    mode[i].Choices = modeOptions
  end
end

function getIndexInTable(tbl, val)
  local index={}
  for k,v in pairs(tbl) do
    index[v]=k
  end
  return index[val]
end

function deleteDNSServer() 
  local dnsTbl = dnsServers.Choices
  local comboBoxIndex = getIndexInTable(dnsServers.Choices, dnsServers.String)
  local dataIndex = getIndexInTable(dnsServersFromData, dnsServers.String)
  if dataIndex ~= nil then
    table.remove(dnsTbl, comboBoxIndex)
    table.remove(dnsServersFromData, dataIndex)
  end
  dnsServers.Choices = dnsTbl
end

function deleteSearchDomain()
  local index = getIndexInTable(dnsSearchDomains.Choices, dnsSearchDomains.String)
  table.remove(dnsSearchDomainsFromData, index)
  dnsSearchDomains.Choices = dnsSearchDomainsFromData
end

function addDNSServer()
  local dnsTbl = dnsServers.Choices
  -- This table is for ALL DNS servers and line that separates auto added DNS servers and user created ones.
  table.insert(dnsTbl, addedDNSServer.String)
  -- This table is for only the user added DNS servers
  table.insert(dnsServersFromData, addedDNSServer.String)
  dnsServers.Choices = dnsTbl
  addedDNSServer.String = ""
end

function addDNSSearchDomain()
  table.insert(dnsSearchDomainsFromData, addedSearchDomain.String)
  dnsSearchDomains.Choices = dnsSearchDomainsFromData
  addedSearchDomain.String = ""
end

function createStaticRoute(ix)
  for i = 1, ix do
    if ix == i then
      local staticRoutesLanATbl = staticRoutes[i].Choices
      table.insert(staticRoutesLanATbl, staticRoutesIP[i].String.." -- "..staticRoutesNetMask[i].String.." -- "..staticRoutesGateway[i].String)
      staticRoutes[i].Choices = staticRoutesLanATbl
      staticRoutesIP[i].String = ""
      staticRoutesNetMask[i].String = ""
      staticRoutesGateway[i].String = ""
    end
  end
end

function parseStaticRoutes(sr)
  local parsedDataTbl = {}
  local returnTbl = {}
  for i, v in ipairs(sr) do
    local parsedDataTbl = {}
    for w in string.gmatch(v, "%g+%x") do 
      table.insert(parsedDataTbl, w)
    end
    table.insert(returnTbl, {
      ipAddress = parsedDataTbl[1],
      netMask = parsedDataTbl[2],
      gateway = parsedDataTbl[3]
    })
  end
  if json.encode(returnTbl) ~= '{}' then
    return returnTbl
    else return json.decode('[]')
  end
end

function updateNetworkData() 
  HttpClient.Upload { 
    Url = "http://"..coreIP.String.."/api/v0/cores/self/config/network", 
    Method = "PUT",
    Headers = { 
      ["Content-Type"] = "application/json"
    }, 
    Timeout = 5, 
    Data = setDataVar(),
    EventHandler = handleNetworkPut
  }
end

function getNetworkData() 
  HttpClient.Download { 
    Url = "http://"..coreIP.String.."/api/v0/cores/self/config/network", 
    Method = "GET",
    Headers = { ["Content-Type"] = "application/json" } , 
    Timeout = 5, 
    EventHandler = handleNetworkGet
  }
end

function updateIDData(idState) 
  HttpClient.Upload { 
    Url = "http://"..coreIP.String.."/api/v0/cores/self/config/id_mode", 
    Method = "PUT",
    Headers = { 
      ["Content-Type"] = "application/json"
    }, 
    Timeout = 5, 
    Data = json.encode({mode = idState}),
    EventHandler = handleIDPut
  }
end

function getIDData() 
  HttpClient.Download { 
    Url = "http://"..coreIP.String.."/api/v0/cores/self/config/id_mode", 
    Method = "GET",
    Headers = { ["Content-Type"] = "application/json" } , 
    Timeout = 5, 
    EventHandler = handleIDGet
  }
end

function getDataInit()
  status.String = ""
  getIDData()
  getNetworkData()  
end

if coreIP.String ~= "" then
  getDataInit()
end

setModeOptionsInit()

submitDNSServer.EventHandler = addDNSServer
submitSearchDomain.EventHandler = addDNSSearchDomain
removeDNSServer.EventHandler = deleteDNSServer
removeSearchDomain.EventHandler = deleteSearchDomain
refresh.EventHandler = getDataInit
coreIP.EventHandler = getDataInit
ID.EventHandler = setIDState
submit.EventHandler = updateNetworkData
for i, v in ipairs(submitStaticRoute) do 
  v.EventHandler = function()
    createStaticRoute(i)
  end
end