--buttons
table.insert(ctrls, {Name = "Submit", ControlType = "Button", ButtonType = "Trigger", Count = 1, UserPin = true, PinStyle = "Both", Icon = "Save"})
table.insert(ctrls, {Name = "ID", ControlType = "Button", ButtonType = "Toggle", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls, {Name = "Refresh", ControlType = "Button", ButtonType = "Trigger", Count = 1, UserPin = true, PinStyle = "Both", Icon = "Refresh"})
table.insert(ctrls, {Name = "SubmitDNSServer", ControlType = "Button", ButtonType = "Trigger", Count = 1, UserPin = true, PinStyle = "Both", Icon = "Plus"})
table.insert(ctrls, {Name = "SubmitSearchDomain", ControlType = "Button", ButtonType = "Trigger", Count = 1, UserPin = true, PinStyle = "Both", Icon = "Plus"})
table.insert(ctrls, {Name = "RemoveDNSServer", ControlType = "Button", ButtonType = "Trigger", Count = 1, UserPin = true, PinStyle = "Both", Icon = "Trash"})
table.insert(ctrls, {Name = "RemoveSearchDomain", ControlType = "Button", ButtonType = "Trigger", Count = 1, UserPin = true, PinStyle = "Both", Icon = "Trash"})
table.insert(ctrls, {Name = "SubmitStaticRoute", ControlType = "Button", ButtonType = "Trigger", Count = 4, UserPin = true, PinStyle = "Both"})

--text
table.insert(ctrls, {Name = "Hostname", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls, {Name = "CoreIP", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls, {Name = "Status", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls, {Name = "DNSServers", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"}) --List Box
table.insert(ctrls, {Name = "DNSSearchDomains", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"}) --List Box
table.insert(ctrls, {Name = "AddedDNSServer", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls, {Name = "AddedSearchDomain", ControlType = "Text", Count = 1, UserPin = true, PinStyle = "Both"})
table.insert(ctrls, {Name = "MacAddress", ControlType = "Text", Count = 4, UserPin = true, PinStyle = "Both"})
table.insert(ctrls, {Name = "LinkSpeed", ControlType = "Text", Count = 4, UserPin = true, PinStyle = "Both"})
table.insert(ctrls, {Name = "Mode", ControlType = "Text", Count = 4, UserPin = true, PinStyle = "Both"}) --List Box
table.insert(ctrls, {Name = "IPAddress", ControlType = "Text", Count = 4, UserPin = true, PinStyle = "Both"})
table.insert(ctrls, {Name = "NetMask", ControlType = "Text", Count = 4, UserPin = true, PinStyle = "Both"})
table.insert(ctrls, {Name = "Gateway", ControlType = "Text", Count = 4, UserPin = true, PinStyle = "Both"})
table.insert(ctrls, {Name = "Link", ControlType = "Text", Count = 4, UserPin = true, PinStyle = "Both"})
table.insert(ctrls, {Name = "StaticRoutes", ControlType = "Text", Count = 4, UserPin = true, PinStyle = "Both"}) --List Box
table.insert(ctrls, {Name = "StaticRoutesIP", ControlType = "Text", Count = 4, UserPin = true, PinStyle = "Both"})
table.insert(ctrls, {Name = "StaticRoutesNetMask", ControlType = "Text", Count = 4, UserPin = true, PinStyle = "Both"})
table.insert(ctrls, {Name = "StaticRoutesGateway", ControlType = "Text", Count = 4, UserPin = true, PinStyle = "Both"})