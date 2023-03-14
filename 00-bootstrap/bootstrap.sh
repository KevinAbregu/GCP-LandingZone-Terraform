## Stage 00 - Bootstrap
# Create project for cicd

gcloud projects create [PROJECT_ID] --organization=[ORGANIZATION_ID]
gcloud config set project [PROJECT_ID]

# Activate basic APIs
gcloud services enable serviceusage.googleapis.com
gcloud services enable logging.googleapis.com
gcloud services enable bigquery.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable cloudbilling.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable admin.googleapis.com
gcloud services enable appengine.googleapis.com
gcloud services enable storage-api.googleapis.com
gcloud services enable monitoring.googleapis.com

# Create Service Account for this step.
# This Service account will be used on next steps to create LZ
gcloud iam service-accounts create [SA_NAME]

# Give essential permissions to deploy a LZ
gcloud organizations add-iam-policy-binding [ORGANIZATION_ID] --member=serviceAccount:[EMAIL_SA] --role=roles/billing.user
gcloud organizations add-iam-policy-binding [ORGANIZATION_ID] --member=serviceAccount:[EMAIL_SA] --role=roles/resourcemanager.folderAdmin
gcloud organizations add-iam-policy-binding [ORGANIZATION_ID] --member=serviceAccount:[EMAIL_SA] --role=roles/logging.admin
gcloud organizations add-iam-policy-binding [ORGANIZATION_ID] --member=serviceAccount:[EMAIL_SA] --role=roles/orgpolicy.policyAdmin
gcloud organizations add-iam-policy-binding [ORGANIZATION_ID] --member=serviceAccount:[EMAIL_SA] --role=roles/resourcemanager.projectCreator

# Give permissions on the project created
gcloud projects add-iam-policy-binding [PROJECT_ID] --member=serviceAccount:[EMAIL_SA] --role=roles/owner

# Permissions of impersonation on the Service Account to the user who executes this
gcloud iam service-accounts add-iam-policy-binding [EMAIL_SA] --member=user:[USER_EMAIL] --role=roles/iam.serviceAccountTokenCreator

# 2 cases:
#   a) User who executes this is billing administrator (Ignore this step)
#   b) User who executes this isn't a billing administrator, it must have permissions on this project to attach a billing account.
gcloud projects add-iam-policy-binding [PROJECT_ID] --member=user:[GROUP_BILLING_ACCOUNT] --role=roles/browser
gcloud projects add-iam-policy-binding [PROJECT_ID] --member=user:[GROUP_BILLING_ACCOUNT] --role=roles/orgpolicy.policyViewer
gcloud projects add-iam-policy-binding [PROJECT_ID] --member=user:[GROUP_BILLING_ACCOUNT] --role=roles/resourcemanager.projectIamAdmin
gcloud projects add-iam-policy-binding [PROJECT_ID] --member=user:[GROUP_BILLING_ACCOUNT] --role=roles/billing.projectManager

# User which is billing administrator must execute this to link project with the billing account
gcloud alpha billing accounts projects link [PROJECT_ID] --billing-account=[BILLING_ACCOUNT_ID]

# Create bucket for terraform (to save state)
gcloud config set project [PROJECT_ID]
gcloud storage buckets create gs://[URL_BKT]
gcloud storage buckets update gs://[URL_BKT] --versioning 

gsutil iam ch serviceaccount:[EMAIL_SA]:admin gs://[URL_BKT]
gsutil iam ch serviceaccount:[EMAIL_SA]:objectAdmin gs://[URL_BKT]





