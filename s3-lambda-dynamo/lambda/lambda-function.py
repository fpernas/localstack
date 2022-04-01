import json
import boto3

dynamo_client = boto3.resource('dynamodb')
dynamo_table = dynamo_client.Table('s3LambdaTest')

def lambda_handler(event, context):
    # TODO implement
    #print(event)
    #print('File names: ')
    #for record in event.get('Records', []):
    #    print(record.get('s3').get('object').get('key'))
    
    response = dynamo_table.put_item(
        Item = {
            'document-name': event.get('Records')[0].get('s3').get('object').get('key')
        })
        
    return response