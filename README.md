# README

## Kamal Cringe Fix
```bash
bundle lock --add-platform aarch64-linux
```


Upload zip file to active storage model

Steps to configure Minecraft Server:
1. Get new zip file from the server
2. Unzip the file
3. Move contents to the forge_server/mods directory
4. Restart or run the server


<!-- Things to thing about -->
- [ ] Consider if I upload a video file or something
- [ ] What if I upload a file that is a zip but not a mod folder
- [ ] What if the user doesn't know how to make an ssh key?


# Thoughts
Create a startup script that prompts for IP, name for the service and the game, etc... And then it modifies the files accordingly.

# TODO
1. Script needs to be a service
2. Need to deploy the script to the server in the pre-connect hook
3. Then, when the zip file is extracted by the rails app, create the flag file
4. Then, the service will delete the flag file and restart the game/minecraft server