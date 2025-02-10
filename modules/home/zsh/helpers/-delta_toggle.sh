#!/bin/env bash

# List of toggleable features
TOGGLEABLE=("line-numbers" "side-by-side")

toggle_feature() {
    local prefix="$1"
    local matching_features=()

    # Find matching feature(s)
    for feature in "${TOGGLEABLE[@]}"; do
        if [[ "$feature" == "$prefix"* ]]; then
            matching_features+=("$feature")
        fi
    done

    # Handle multiple matches
    if [[ ${#matching_features[@]} -gt 1 ]]; then
        echo "Multiple matching features: ${matching_features[*]}" >&2
        exit 1
    fi

    # Extract the matched feature
    local feature="${matching_features[0]}"
    if [[ -z "$feature" ]]; then
        echo "No matching feature found for prefix: $prefix" >&2
        exit 1
    fi

    # Read DELTA_FEATURES (default to "+")
    local features="${DELTA_FEATURES:-+}"
    [[ $features == "+"* ]] || features="+"

    # Convert space-separated list into an array
    read -ra feature_list <<< "${features:1}"

    # Toggle the feature
    if [[ " ${feature_list[*]} " =~ " $feature " ]]; then
        # Remove feature
        feature_list=("${feature_list[@]/$feature}")
    else
        # Add feature
        feature_list+=("$feature")
    fi

    # Print updated features (formatted correctly)
    echo "+${feature_list[*]}"
}

# If no argument is given, print the current DELTA_FEATURES
if [[ $# -eq 0 ]]; then
    echo "$DELTA_FEATURES"
    exit 0
else
    toggle_feature "$1"
fi
