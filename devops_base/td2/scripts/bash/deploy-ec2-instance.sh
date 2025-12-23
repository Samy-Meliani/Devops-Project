#!/usr/bin/env bash
set -e
export AWS_DEFAULT_REGION="us-east-2"

# 1. Récupérer ID du groupe de sécurité si déjà existant
security_group_id=$(aws ec2 describe-security-groups \
  --group-names "sample-app" \
  --query 'SecurityGroups[0].GroupId' \
  --output text 2>/dev/null | tr -d '\r')

# 2. Créer le groupe si non existant
if [ -z "$security_group_id" ] || [ "$security_group_id" == "None" ]; then
  echo "Création du groupe de sécurité..."
  security_group_id=$(aws ec2 create-security-group \
    --group-name "sample-app" \
    --description "Allow HTTP traffic" \
    --query GroupId \
    --output text | tr -d '\r')
fi

# 3. Autoriser le trafic
aws ec2 authorize-security-group-ingress \
  --group-id "$security_group_id" \
  --protocol tcp --port 80 --cidr 0.0.0.0/0 2>/dev/null || true

# 4. Lancer l'instance
instance_id=$(aws ec2 run-instances \
  --image-id "ami-0900fe555666598a2" \
  --instance-type "t3.micro" \
  --security-group-ids "$security_group_id" \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=sample-app}]' \
  --query 'Instances[0].InstanceId' \
  --output text | tr -d '\r')

echo "Instance ID: $instance_id"

# 5. Attendre que instance soit prête et afficher IP
aws ec2 wait instance-running --instance-ids "$instance_id"
public_ip=$(aws ec2 describe-instances \
  --instance-ids "$instance_id" \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text | tr -d '\r')

echo "Succès ! Public IP: $public_ip"
