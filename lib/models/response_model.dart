class VerifyResponseModel {
  final String otp;
  final String accessToken;
  final bool user;

  VerifyResponseModel({
    required this.otp,
    required this.accessToken,
    required this.user,
  });

  factory VerifyResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyResponseModel(
      otp: json['otp'],
      accessToken: json['token']['access'],
      user: json['user'],
    );
  }
}

class LoginResponseModel {
  final String accessToken;
  final String userId;
  final String message;

  LoginResponseModel({
    required this.accessToken,
    required this.userId,
    required this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['token']['access'],
      userId: json['user_id'],
      message: json['message'],
    );
  }
}
