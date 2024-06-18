#!/bin/bash

USER_SERVICE_ROLE_ARN=${USER_SERVICE_ROLE_ARN-'arn:aws:iam::974860574511:role/eks-revolut-user-service-role'}
REDIS_URI=${REDIS_URI-'clustercfg.users.vjad9t.euw1.cache.amazonaws.com'}
RDS_HOST=${RDS_HOST-'users.ctmsm2isu4lq.eu-west-1.rds.amazonaws.com'}
CONTAINER_REGISTRY=${CONTAINER_REGISTRY-'974860574511.dkr.ecr.eu-west-1.amazonaws.com'}
CONTAINER_REPOSITORY=${CONTAINER_REPOSITORY-'revolut-user-service'}
IMAGE_TAG=${IMAGE_TAG-'0.1.0'}

pushd kustomize/apps/components/user-service/prod

# Replace annotation on service account with USER_SERVICE_ROLE_ARN
sed -i '' \
    -e "s|eks.amazonaws.com\/role-arn:.*|eks.amazonaws.com/role-arn: ${USER_SERVICE_ROLE_ARN}|g" \
    sa.yaml

# Replace Elasticache configuration endpoint
sed -i '' \
    -e "s|redis:\/\/.*.cache.amazonaws.com:6379/0|redis:\/\/${REDIS_URI}:6379\/0|g" \
    deployment.yaml

# Replace RDS endpoint
sed -i '' \
    -e "s|: \".*rds.amazonaws.com|: \"${RDS_HOST}|g" \
    deployment.yaml

sed -i '' \
    -e "s|: \".*rds.amazonaws.com|: \"${RDS_HOST}|g" \
    job.yaml

kustomize edit set image revolut-user-service=${CONTAINER_REGISTRY}/${CONTAINER_REPOSITORY}:${IMAGE_TAG}
popd
