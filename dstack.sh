# Example command to deploy "liquid" stack, this being the "coap-proxy" application as the "dev" environment

# ./dstack.sh canvas coap-proxy dev liquid-dev
# ./dstack.sh canvas coap-proxy test liquid-dev
# ./dstack.sh canvas coap-proxy prod liquid-prod

STACK=$1
APPLICATION=$2
ENV=$3
PROFILE=$4
APPLICATIONNAME="$STACK-$APPLICATION"

MQTTENVIRONMENT=$ENV

# grab the current account id
ACCOUNT=$(aws sts get-caller-identity --profile "$PROFILE" | python -c "import sys, json; print json.load(sys.stdin)['Account']")
echo "Fetched ACCOUNT: $ACCOUNT"

# Define S3 Buckets
ACCOUNTPREFIX=$(echo "$ACCOUNT" | cut -c1-4)
S3ARTIFACTS="$ACCOUNTPREFIX-artifacts-$ENV"

# upload the artifacts to the s3 bucket
aws s3 sync ./cfnResources "s3://$S3ARTIFACTS/cloudformation" --profile $PROFILE

if [ "$ENV" = "prod" ]; then
  SSLDOMAIN="lairdconnect.com"
  HOSTEDZONEID=""
  ACMARN=""
  CODECONNECTION=""
else
  SSLDOMAIN="salticidae.net"
  HOSTEDZONEID="Z093266734PJPQPZYXJS0"
  ACMARN="arn:aws:acm:us-east-1:278482835815:certificate/7d9d1623-c37c-4962-9a7f-7977e43660c9"
  CODECONNECTION="arn:aws:codestar-connections:us-east-1:278482835815:connection/58381eb0-3cee-4ae2-a0ff-f692be51e12e"
fi

aws cloudformation deploy \
  --profile "$PROFILE" \
  --template-file "cfnResources/cfnStackTemplate.yaml" \
  --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
  --stack-name "$APPLICATIONNAME-$ENV" \
  --parameter-overrides \
    "AccountPrefix=$ACCOUNTPREFIX" \
    "ApplicationName=$APPLICATIONNAME" \
    "ArtifactBucketName=$S3ARTIFACTS" \
    "ConnectionArn=$CODECONNECTION" \
    "Environment=$ENV" \
    "HostedZoneId=$HOSTEDZONEID" \
    "OutpostBucketName=$ACCOUNTPREFIX-$STACK-file-service-$ENV" \
    "SslDomainName=$SSLDOMAIN" \
    "AcmCertificateArn=$ACMARN" \
    "Stack=$STACK"
