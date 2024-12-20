import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readygreen/background/background_service.dart';
import 'package:readygreen/constants/baseurl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MapStartAPI {
  final storage = const FlutterSecureStorage();

  // 경로 요청 (POST) start
  Future<Map<String, dynamic>?> fetchRoute({
    required double startX,
    required double startY,
    required double endX,
    required double endY,
    required String startName,
    required String endName,
    required bool watch,
  }) async {
    String? accessToken = await storage.read(key: 'accessToken');

    Map<String, dynamic> requestBody = {
      'startX': startX,
      'startY': startY,
      'endX': endX,
      'endY': endY,
      'startName': startName,
      'endName': endName,
      'watch': watch,
    };
    print('길찾기 요청 데이터: $requestBody');
    print('액세스토큰 $accessToken');
    print('Base URL: $baseUrl');

    final response = await http.post(
      Uri.parse('$baseUrl/map/start'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
      body: json.encode(requestBody),
    );

    print('Response status code: ${response.statusCode}');
    print('Response headers: ${response.headers}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      initializeService();

      return jsonDecode(utf8.decode(response.bodyBytes)); // 응답 데이터 반환
    } else {
      print('Error response body: ${response.body}');
      print('start map 실패 코드: ${response.statusCode}');
      return null;
    }
  }

  // 즐겨찾기 목록 조회 (GET)
  Future<List<dynamic>?> fetchBookmarks() async {
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.get(
      Uri.parse('$baseUrl/map/bookmark'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      print('즐겨찾기 목록 조회 성공');

      // 응답에서 JSON 데이터를 디코드
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data);
      // bookmarkDTOs 배열을 추출하여 반환
      if (data != null && data.containsKey('bookmarkDTOs')) {
        return data['bookmarkDTOs'];
      } else {
        print('bookmarkDTOs를 찾을 수 없습니다.');
        return null;
      }
    } else {
      print('즐겨찾기 목록 조회 실패: ${response.statusCode}');
      return null;
    }
  }

  // 즐겨찾기 추가 (POST)
  Future<bool> addBookmark(
      {required String name,
      required String destinationName,
      required double latitude,
      required double longitude,
      required int hour,
      required int minute,
      required int second,
      required int nano,
      required String placeId}) async {
    String? accessToken = await storage.read(key: 'accessToken');
    // 시간을 'HH:mm:ss' 형식으로 변환
    String formattedTime = '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')}:'
        '${second.toString().padLeft(2, '0')}';
    print("여기latlng");
    print(latitude);
    print(longitude);
    final response = await http.post(
      Uri.parse('$baseUrl/map/bookmark'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'name': name,
        'destinationName': destinationName,
        'latitude': latitude,
        'longitude': longitude,
        'alertTime': formattedTime,
        'placeId': placeId,
        'type': "ETC"
      }),
    );

    if (response.statusCode == 200) {
      print('즐겨찾기 추가 성공: ${response.body}');
      return true;
    } else {
      print('즐겨찾기 추가 실패: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  }

  // 즐겨찾기 삭제 (DELETE)
  Future<bool> deleteBookmark(String placeId) async {
    String? accessToken = await storage.read(key: 'accessToken');

    final response = await http.delete(
      Uri.parse('$baseUrl/map/bookmark?placeId=$placeId'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 204) {
      print('즐겨찾기 삭제 성공');
      return true;
    } else {
      print('즐겨찾기 삭제 실패: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  }

// 신호등 정보 요청 (GET)
  Future<List<dynamic>?> fetchBlinkerInfo({
    required double latitude,
    required double longitude,
    required int radius,
  }) async {
    String? accessToken = await storage.read(key: 'accessToken');
    if (accessToken == null) {
      print('엑세스 토큰 없어용 ㅜㅜ');
      return null;
    }

    final response = await http.get(
      Uri.parse(
          '$baseUrl/map?latitude=$latitude&longitude=$longitude&radius=$radius'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      print('신호등 정보 조회 성공');
      return jsonDecode(response.body)['blinkerDTOs'];
    } else {
      print('신호등 정보 조회 실패: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  }

  // 길안내 정보 요청 (GET) guide
  Future<Map<String, dynamic>?> fetchGuideInfo() async {
    String? accessToken = await storage.read(key: 'accessToken');

    if (accessToken == null) {
      print('엑세스 토큰이 없습니다.');
      return null;
    }

    final response = await http.get(
      Uri.parse('$baseUrl/map/guide'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
    );
    
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      initializeService();

      return jsonDecode(utf8.decode(response.bodyBytes)); // 응답 데이터 반환
    } else {
      print('guide 길안내 정보 조회 실패: ${response.statusCode}');
      return null;
    }
  }

  Future<bool> checkIsGuide() async {
    String? accessToken = await storage.read(key: 'accessToken');

    if (accessToken == null) {
      print('엑세스 토큰이 없습니다.');
      return false;
    }

    final response = await http.post(
      Uri.parse('$baseUrl/map/guide/check'), // POST 요청으로 변경
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
      body: '', // 빈 body 추가
    );

    if (response.statusCode == 200) {
      print('check guide 200');
      // 상태 코드가 200이면 true 반환
      return true;
    } else if (response.statusCode == 204) {
      print('check guide 204');
      // 상태 코드가 204이면 false 반환
      return false;
    } else {
      // 기타 상태 코드일 경우 false 반환
      print('check guide 에러 코드: ${response.statusCode}');
      return false;
    }
  }

  // 길안내 중지 (DELETE)
  Future<bool> guideDelete({required bool isWatch}) async {
    String? accessToken = await storage.read(key: 'accessToken');

    if (accessToken == null) {
      print('엑세스 토큰이 없습니다.');
      return false;
    }

    final response = await http.delete(
      Uri.parse('$baseUrl/map/guide?isWatch=$isWatch'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      await storage.write(key: 'isModified', value: 'true');

      return true;
    } else {
      // 기타 상태 코드일 경우 false 반환
      print('에러 코드: ${response.statusCode}');
      return false;
    }
  }

  // 신호등 상태 정보 요청 (GET)
  Future<List<dynamic>?> fetchBlinkerInfoByIds({
    required List<int> blinkerIds,
  }) async {
    String? accessToken = await storage.read(key: 'accessToken');

    if (accessToken == null) {
      print('엑세스 토큰이 없습니다.');
      return null;
    }

    // blinkerIDs를 쿼리 파라미터로 변환
    String blinkerIdsQuery = blinkerIds.join(',');

    final response = await http.get(
      Uri.parse('$baseUrl/map/blinker?blinkerIDs=$blinkerIdsQuery'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      print('신호등 상태 정보 조회 성공');
      return jsonDecode(utf8.decode(response.bodyBytes))['blinkerDTOs'];
    } else {
      print('신호등 상태 정보 조회 실패: ${response.statusCode}');
      return null;
    }
  }

  // 길안내 완료 요청 (POST)
  Future<Map<String, dynamic>?> guideFinish({
    required double distance,
    required String startTime,
    required bool watch,
  }) async {
    String? accessToken = await storage.read(key: 'accessToken');

    if (accessToken == null) {
      print('엑세스 토큰이 없습니다.');
      return null;
    }

    // 요청 바디 생성
    Map<String, dynamic> requestBody = {
      'distance': distance,
      'startTime': startTime,
      'watch': watch,
    };

    print('길안내 완료 요청 데이터: $requestBody');

    final response = await http.post(
      Uri.parse('$baseUrl/map/guide'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
      body: json.encode(requestBody),
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      print('길안내 완료 요청 성공');

      await storage.write(key: 'isModified', value: 'true');

      return {'message': response.body};
    } else {
      print('길안내 완료 요청 실패: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  }

  Future<bool> updateBookmarkType(int id, int newType) async {
    String? accessToken = await storage.read(key: 'accessToken');

    final response = await http.put(
      Uri.parse('$baseUrl/map/bookmark'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'id': id,
        'type': newType == 0
            ? "HOME"
            : newType == 1
                ? "COMPANY"
                : "ETC", // "HOME", "COMPANY", "ETC" 중 하나
      }),
    );

    if (response.statusCode == 200) {
      print('북마크 수정 성공');
      return true;
    } else {
      print('북마크 수정 실패: ${response.statusCode}, ${response.body}');
      return false;
    }
  }

  Future<bool> updateBlinkerWithTimes({
    required String id,
    required String startTime,
    required String middleTime,
    required String endTime,
  }) async {
    String? accessToken = await storage.read(key: 'accessToken');

    // hhmmss -> hh:mm:ss 형식으로 변환하는 함수
    String formatTime(String time) {
      if (time.length == 6) {
        return '${time.substring(0, 2)}:${time.substring(2, 4)}:${time.substring(4, 6)}';
      } else {
        throw Exception("Invalid time format");
      }
    }

    // 시간을 형식에 맞게 변환
    String formattedStartTime = formatTime(startTime);
    String formattedMiddleTime = formatTime(middleTime);
    String formattedEndTime = formatTime(endTime);

    final response = await http.put(
      Uri.parse('$baseUrl/report/blinker'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'id': id,
        'startTime': formattedStartTime,
        'middleTime': formattedMiddleTime,
        'endTime': formattedEndTime,
      }),
    );

    if (response.statusCode == 200) {
      print('신호등 수정 성공');
      return true;
    } else {
      print('신호등 수정 실패: ${response.statusCode}, ${response.body}');
      return false;
    }
  }


  Future<bool> updateBookmarkAlarm({
    required int id,
    required bool alarmStatus,
  }) async {
    // 저장된 액세스 토큰 읽기
    String? accessToken = await storage.read(key: 'accessToken');

    // 쿼리 파라미터로 bookmarkId와 alarmStatus 전달
    print(id);
    print(alarmStatus);
    final response = await http.put(
      Uri.parse('$baseUrl/map/bookmark/alarm?bookmarkId=$id&alarmStatus=$alarmStatus'),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $accessToken', // Bearer 토큰 인증
      },
    );

    // API 응답 처리
    if (response.statusCode == 200) {
      print('Bookmark alarm update successful');
      return true;
    } else {
      print('Failed to update bookmark alarm: ${response.statusCode}, ${response.body}');
      return false;
    }
  }

  Future<bool> putBookmarkTime({required int id}) async {
    // 저장된 액세스 토큰 읽기
    String? accessToken = await storage.read(key: 'accessToken');
    print(id);

    // POST 요청에 빈 body 추가
    final response = await http.post(
      Uri.parse('$baseUrl/map/bookmark/time?bookmarkId=$id'),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $accessToken', // Bearer 토큰 인증
      },
      body: '',  // 빈 body 전달
    );

    // API 응답 처리
    if (response.statusCode == 200) {
      print('북마크 시간 수정 성공');
      return true;
    } else {
      print('북마크 시간 수정 실패: ${response.statusCode}, ${response.body}');
      return false;
    }
  }


}
