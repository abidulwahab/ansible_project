import boto3
import json

def get_instances():
    ec2 = boto3.client('ec2', region_name='eu-east-2')
    instances = ec2.describe_instances(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])
    inventory = {"all": {"hosts": []}}

    for reservation in instances['Reservations']:
        for instance in reservation['Instances']:
            public_ip = instance.get('PublicIpAddress')
            if public_ip:
                inventory['all']['hosts'].append(public_ip)

    return inventory

if __name__ == "__main__":
    inventory = get_instances()
    print(json.dumps(inventory, indent=2))

