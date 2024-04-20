#!/bin/bash

# Define Variables
namespace="sre"
deployment_name="swype-app"
max_restarts=3

# Start an Infinite Loop
while true; do
    # Check Pod Restarts
    restarts=$(kubectl get pods -n $namespace | grep $deployment_name | awk '{print $4}')

    # Display Restart Count
    echo "Current number of restarts: $restarts"

    # Check Restart Limit
    if [[ $restarts -gt $max_restarts ]]; then
        # Scale Down if Necessary
        echo "Number of restarts exceeded maximum limit. Scaling down the deployment..."
        kubectl scale deployment $deployment_name --replicas=0 -n $namespace
        break
    else
        # Pause
        echo "Pausing for 60 seconds..."
        sleep 60
    fi
done
