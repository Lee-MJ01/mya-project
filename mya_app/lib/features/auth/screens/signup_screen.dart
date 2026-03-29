import 'package:flutter/material.dart';
import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:geocoding/geocoding.dart'; // Geocoding 추가
import 'package:mya_project/core/constants.dart';
import 'package:mya_project/services/user_service.dart';
import 'package:mya_project/features/auth/models/signup_request.dart';
import 'package:permission_handler/permission_handler.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // v1.4 명세에 맞춘 컨트롤러 및 변수
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  double _latitude = 0.0;
  double _longitude = 0.0;
  double _avgPrepTime = 30.0;
  bool _termsAgreed = false; // 필수 약관 동의

  @override
  void dispose() {
    for (var controller in [_emailController, _passwordController, _nicknameController, _phoneController, _addressController]) {
      controller.dispose();
    }
    super.dispose();
  }

  // 핵심 미션: 주소 검색 및 위경도 추출 로직
  Future<void> _searchAddress() async {
    final DataModel? data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DaumPostcodeSearch()),
    );

    if (data != null) {
      setState(() {
        _addressController.text = data.address;
      });

      // Geocoding: 주소를 좌표로 변환
      try {
        List<Location> locations = await locationFromAddress(data.address);
        if (locations.isNotEmpty) {
          setState(() {
            _latitude = locations.first.latitude;
            _longitude = locations.first.longitude;
          });
          debugPrint("추출된 좌표: $_latitude, $_longitude");
        }
      } catch (e) {
        _showErrorSnackBar("좌표 추출에 실패했습니다. 직접 위치를 지정하거나 다시 시도해주세요.");
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입 (v1.4)'), centerTitle: true),
      body: Form(
        key: _formKey,
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 2) {
              setState(() => _currentStep++);
            } else {
              _submitSignup();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) setState(() => _currentStep--);
          },
          steps: _buildSteps(),
        ),
      ),
    );
  }

  List<Step> _buildSteps() {
    return [
      Step(
        title: const Text('계정 정보'),
        isActive: _currentStep >= 0,
        content: Column(
          children: [
            TextFormField(controller: _emailController, decoration: const InputDecoration(labelText: '이메일 (@ 포함)')),
            TextFormField(controller: _passwordController, decoration: const InputDecoration(labelText: '비밀번호 (8자 이상)'), obscureText: true),
            TextFormField(controller: _nicknameController, decoration: const InputDecoration(labelText: '닉네임')),
            TextFormField(controller: _phoneController, decoration: const InputDecoration(labelText: '전화번호 (010-XXXX-XXXX)')),
          ],
        ),
      ),
      Step(
        title: const Text('개인화 설정'),
        isActive: _currentStep >= 1,
        content: Column(
          children: [
            TextFormField(
              controller: _addressController,
              readOnly: true,
              onTap: _searchAddress,
              decoration: const InputDecoration(labelText: '주요 출발지 주소', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(height: 20),
            Text('평균 준비 시간: ${_avgPrepTime.toInt()}분'),
            Slider(
              value: _avgPrepTime,
              min: 0, max: 120, divisions: 24, // 5분 단위 설정
              onChanged: (v) => setState(() => _avgPrepTime = v),
            ),
          ],
        ),
      ),
      Step(
        title: const Text('약관 및 권한'),
        isActive: _currentStep >= 2,
        content: Column(
          children: [
            CheckboxListTile(
              title: const Text('필수 약관에 동의합니다.'),
              value: _termsAgreed,
              onChanged: (v) => setState(() => _termsAgreed = v ?? false),
            ),
            const Text('위치 및 마이크 권한은 서비스 이용에 필수입니다.'),
          ],
        ),
      ),
    ];
  }

  final UserService _userService = UserService();
  bool _isLoading = false;

  void _submitSignup() async {
    // 1. 필수 약관 동의 확인
    if (!_termsAgreed) {
      _showErrorSnackBar("필수 약관에 동의해주세요.");
      return;
    }

    // 2. 위치/마이크 권한 확인
    bool hasPermission = await _requestPermissions();
    if (!hasPermission) {
      _showErrorSnackBar("기능 이용을 위해 위치 및 마이크 권한이 필요합니다.");
      return;
    }

    // 3. 로딩 시작 및 데이터 전송
    setState(() => _isLoading = true);
    try {
      await _userService.signup({
        "email": _emailController.text,
        "password": _passwordController.text,
        "nickname": _nicknameController.text,
        "phoneNumber": _phoneController.text,
        "address": _addressController.text,
        "latitude": _latitude,
        "longitude": _longitude,
        "avgPrepTime": _avgPrepTime.toInt(),
        "termsAgreed": _termsAgreed,
      });

      // 성공 시 대시보드로 이동
      if (mounted) Navigator.pushReplacementNamed(context, '/main');
    } catch (e) {
      _showErrorDialog(e.toString()); // 서버 에러 팝업 (중복 이메일 등)
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<bool> _requestPermissions() async {
    // 위치 및 마이크 권한 동시 요청
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.microphone,
    ].request();

    if (statuses[Permission.location]!.isGranted &&
        statuses[Permission.microphone]!.isGranted) {
      return true;
    }
    return false;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('가입 실패', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('확인')),
        ],
      ),
    );
  }
}