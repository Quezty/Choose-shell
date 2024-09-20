shellFilePath="$HOME/Github-Repositories/Test-shells/*"
shellFileDirectory="$HOME/Github-Repositories/Test-shells/"
shellFileNames=()

echo -e "choose-nix-shell running \n"
echo "All available files"

for filepath in ${shellFilePath[@]}; do
    filename=$(basename "$filepath")
    shellFileNames+=("$filename")
done

for fileName in ${shellFileNames[@]}; do
    printf "%s\t" "$fileName"
done

echo -e "\n \n"

read -p "choose what shell to use: " user_filename

shell_path="$shellFileDirectory/$user_filename"
echo "using $shell_path for nix-shell"
nix-shell $shell_path
