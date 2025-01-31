import requests

# Define the URL of the API endpoint
url = "http://10.0.0.132:8000/inf_predict"

# Create a sample payload
payload = {
    "model_id": "OmDet-Turbo_tiny_SWIN_T",
    "data": ["https://qianwen-res.oss-cn-beijing.aliyuncs.com/Qwen-VL/assets/demo.jpeg"],
    "src_type": "url",
    "task": "detection_task",
    "labels": ["dog", "person"],
    "threshold": 0.1,
    "nms_threshold": 0.5
}

# Send a POST request to the API
response = requests.post(url, json=payload)

# Print the response from the server
print("Status Code:", response.status_code)
print("Response JSON:", response.json()) 