import os
from langchain.llms import Ollama
from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

ollama_url = os.getenv("OLLAMA_BASE_URL", "http://localhost:11434")
llm = Ollama(base_url=ollama_url, model="tinyllama")



@app.route('/api/process', methods=['POST'])
def process_message():
    global answer
    data = request.get_json()
    if data and 'message' in data:
        received_message = data['message']
        result = llm(received_message)
        res1 = result.split('\n')
        answer = res1
        return jsonify({"received_message": res1})
    else:
        return jsonify({"error": "Invalid Data"}), 400
    
if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)
