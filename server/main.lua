
function ShowPlayerDialog(playerid, dialogid, style, title, body, button1, button2)
    TriggerClientEvent("showClientDialog", playerid, dialogid, style, title, body, button1, button2)
end


function SendClientMessage(playerid, message)
    TriggerClientEvent("addClientMessage", playerid, message)
end


RegisterServerEvent("OnDialogResponse")
AddEventHandler("OnDialogResponse", function(dialogid, response, listitem, inputtext)
    local source = source
    print(string.format("OnDialogResponse: playerid = %d, dialogid = %d, response = %s, listitem = %d, inputtext = %s",
        source, dialogid, response and "true" or "false", listitem, inputtext))
    
    
    if dialogid == 1 and response then
        local fruits = {"Apple", "Mango", "Melon"}
        local selectedFruit = fruits[listitem + 1]
        if selectedFruit then
            SendClientMessage(source, "You selected: " .. selectedFruit)
        end
    end
end)


RegisterCommand("serverlistdialog", function(source, args, rawCommand)
    local dialogid = 1
    local style = 2  -- DIALOG_STYLE_LIST
    local title = "Fruit Selection"
    local body = "Apple\n{FFFF00}Mango\nMelon"
    local button1 = "Select"
    local button2 = "Cancel"
    ShowPlayerDialog(source, dialogid, style, title, body, button1, button2)
end, false)