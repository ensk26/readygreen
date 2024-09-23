import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:readygreen/main.dart'; // 메인 페이지를 임포트
import 'package:readygreen/screens/login/signup.dart'; // 회원가입 페이지를 임포트

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      // API 요청을 보내기 위한 URL
      final String apiUrl =
          "http://j11b108.p.ssafy.io/api/v1/api/v1/auth/login";

      // 요청 바디
      Map<String, String> requestBody = {
        'email': email,
        'socialId': password,
      };

      try {
        // POST 요청 보내기
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode(requestBody),
        );

        // 서버 응답 확인
        if (response.statusCode == 200) {
          // 로그인 성공 시 MainPage로 이동
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('로그인 성공! 메인 페이지로 이동합니다.')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        } else {
          // 로그인 실패 시
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('로그인에 실패했습니다. 이메일과 비밀번호를 확인하세요.')),
          );
        }
      } catch (e) {
        // 예외 처리
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류가 발생했습니다. 다시 시도해주세요.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('모든 필드를 입력해주세요.')),
      );
    }
  }

  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: '이메일'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login, // 로그인 버튼 클릭 시 API 호출
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: _navigateToSignUp, // 회원가입 페이지로 이동
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
