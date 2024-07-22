// script.js
const dialog = document.getElementById('dialog');
const dialogTitle = document.getElementById('dialogTitle');
const dialogContent = document.getElementById('dialogContent');
const dialogInput = document.getElementById('dialogInput');
const dialogList = document.getElementById('dialogList');
const button1 = document.getElementById('button1');
const button2 = document.getElementById('button2');

let currentDialogId = null;

window.addEventListener('message', function(event) {
    const item = event.data;
    if (item.type === "showDialog") {
        currentDialogId = item.dialogid;
        dialogTitle.textContent = item.title;
        button1.textContent = item.button1;
        button2.textContent = item.button2;

        dialogInput.style.display = 'none';
        dialogList.style.display = 'none';
        dialogContent.style.display = 'none';

        switch(item.style) {
            case 0: // DIALOG_STYLE_MSGBOX
                dialogContent.style.display = 'block';
                dialogContent.textContent = item.body;
                break;
            case 1: // DIALOG_STYLE_INPUT
                dialogContent.style.display = 'block';
                dialogContent.textContent = item.body;
                dialogInput.style.display = 'block';
                break;
            case 2: // DIALOG_STYLE_LIST
                dialogList.style.display = 'block';
                dialogList.innerHTML = '';
                const items = item.body.split('\n');
                items.forEach((item, index) => {
                    const option = document.createElement('option');
                    option.value = index;
                    option.textContent = item.replace(/\{[A-Fa-f0-9]{6}\}/g, ''); // Remove color codes
                    if (item.includes('{FFFF00}')) {
                        option.style.color = '#FFFF00';
                    }
                    dialogList.appendChild(option);
                });
                break;
        }

        dialog.style.display = 'block';
    } else if (item.type === "hideDialog") {
        dialog.style.display = 'none';
        currentDialogId = null;
    }
});

function closeDialog(response) {
    const inputText = dialogInput.value;
    const listItem = dialogList.selectedIndex;

    fetch(`https://${GetParentResourceName()}/SAM-dialog:Client:dialogResponse`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            dialogid: currentDialogId,
            response: response,
            listitem: listItem,
            inputtext: inputText
        })
    });

    dialog.style.display = 'none';
    dialogInput.value = '';
    dialogList.innerHTML = '';
}

button1.addEventListener('click', () => closeDialog(true));
button2.addEventListener('click', () => closeDialog(false));