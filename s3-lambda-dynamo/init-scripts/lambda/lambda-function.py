import json
import boto3

'''
    Is necessary that the client also points to the localstack endpoint.
    For that, create an environment variable and use it here instead of
    the actual value. For references:

    https://stackoverflow.com/questions/57420137/unrecognizedclientexception-when-invoking-a-lambda-from-another-lambda-using-loc
'''

session = boto3.session.Session()

dynamo_client = session.resource(
    service_name = 'dynamodb',
    endpoint_url = 'http://localhost:4566'
)

#dynamo_client = boto3.resource('dynamodb')
dynamo_table = dynamo_client.Table('s3-document-names')

def lambda_handler(event, context):
    # TODO implement
    #print(event)
    #print('File names: ')
    #for record in event.get('Records', []):
    #    print(record.get('s3').get('object').get('key'))
    
    response = dynamo_table.put_item(
        Item = {
            'DocumentName': event.get('Records')[0].get('s3').get('object').get('key')
        })
        
    return response