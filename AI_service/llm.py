import os
from langchain.llms import Ollama
from flask import Flask, request, jsonify
from flask_cors import CORS
import time  # Nhập thư viện time

app = Flask(__name__)
CORS(app)

ollama_url = os.getenv("OLLAMA_BASE_URL", "http://localhost:11434")
llm = Ollama(base_url=ollama_url, model="tinyllama")

# Thêm độ trễ khi khởi động (tính bằng giây)
STARTUP_DELAY = 20
print(f"Đang chờ {STARTUP_DELAY} giây trước khi sẵn sàng...")
time.sleep(STARTUP_DELAY)
print("Ứng dụng đã sẵn sàng.")

@app.route('/api/process', methods=['POST'])
def process_message():
    data = request.get_json()
    if data and 'message' in data:
        received_message = data['message']
        try:
            result = llm(received_message)
            response_lines = result.split('\n')
            return jsonify({"received_message": response_lines})
        except Exception as e:
            print(f"Đã xảy ra lỗi khi liên lạc với Ollama: {e}")
            return jsonify({"error": f"Không thể xử lý tin nhắn: {e}"}), 500
    else:
        return jsonify({"error": "Dữ liệu không hợp lệ"}), 400

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)
