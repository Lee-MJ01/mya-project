import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  // 안드로이드 에뮬레이터에서 로컬 호스트 접속용 주소
  static const String _baseUrl = "http://10.0.2.2:8080/api/v1/users";

  Future<void> signup(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return; // 가입 성공
      } else {
        // 서버에서 보낸 에러 메시지 추출 (중복 이메일 등)
        final errorBody = jsonDecode(response.body);
        throw errorBody['message'] ?? "회원가입 중 오류가 발생했습니다.";
      }
    } catch (e) {
      rethrow;
    }
  }
}