echo "Welcome to Choose-shell!"

choose_file () {
    number_of_paths=$(wc -l < data.txt)
    number_of_paths_integer=$(( number_of_paths ))
    if [ "$number_of_paths_integer" -gt 1 ]; then
        declare -A filename_and_index
        declare -a paths
        for ((i=0; i < number_of_paths; i++ )); do
            current_path_sed=$(sed -n "${i}p" data.txt)
            current_path="${current_path_sed/\$HOME/$HOME}/*"
            paths+=("${current_path}")
            for filepath in ${current_path[@]}; do
                filename=$(basename "$filepath")
                filename_and_index["$filename"]="$i"
                shellFileNames+=("$filename")
            done
        done

        for fileName in ${shellFileNames[@]}; do
            printf "%s\t" "$fileName"
        done
        
        echo -e "\n \n"

        read -p "choose what shell to use: " user_filename

        shell_path=""
        echo "using $shell_path for nix-shell"
        nix-shell $shell_path
    else
        current_path_sed=$(sed -n "1p" data.txt)
        current_path="${current_path_sed/\$HOME/$HOME}/*"
        for filepath in ${current_path[@]}; do
            filename=$(basename "$filepath")
            shellFileNames+=("$filename")
        done

        for fileName in ${shellFileNames[@]}; do
            printf "%s\t" "$fileName"
        done

        echo -e "\n \n"

        read -p "choose what shell to use: " user_filename

        shell_path="${current_path%\*}/$user_filename"
        echo "using $shell_path for nix-shell"
        nix-shell $shell_path
    fi
}

setup_path () {
    echo -e "Entered setup of Choose-shell \n \n"
    echo "How many directories do you have for your nix-shell files?"
    read -p "Number: " number_of_directories_string
    number_of_directories_integer=$(( number_of_directories_string ))
    if [ "$number_of_directories_integer" -gt 1 ]; then
        for ((directory=1; directory <= number_of_directories_integer; directory++ )); do
            echo "adding path nr.$directory of $number_of_directories_integer"
            read -p "Paste the path to your nix-shells here: " nix_path
            echo '$HOME'"/$nix_path" >> data.txt
        done
    else 
        read -p "Paste the path to your nix-shells here: " nix_path
        echo '$HOME'"/$nix_path" >> data.txt
    fi

    sed -e s/first-time//g -i data.txt
    read -p "All paths added, do you wish to use one now? (y/n): " chosen_file

    if [ "$chosen_file" == "y" ]; then
        choose_file
    else
        echo "Exiting Choose-shell"
    fi
}

if grep -q "first-time" 'data.txt'; then
    setup_path
else
    choose_file
fi
