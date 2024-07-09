import openai
openai.api_key = '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'
response = openai.Embedding.create(
input="generate a resume in latex for this candidate in IT",
model="text-embedding-ada-002"
)
print(response['data'][0]['embedding'])