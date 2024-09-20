shellFiles="$HOME/Github-Repositories/Test-shells"
first_input=""

read -p "choose-shell running, choose what shell to use: " first_input
if [ $first_input == "lista" ]
then
    echo "All available files"
    for fileName in "$shellFiles"/*
    do
        fileName=$(basename "$fileName")
        printf "%s\t" "$fileName"
    done
    echo
    echo "File: "
    read file
    shell_path="$shellFiles/$file"
    echo "using $shell_path for nix-shell"
    nix-shell $shell_path
else
    shell_path="$shellFiles/$first_input"
    echo "using $first_input for nix-shell"
    nix-shell $shell_path
fi
