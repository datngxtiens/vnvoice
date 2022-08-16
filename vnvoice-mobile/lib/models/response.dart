class UserInfoResponse {
  final String message;
  final String userId;
  final String username;
  final String? imgUrl;
  final String role;

  const UserInfoResponse({
    required this.message,
    required this.userId,
    required this.username,
    required this.role,
    this.imgUrl = 'https://vnvoice-data.s3.amazonaws.com/image/avatar/anonymous.png',
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> user) {
    String url = 'https://vnvoice-data.s3.amazonaws.com/image/avatar/anonymous.png';
    
    if (user.containsKey('img_url')) {
      url = user["img_url"];
    }
    
    return UserInfoResponse(
        message: user['message'],
        userId: user['user_id'],
        username: user['username'],
        role: user['role'],
        imgUrl: url
    );
  }

  @override
  String toString() {
    return "User ID: $userId, role: $role";
  }
}


