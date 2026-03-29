import 'package:flutter/material.dart';
import 'package:daum_postcode_search/daum_postcode_search.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // 1단계: 기본 정보 컨트롤러
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _phoneController = TextEditingController();

  // 2단계: 먀비서 개인화 설정 컨트롤러
  final _addressController = TextEditingController();
  double _prepTime = 30.0;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nicknameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // 주소 검색 로직 (0.0.4 버전 - Navigator 리턴 방식)
  Future<void> _searchAddress() async {
    // 1. 주소 검색 화면을 띄우고 결과를 기다립니다 (await)
    final DataModel? data = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DaumPostcodeSearch(),
      ),
    );

    // 2. 결과값이 존재한다면 (사용자가 주소를 선택했다면) 상태를 업데이트합니다.
    if (data != null && mounted) {
      setState(() {
        _addressController.text = data.address; // 선택된 주소를 텍스트 필드에 입력
      });
    }
  }

  void _submitSignup() {
    if (_formKey.currentState!.validate()) {
      final signupData = {
        "email": _emailController.text,
        "password": _passwordController.text,
        "nickname": _nicknameController.text,
        "phone": _phoneController.text,
        "address": _addressController.text,
        "averagePrepTime": _prepTime.toInt(),
      };

      print("전송 데이터: $signupData");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('회원가입 처리 중...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('먀비서 가입하기'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          onStepContinue: () {
            if (_formKey.currentState!.validate()) {
              if (_currentStep < 2) {
                setState(() => _currentStep += 1);
              } else {
                _submitSignup();
              }
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) setState(() => _currentStep -= 1);
          },
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(_currentStep == 2 ? '가입 완료' : '다음 단계'),
                    ),
                  ),
                  if (_currentStep > 0) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: details.onStepCancel,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('이전'),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
          steps: [
            Step(
              title: const Text('계정 정보'),
              isActive: _currentStep >= 0,
              state: _currentStep > 0 ? StepState.complete : StepState.indexed,
              content: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: '이메일',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                    (value == null || !value.contains('@'))
                        ? '이메일 형식이 올바르지 않습니다'
                        : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: '비밀번호',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    obscureText: true,
                    validator: (value) =>
                    (value == null || value.length < 6)
                        ? '비밀번호는 6자 이상이어야 합니다'
                        : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nicknameController,
                    decoration: const InputDecoration(
                      labelText: '닉네임',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) =>
                    (value == null || value.isEmpty)
                        ? '닉네임을 입력하세요'
                        : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: '전화번호',
                      prefixIcon: Icon(Icons.phone_android_outlined),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                    (value == null || value.isEmpty)
                        ? '전화번호를 입력하세요'
                        : null,
                  ),
                ],
              ),
            ),
            Step(
              title: const Text('비서 개인 설정'),
              isActive: _currentStep >= 1,
              state: _currentStep > 1 ? StepState.complete : StepState.indexed,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '정확한 이동 시간 계산을 위해 정보가 필요해요.',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _addressController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: '주요 출발지 (집 주소)',
                      prefixIcon: const Icon(Icons.home_outlined),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: _searchAddress,
                      ),
                    ),
                    onTap: _searchAddress,
                    validator: (value) =>
                    (value == null || value.isEmpty)
                        ? '주소를 검색해주세요'
                        : null,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('평균 외출 준비 시간',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${_prepTime.toInt()}분',
                          style: const TextStyle(color: Colors.indigo,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Slider(
                    value: _prepTime,
                    min: 0,
                    max: 120,
                    divisions: 24,
                    label: '${_prepTime.toInt()}분',
                    activeColor: Colors.indigo,
                    onChanged: (double value) {
                      setState(() {
                        _prepTime = value;
                      });
                    },
                  ),
                  const Text(
                    '씻고 나갈 준비를 마치는 데 걸리는 평균 시간입니다.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Step(
              title: const Text('권한 설정 및 완료'),
              isActive: _currentStep >= 2,
              content: const Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                        child: Icon(Icons.location_on, size: 20)),
                    title: Text('위치 정보 권한'),
                    subtitle: Text('실시간 대중교통 경로 도출을 위해 필요합니다.'),
                  ),
                  ListTile(
                    leading: CircleAvatar(child: Icon(Icons.mic, size: 20)),
                    title: Text('마이크 권한'),
                    subtitle: Text('음성 기록 및 일정 자동 추출을 위해 필요합니다.'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}