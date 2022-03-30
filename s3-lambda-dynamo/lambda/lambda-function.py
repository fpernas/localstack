import boto3

dynamo_client = boto3.client('dynamodb', region_name='us-east-1')
dynamo_table = dynamo_client.Table('EXAMPLE_TABLE')

def lambda_function(event, context):
    print(event)
    return True