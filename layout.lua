local CurrentPage = PageNames[props["page_index"].Value]
local nics = {"Lan A", "Lan B", "Aux A", "Aux B"}
local lanInfo = {
  {label = "MAC Address:",pos = {15,82}}, 
  {label = "Link Speed:",pos = {211,82}}, 
  {label = "Mode:",pos = {15,138}}, 
  {label = "IP Address:",pos = {155,138}}, 
  {label = "Net Mask:",pos = {297,138}}, 
  {label = "Gateway:",pos = {437,138}}, 
  {label = "Static Routes:",pos = {15,189}}, 
  {label = "IP Address:",pos = {15,206}}, 
  {label = "Net Mask:",pos = {155,206}}, 
  {label = "Gateway:",pos = {297,206}}
}

function commonControls(statusPos)
  layout["Status"] = {PrettyName = "Status", Style = "Text", Position = statusPos, Size = {557,23}, Color = {194,194,194}, FontSize = 12}
  layout["Submit"] = {PrettyName = "Submit", Style = "Button", Position = {486,15}, Size = {43,36}, Color = {13, 59, 106}, UnlinkOffColor = true, OffColor = {40, 126, 222}}
  layout["Refresh"] = {PrettyName = "Refresh", Style = "Button", Position = {532,15}, Size = {43,36}, Color = {255,255,255}, UnlinkOffColor = true, OffColor = {124,124,124}}
end

if CurrentPage == "Setup" then
  table.insert(graphics,{Type = "GroupBox", Text = "Setup", Fill = {210,220,255}, StrokeWidth = 1, Position = {5,5}, Size = {582,191}, CornerRadius = 8, IsBold = true})
  table.insert(graphics,{Type = "GroupBox", Text = "Connection Setup", StrokeWidth = 1, Position = {18,18}, Size = {170,127}, CornerRadius = 8, IsBold = true})
  table.insert(graphics,{Type = "Text", Text = "Core IP:", Position = {25,59}, Size = {154,22}, FontSize = 14,HTextAlign = "Left", IsBold = true})
  table.insert(graphics,{Type = "Text", Text = "Hostname:", Position = {229,42}, Size = {86,17}, FontSize = 12, HTextAlign = "Left", IsBold = true})
  table.insert(graphics,{Type = "Text", Text = "ID:", Position = {229,92}, Size = {31,19}, FontSize = 12, HTextAlign = "Left", IsBold = true})

  layout["CoreIP"] = {PrettyName = "Setup~Core IP", Style = "Text", Position = {25,81}, Size = {155,23}, FontSize = 12, HTextAlign = "Left"}
  layout["Hostname"] = {PrettyName = "Setup~Hostname", Style = "Text", Position = {229,59}, Size = {151,23}, FontSize = 12, HTextAlign = "Left"}
  layout["ID"] = {PrettyName = "Setup~ID", Style = "Button", Position = {229,111}, Size = {49,29}}

  commonControls({17,163})
elseif CurrentPage == "Lan A" then
  commonControls({15,342})
elseif CurrentPage == "Lan B" then
  commonControls({15,342})
elseif CurrentPage == "Aux A" then
  commonControls({15,342})
elseif CurrentPage == "Aux B" then
  commonControls({15,342})
elseif CurrentPage == "DNS" then
  table.insert(graphics,{Type = "GroupBox", Text = "DNS", Fill = {210,220,255}, StrokeWidth = 1, Position = {5,5}, Size = {585,274}, CornerRadius = 8, IsBold = true})
  table.insert(graphics,{Type = "Text", Text = "DNS", Position = {20,18}, Size = {86,17}, FontSize = 14, HTextAlign = "Left", IsBold = true})
  table.insert(graphics,{Type = "Text", Text = "DNS Servers", Position = {20,74}, Size = {86,17}, FontSize = 12, HTextAlign = "Left", IsBold = true})
  table.insert(graphics,{Type = "Text", Text = "Search Domains", Position = {276,73}, Size = {112,17}, FontSize = 12, HTextAlign = "Left", IsBold = true})
  
  layout["AddedDNSServer"] = {PrettyName = "DNS~DNS Server", Style = "Text", Position = {112,70}, Size = {106,25}, FontSize = 12}
  layout["AddedSearchDomain"] = {PrettyName = "DNS~Search Domain", Style = "Text", Position = {369,70}, Size = {106,25}, FontSize = 12}
  layout["SubmitDNSServer"] = {PrettyName = "DNS~Add DNS Server", Style = "Button", Position = {227,70}, Size = {36,25}, Color = {255,255,255}, UnlinkOffColor = true, OffColor = {124,124,124}, Margin = 0}
  layout["SubmitSearchDomain"] = {PrettyName = "DNS~Add Search Domain", Style = "Button", Position = {483,70}, Size = {36,25}, Color = {255,255,255}, UnlinkOffColor = true, OffColor = {124,124,124}, Margin = 0}
  layout["DNSServers"] = {PrettyName = "DNS~DNS Servers", Style = "ListBox", Position = {20,104}, Size = {243,105}, FontSize = 12}
  layout["DNSSearchDomains"] = {PrettyName = "DNS~DNS Search Domains", Style = "ListBox", Position = {276,104}, Size = {243,105}, FontSize = 12}
  layout["RemoveDNSServer"] = {PrettyName = "DNS~Remove DNS Server", Style = "Button", Position = {20,209}, Size = {243,29}, Color = {255,255,255}, UnlinkOffColor = true, OffColor = {124,124,124}}
  layout["RemoveSearchDomain"] = {PrettyName = "DNS~Remove Search Domain", Style = "Button", Position = {276,209}, Size = {243,29}, Color = {255,255,255}, UnlinkOffColor = true, OffColor = {124,124,124}}
  commonControls({20,247})
end

for i, v in ipairs(nics) do
  if CurrentPage == v then
    table.insert(graphics,{Type = "GroupBox", Fill = {210,220,255}, StrokeWidth = 1, Position = {5,5}, Size = {580,376}, CornerRadius = 8})
    table.insert(graphics,{Type = "Text", Text = v, Position = {15,20}, Size = {86,17}, FontSize = 16, HTextAlign = "Left", IsBold = true})
    for j, lan in ipairs(lanInfo) do
      table.insert(graphics, {Type = "Text", Text = lan.label, Position = lan.pos, Size = {86,17}, FontSize = 12, HTextAlign = "Left", IsBold = true})
    end

    layout["Link "..i] = {PrettyName = v.."~Link", Style = "Text", Position = {15,48}, Size = {54,23}, FontSize = 10, Color={255,255,255,0}, StrokeWidth=0}
    layout["MacAddress "..i] = {PrettyName = v.."~Mac Address", Style = "Text", Position = {15,99}, Size = {151,23}, FontSize = 12, Color={194,194,194}, HTextAlign = "Left"}
    layout["LinkSpeed "..i] = {PrettyName = v.."~Link Speed", Style = "Text", Position = {211,99}, Size = {151,23}, FontSize = 12, Color={194,194,194}, HTextAlign = "Left"}
    layout["Mode "..i] = {PrettyName = v.."~Mode", Style = "ComboBox", Position = {15,155}, Size = {107,23}, FontSize = 12, HTextAlign = "Left"}
    layout["IPAddress "..i] = {PrettyName = v.."~Lan IP Address", Style = "Text", Position = {155,155}, Size = {107,23}, FontSize = 12, HTextAlign = "Left"}
    layout["NetMask "..i] = {PrettyName = v.."~Lan Net Mask", Style = "Text", Position = {297,155}, Size = {107,23}, FontSize = 12, HTextAlign = "Left"}
    layout["Gateway "..i] = {PrettyName = v.."~Lan Gateway", Style = "Text", Position = {437,155}, Size = {107,23}, FontSize = 12, HTextAlign = "Left"}
    layout["StaticRoutesIP "..i] = {PrettyName = v.."~Static Routes IP Address", Style = "Text", Position = {15,223}, Size = {107,23}, FontSize = 12, HTextAlign = "Left"}
    layout["StaticRoutesNetMask "..i] = {PrettyName = v.."~Static Routes Net Mask", Style = "Text", Position = {155,223}, Size = {107,23}, FontSize = 12, HTextAlign = "Left"}
    layout["StaticRoutesGateway "..i] = {PrettyName = v.."~Static Routes Gateway", Style = "Text", Position = {297,223}, Size = {107,23}, FontSize = 12, HTextAlign = "Left"}
    layout["SubmitStaticRoute "..i] = {PrettyName = v.."~Static Routes Add", Style = "Button", Position = {445,223}, Size = {69,23}, Color = {255,255,255}, UnlinkOffColor = true, OffColor = {124,124,124}, Margin = 0}
    layout["StaticRoutes "..i] = {PrettyName = v.."~Static Routes", Style = "ListBox", Position = {15,261}, Size = {557,64}, FontSize = 12, HTextAlign = "Left"}
  end
end

