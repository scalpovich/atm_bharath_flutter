class ApiResponse {
  ApiResponse({
    required this.status,
    required this.message,
  });

  int? status;
  String? message;

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      ApiResponse(status: json['status'], message: json['message']);
}
