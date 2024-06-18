#!/bin/bash

AWS_LBC_ROLE_ARN=${AWS_LBC_ROLE_ARN-'arn:aws:iam::974860574511:role/eks-aws-lbc'}

echo "Updating aws-lbc"

pushd kustomize/platform/components/aws-lbc/base/templates

# Replace annotation on service account with AWS_LBC_ROLE_ARN
sed -i '' \
    -e "s|eks.amazonaws.com\/role-arn:.*|eks.amazonaws.com/role-arn: ${AWS_LBC_ROLE_ARN}|g" \
    serviceaccount.yaml
popd

