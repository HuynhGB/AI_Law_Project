# LLM in Law consultancy service
## Giới thiệu
  - Chương trình được phát triển nhằm hỗ trợ người dân trong việc tiếp cận thông tin pháp luật, đặc biệt là những đối tượng có hoàn cảnh khó khăn và không đủ điều kiện tài chính để chi trả cho các buổi tư vấn pháp lý truyền thống.
  - Ứng dụng sử dụng mô hình ngôn ngữ TinyLlama để xử lý và tạo phản hồi cho các câu hỏi pháp lý. Tùy thuộc vào cấu hình máy chủ, mô hình có thể được thay đổi để phù hợp với năng lực xử lý hiện tại.
  - Đây là phiên bản prototype của hệ thống và vẫn đang trong quá trình hoàn thiện để nâng cao hiệu quả và trải nghiệm người dùng.

## Quy trình
  - Người dân hoặc khách hàng sẽ nhập câu hỏi pháp lý vào ô nhập liệu trên giao diện ứng dụng và gửi yêu cầu đến hệ thống.
  - Sau đó một luật sư (admin) sẽ tiếp nhận, rà soát và điều chỉnh nội dung câu hỏi nhằm đảm bảo tính rõ ràng, đầy đủ và phù hợp với ngữ cảnh trước khi chuyển đến mô hình LLM để xử lý.
  - Sau khi mô hình LLM tạo ra phản hồi, admin sẽ đánh giá, chỉnh sửa và hoàn thiện câu trả lời để đảm bảo độ chính xác và dễ hiểu trước khi gửi lại cho người dùng cuối.
