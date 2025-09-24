#!/bin/bash

# Show some common regions to choose from
PS3="Select a region (or Ctrl+C to cancel): "
select region in $(timedatectl list-timezones | cut -d/ -f1 | sort -u); do
    break
done

# Then select from that region
PS3="Now select a city in $region: "
select city in $(timedatectl list-timezones | grep "^$region/"); do
    timezone="$city"
    break
done

# Apply the timezone
if [ -n "$timezone" ]; then
    echo "Setting timezone to $timezone..."
    sudo timedatectl set-timezone "$timezone"
else
    echo "No valid timezone selected."
fi
