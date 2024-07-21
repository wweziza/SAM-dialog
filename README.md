# SAM Dialog
Is sa-mp dialog design-look-a-like for FiveM, the function and usage are same like the sa-mp docs, yet another utility if you do miss a masterpiece memories

### Screenshot
<details>
  <summary>Screenshot 1</summary>
  <img src="./images/1.png" alt="Screenshot 1">
</details>

<details>
  <summary>Screenshot 2</summary>
  <img src="./images/2.png" alt="Screenshot 2">
</details>

<details>
  <summary>Screenshot 3</summary>
  <img src="./images/3.png" alt="Screenshot 3">
</details>- 


# Usage
The usage is pretty simple just put it on your `resources` files and `ensure SAM-dialog` in server.cfg, you can use both in server or client side.

```lua
RegisterCommand("serverdialog", function(source, args, rawCommand)
    local dialogid = 5
    local style = 1  -- DIALOG_STYLE_INPUT
    local title = "Server Dialog"
    local body = "This dialog was triggered from the server. Enter some text:"
    local button1 = "Submit"
    local button2 = "Close"
    ShowPlayerDialog(source, dialogid, style, title, body, button1, button2)
end, false)
```


## Callback

Every functions trigger  server event called 

```lua
AddEventHandler("OnDialogResponse", function(dialogid, response, listitem, inputtext)end)
```

## DIALOG_STYLE:style

```lua
Style 0: DIALOG_STYLE_MSGBOX
Style 1: DIALOG_STYLE_INPUT
Style 2: DIALOG_STYLE_LIST
Style 3: DIALOG_STYLE_PASSWORD
Style 4: DIALOG_STYLE_TABLIST
Style 5: DIALOG_STYLE_TABLIST_HEADERS
```

## ShowPlayerDialog

The `ShowPlayerDialog` function is used to show a dialog to a player.
|---------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Name          | Description                                                                                                                                                        |
|---------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| playerid      | The ID of the player to show the dialog to.                                                                                                                        |
| dialogid      | An ID to assign this dialog to, so responses can be processed. Max dialogid is 32767. Using negative values will close any open dialog.                            |
| style         | The style of the dialog.                                                                                                                                           |
| title         | The title at the top of the dialog. The length of the caption cannot exceed more than 64 characters before it starts to cut off.                                   |
| body          | The text to display in the main dialog. Use `\n` to start a new line and `\t` to tabulate.                                                                         |
| button1       | The text on the left button.                                                                                                                                       |
| button2       | The text on the right button. Leave it blank ( `""` ) to hide it.                                                                                                  |
|---------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|

## OnDialogResponse

This event is called when a player responds to a dialog shown using `ShowPlayerDialog` by either clicking a button, pressing ENTER/ESC or double-clicking a list item (if using a list style dialog).
|---------------|-----------------------------------------------------------------------------------------------------------|
| Name       | Description                                                                                                  |
|------------|--------------------------------------------------------------------------------------------------------------|
| playerid   | The ID of the player that responded to the dialog.                                                           |
| dialogid   | The ID of the dialog the player responded to, assigned in `ShowPlayerDialog`.                                |
| response   | 1 for left button and 0 for right button (if only one button shown, always 1)                                |
| listitem   | The ID of the list item selected by the player (starts at 0).                                                |
| inputtext  | The text entered into the input box by the player or the selected list item text.                            |
|------------|--------------------------------------------------------------------------------------------------------------|

It's still work in progress so it only support style 0-2.

Feel free to open an issue, and contribute are welcomed.