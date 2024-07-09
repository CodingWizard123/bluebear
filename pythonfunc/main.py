# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`

from firebase_functions import https_fn
from firebase_admin import initialize_app
from firebase_functions.firestore_fn import (
  on_document_created,
  on_document_deleted,
  on_document_updated,
  on_document_written,
  Event,
  Change,
  DocumentSnapshot,
)
from github import Github

# Authentication is defined via github.Auth
from github import Auth

from pymilvus import MilvusClient
import openai
openai.api_key = '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'
client = MilvusClient(
    uri="https://in03-ba79dd0c4842332.api.gcp-us-west1.zillizcloud.com", # Cluster endpoint obtained from the console
    # - For a serverless cluster, use an API key as the token.
    # - For a dedicated cluster, use the cluster credentials as the token
    # in the format of 'user:password'.
        token="358d07ecc2ac636f8a1956ef7a4d30570936a8c26996986de335d73aff8afc70d3efb71ffb4380ec7732934a50350a38ab92534c"
)

initialize_app()

@https_fn.on_call()
def vectorizegoogle(req: https_fn.CallableRequest) -> None:
    

# @on_document_updated(document="users/{userId}")
# def githubVectorize(event: Event[DocumentSnapshot]) -> None:
#     # using an access token
#     auth = Auth.Token("access_token")