#!/bin/sh

workspaces=$(i3-msg -t get_workspaces)
output=$(echo $workspaces | jq -r '.[] | select(.focused==true).output')
workspace_array=($(echo $workspaces | jq --arg output "$output" '.[] | select(.output == $output).num'))

index=$(( $2 - 1 ))
if [ "$index" -eq -1 ]; then
    index=$(( 10 ))
fi

if [ "$index" -ge 0 ] && [ "$index" -lt "${#workspace_array[@]}" ]; then
    selected_workspace=${workspace_array[$index]}
    exec i3-msg $1 $selected_workspace
else if [ "$index" -ge 0 ]; then
    allWorkspace_array=($(echo $workspaces | jq '.[] | .num' | sort))
    last_value=${allWorkspace_array[$(( ${#allWorkspace_array[@]} - 1 ))]}
    newVal=$(($last_value + 1))

    if [ "$newVal" -ge 20 ]; then
        for ((i=1; i<=100; i++)); do
            if ! [[ " ${allWorkspace_array[@]} " =~ " $i " ]]; then
                newVal=$i
                break
            fi
        done
    fi
    exec i3-msg $1 $newVal
fi
fi
