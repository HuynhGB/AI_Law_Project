# LLM in Law consultancy service
## Giới thiệu
  - Chương trình được xây dựng nhằm mục đích hỗ trợ người dân về các vấn đề liên quan đến luật pháp. Đây là ứng dụng nhắm đến những người có hoàn cảnh khó khăn và không thể chi trả các khoảng phí cho buổi tư vấn của luật sư.
  - Ỡ đây chúng ta sử dụng mô hình tinyllama, ta có thể thay đổi mô hình dựa tuỳ thuộc vào cấu hình máy của server.
  - Đây chỉ mới là prototype của chương trình và vẫn còn đang tiếp tục hoàn thiện chương trình.

## Quy trình
  - Đầu tiên, người dân hoặc khách hàng sẽ điền câu hỏi của mình vào ô trống, sau đó gửi câu hỏi cho luật sư (admin của ứng dụng này). Kế đến, admin sẽ điểu chỉnh câu hỏi của khách hàng sao cho hợp lý và đúng ngữ cảnh để đưa câu hỏi vào mô hình LLM cho nó trả lời.
  - Tiếp đến, khi mô hình LLM xuất ra kết quả, admin có nhiệm vụ là điều chỉnh lại câu trả lời và sau đó gửi nó đến khách hàng hoặc người dân đang cần sự giúp đỡ.
