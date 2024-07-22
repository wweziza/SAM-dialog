local currentDialog = nil

 
    if currentDialog then
        SendNUIMessage({
            type = "hideDialog"
        })
    end

    currentDialog = {
        dialogid = dialogid,
        style = style
    }
    
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "showDialog",
        dialogid = dialogid,
        style = style,
        title = title,
        body = body,
        button1 = button1,
        button2 = button2
    })
end

RegisterNUICallback("SAM-dialog:Client:dialogResponse", function(data, cb)
    SetNuiFocus(false, false)
    
    if currentDialog then
        TriggerServerEvent("SAM-dialog:Server:OnDialogResponse", currentDialog.dialogid, data.response, data.listitem, data.inputtext)
        currentDialog = nil
    end
    
    SendNUIMessage({
        type = "hideDialog"
    })
    
    cb('ok')
end)


function AddMessage(message)
    TriggerEvent('chat:addMessage', {
        color = {255, 255, 255},
        multiline = true,
        args = {"System", message}
    })
end


RegisterNetEvent("addClientMessage")
AddEventHandler("addClientMessage", function(message)
    AddMessage(message)
end)


RegisterCommand("testlistdialog", function(source, args, rawCommand)
    local dialogid = 1
    local style = 2  -- DIALOG_STYLE_LIST
    local title = "Fruit Selection"
    local body = "Apple\n{FFFF00}Mango\nMelon"
    local button1 = "Select"
    local button2 = "Cancel"
    ShowPlayerDialog(GetPlayerServerId(PlayerId()), dialogid, style, title, body, button1, button2)
end, false)


RegisterCommand("testdialog", function(source, args, rawCommand)
    local dialogid = 1
    local style = 0  -- DIALOG_STYLE_MSGBOX
    local title = "Test Dialog"
    local body = "This is a test dialog."
    local button1 = "OK"
    local button2 = "Cancel"
    ShowPlayerDialog(GetPlayerServerId(PlayerId()), dialogid, style, title, body, button1, button2)
end, false)


RegisterNetEvent("SAM-dialog:Client:showClientDialog")
AddEventHandler("SAM-dialog:Client:showClientDialog", function(dialogid, style, title, body, button1, button2)
    ShowPlayerDialog(GetPlayerServerId(PlayerId()), dialogid, style, title, body, button1, button2)
end)