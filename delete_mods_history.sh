# scripts/delete_mods_history.sh

mods -l | awk '{print $1}' | xargs -I {} mods -d {}
