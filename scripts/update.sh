wget --content-disposition https://deanout.com/api/v1/download_latest_mod
# Mods.zip might change, so that needs to be accounted for.
# Mods directory is kinda hacky.
rm -rf mods
mkdir mods
unzip mods.zip -d mods
rm mods.zip
# This one is a wild card, who knows what happens
screen -S Forge java @user_jvm_args.txt @libraries/net/minecraftforge/forge/1.20.1-47.2.0/unix_args.txt "$@"