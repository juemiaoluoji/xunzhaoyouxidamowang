extends Node

class_name ModelInfo

# 输入你的API_KEY 和 SECRET_KEY
# const API_KEY = ""
# const SECRET_KEY = ""
# 模型服务URL 可根据所选服务替换
const MODEL_URL_BASE = "https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/completions?access_token="
# 鉴权服务URL
const TOKEN_URL_BASE = "https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials"
