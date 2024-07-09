import numpy as np
import pandas as pd

!pip install --upgrade google-auth google-auth-oauthlib google-auth-httplib2
!pip3 install simplegmail
!pip install openai cohere tiktoken wordcloud


from google.oauth2 import service_account
from googleapiclient.discovery import build

# Load the credentials from the downloaded JSON key file
credentials = service_account.Credentials.from_service_account_file(
    '989228538380-t19ojgmaphr3a8qs2oi3njlodsl6fcjh.apps.googleusercontent.com', ['https://www.googleapis.com/auth/gmail.readonly'])

# Create a Gmail API service     n
service = build('gmail', 'v1', credentials=credentials)

from simplegmail import Gmail
from simplegmail.query import construct_query


gmail = Gmail()

params = {
    "newer_than" : (2, "years")
    }

messages = gmail.get_messages(query=construct_query(**params))

emails = ""
for m in messages:
  if m.plain == None:
    continue
  else:
    emails += m.plain
