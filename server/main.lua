-- Event handler for dialog responses
RegisterServerEvent("dialogResponse")
AddEventHandler("dialogResponse", function(response, inputText)
    local source = source
    print("Player " .. source .. " responded: " .. response)
    if inputText ~= "" then
        print("Input text: " .. inputText)
    end
    
    -- Example of sending a follow-up dialog
    if response == "OK" then
        TriggerClientEvent("showClientDialog", source, "Follow-up", "You clicked OK!")
    elseif response == "Cancel" then
        TriggerClientEvent("showClientDialog", source, "Follow-up", "You clicked Cancel!")
    end
end)

-- Command to trigger dialog from server (for testing)
RegisterCommand("serverdialog", function(source, args, rawCommand)
    TriggerClientEvent("showClientDialog", source, "Server Dialog", "This dialog was triggered from the server.")
end, false)