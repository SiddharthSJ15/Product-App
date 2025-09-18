class VerifyResponseModel {
  final String? otp;
  final String? accessToken;
  final bool user;

  VerifyResponseModel({
    required this.otp,
    required this.accessToken,
    required this.user,
  });

  factory VerifyResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return VerifyResponseModel(otp: null, accessToken: null, user: false);
    }

    final token = json['token'] as Map<String, dynamic>?;
    return VerifyResponseModel(
      otp: json['otp']?.toString(),
      accessToken: token != null ? token['access']?.toString() : null,
      user: json['user'] == true,
    );
  }
}

class LoginResponseModel {
  final String? accessToken;
  final String? userId;
  final String? message;

  LoginResponseModel({
    required this.accessToken,
    required this.userId,
    required this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return LoginResponseModel(accessToken: null, userId: null, message: null);
    }
    final token = json['token'] as Map<String, dynamic>?;
    return LoginResponseModel(
      accessToken: token != null ? token['access']?.toString() : null,
      userId: json['user_id']?.toString(),
      message: json['message']?.toString(),
    );
  }
}
