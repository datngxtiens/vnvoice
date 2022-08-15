class UserInfoResponse {
  final String message;
  final String userId;
  final String role;

  const UserInfoResponse(
      {required this.message, required this.userId, required this.role});

  factory UserInfoResponse.fromJson(Map<String, dynamic> user) {
    return UserInfoResponse(
        message: user['message'], userId: user['user_id'], role: user['role']
    );
  }

  @override
  String toString() {
    return "User ID: $userId, role: $role";
  }
}


