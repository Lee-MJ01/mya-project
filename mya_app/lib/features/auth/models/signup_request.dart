class SignupRequest {
  final String email;
  final String password;
  final String nickname;
  final String phoneNumber;
  final String address;
  final double latitude;
  final double longitude;
  final int avgPrepTime;
  final bool termsAgreed;

  SignupRequest({
    required this.email,
    required this.password,
    required this.nickname,
    required this.phoneNumber,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.avgPrepTime,
    required this.termsAgreed,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "nickname": nickname,
    "phoneNumber": phoneNumber,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "avgPrepTime": avgPrepTime,
    "termsAgreed": termsAgreed,
  };
}