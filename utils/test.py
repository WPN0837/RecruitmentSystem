import json
import base64
import time

token = base64.b64encode(json.dumps({'email': '123456', 'time': time.time()}).encode('utf-8'))
print(token, type(token))
print(token.decode('utf-8'))
