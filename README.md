# [ESX] esx_logging
 Advanced ESX logging for commands, messages, items, etc

## Images
- How it see in DB
![db example](https://i.imgur.com/6qGiyCQ.png)
- How errors are shown
![1_example](https://i.imgur.com/h2t5zib.png)
![2_example](https://i.imgur.com/LyuC4IC.png)

## Requirements
- `es_extended` from [here](https://github.com/ESX-Org/es_extended)
- `mysql-async` from [here](https://github.com/brouznouf/fivem-mysql-async)

## Installation
- Download the latest version
- Put the folder in your **[resources]** folder
- Add `start esx_logging` under `start mysql-async` and `start es_extended`
- Insert the .sql file into your MySQL server
- Run your server
### Add this to [chat/cl_chat.lua]
- After line 111 `TriggerEvent('logging:executeCommand', {id=PlayerId(), msg=data.message})`
- After line 114 `TriggerEvent('logging:newMessage', {id=PlayerId(), msg=data.message})`
