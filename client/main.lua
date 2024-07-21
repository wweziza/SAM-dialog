local isDialogOpen = false

-- Function to show dialog
function ShowDialog(title, content, callback)
    if not isDialogOpen then
        isDialogOpen = true
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "showDialog",
            title = title,
            content = content
        })
    end
end

-- NUI Callback for when dialog is closed
RegisterNUICallback("dialogClosed", function(data, cb)
    isDialogOpen = false
    SetNuiFocus(false, false)
    TriggerServerEvent("dialogResponse", data.response, data.inputText)
    cb('ok')
end)

-- Command to test dialog
RegisterCommand("testdialog", function(source, args, rawCommand)
    ShowDialog("Test Dialog", "This is a test dialog. Enter some text:")
end, false)

-- Event handler for server-triggered dialogs
RegisterNetEvent("showClientDialog")
AddEventHandler("showClientDialog", function(title, content)
    ShowDialog(title, content)
end)