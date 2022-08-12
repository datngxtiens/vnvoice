class UserInfoResponse {
  final String message;
  final String userId;
  final String role;

  const UserInfoResponse(
      {required this.message, required this.userId, required this.role});

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoResponse(
        message: json['message'], userId: json['user_id'], role: json['role']
    );
  }

  @override
  String toString() {
    return "User ID: " + this.userId + ", role: " + this.role;
  }
}
