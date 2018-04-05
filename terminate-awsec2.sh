#!/bin/bash

# Check Expiration and terminate if needed
check_exp(){

        EXP=$1
        DATE=`date +"%D"`
        EXP=$(date -d $EXP +"%Y%m%d")
        TODAY=$(date +"%Y%m%d")
        # echo $EXP
        # echo $TODAY
        if [ $EXP -lt $TODAY ]; then
                aws ec2 terminate-instances --instance-ids $INSTANCE_ID
        fi



}
# Processing the tags to find the expiration
process_tags(){

        echo $TAGS | jq -c '.[]' | while read TAG; do

                FLAG="false"
                if [ "$(echo $TAG | jq -r '.Key')" = "Expiration" ]; then
                        EXP=`echo $TAG | jq -r '.Value'`
                        FLAG="true"
                fi

                if [ "$FLAG" = "true" ]; then
                        check_exp $EXP

                fi
        done

}

# List all the instances in the region
RESERVATIONS=`aws ec2 describe-instances | jq -c '.'`

echo $RESERVATIONS | jq -c '.Reservations[]' | while read INSTANCES; do

        #Iterate over instances
        echo $INSTANCES | jq -c '.Instances[]' | while read INSTANCE; do

                INSTANCE_ID=`echo $INSTANCE | jq -r '.InstanceId'`
                TAGS=`echo $INSTANCE | jq -c '.Tags'`
                process_tags
        done

done



