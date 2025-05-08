const modified_question_1 = document.getElementById("modified_question_1");
const question_1 = document.getElementById("question_1");
const AI_Answer = document.getElementById("result");
const modified_AI_Answer = document.getElementById("modified_result");

function adjust_the_question() {
    modified_question_1.value = question_1.textContent;
}

function adjust_the_answer() {
    modified_AI_Answer.value = AI_Answer.textContent;
}

document.addEventListener('DOMContentLoaded', function () {
    const send_to_AI = document.getElementById('button1');

    send_to_AI.addEventListener('click', function () {
        const message = modified_question_1.value;

        fetch('/api/process', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ message: message })
        })
            .then(response => response.json())
            .then(data => {
                console.log('Phản hồi từ backend (process):', data);
                AI_Answer.innerHTML = '';
                data.received_message.forEach(item => {
                    const li = document.createElement('li');
                    li.textContent = item;
                    AI_Answer.appendChild(li);
                });
            })
            .catch(error => {
                console.error('Lỗi khi gửi dữ liệu (process):', error);
                AI_Answer.innerHTML = '';
                const errorItem = document.createElement('li');
                errorItem.textContent = 'Không thể gửi dữ liệu hoặc nhận phản hồi.';
                AI_Answer.appendChild(errorItem);
            });
    });
});
