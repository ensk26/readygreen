import 'package:flutter/material.dart';
import 'package:readygreen/constants/appcolors.dart';
import 'package:readygreen/screens/map/resultmap.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math'; // Random을 사용하기 위해 추가

class CardBoxPlace extends StatefulWidget {
  final List<Map<String, String>> places;
  final String selectedCategory;

  const CardBoxPlace({
    super.key,
    required this.places,
    required this.selectedCategory,
  });

  @override
  _CardBoxPlaceState createState() => _CardBoxPlaceState();
}

class _CardBoxPlaceState extends State<CardBoxPlace> {
  final Map<int, String> imageCache = {};

  // 로컬 이미지 리스트 추가
  final List<String> restaurantImages = [
    'assets/images/restaurant/1.png',
    'assets/images/restaurant/2.png',
    'assets/images/restaurant/3.png',
    'assets/images/restaurant/4.png',
    'assets/images/restaurant/5.png',
    'assets/images/restaurant/6.png',
    'assets/images/restaurant/7.png',
    'assets/images/restaurant/8.png',
    'assets/images/restaurant/9.png',
    'assets/images/restaurant/10.png',
    'assets/images/restaurant/11.png',
    'assets/images/restaurant/12.png',
    'assets/images/restaurant/13.png',
    'assets/images/restaurant/14.png',
    'assets/images/restaurant/15.png',
    'assets/images/restaurant/16.png',
    'assets/images/restaurant/17.png',
    'assets/images/restaurant/18.png',
    'assets/images/restaurant/19.png',
    'assets/images/restaurant/20.png',
    'assets/images/restaurant/21.png',
    'assets/images/restaurant/22.png',
    'assets/images/restaurant/23.png',
    'assets/images/restaurant/24.png',
    'assets/images/restaurant/25.png',
    'assets/images/restaurant/26.png',
    'assets/images/restaurant/27.png',
    'assets/images/restaurant/28.png',
    'assets/images/restaurant/29.png',
    'assets/images/restaurant/30.png',
  ];

  final List<String> cafeImages = [
    'assets/images/cafe/1.png',
    'assets/images/cafe/2.png',
    'assets/images/cafe/3.png',
    'assets/images/cafe/4.png',
    'assets/images/cafe/5.png',
    'assets/images/cafe/6.png',
    'assets/images/cafe/7.png',
    'assets/images/cafe/8.png',
    'assets/images/cafe/9.png',
    'assets/images/cafe/10.png',
    'assets/images/cafe/11.png',
    'assets/images/cafe/12.png',
    'assets/images/cafe/13.png',
    'assets/images/cafe/14.png',
    'assets/images/cafe/15.png',
    'assets/images/cafe/16.png',
    'assets/images/cafe/17.png',
    'assets/images/cafe/18.png',
    'assets/images/cafe/19.png',
    'assets/images/cafe/20.png',
    'assets/images/cafe/21.png',
    'assets/images/cafe/22.png',
    'assets/images/cafe/23.png',
    'assets/images/cafe/24.png',
    'assets/images/cafe/25.png',
    'assets/images/cafe/26.png',
    'assets/images/cafe/27.png',
    'assets/images/cafe/28.png',
    'assets/images/cafe/29.png',
    'assets/images/cafe/30.png',
  ];

  // 한글 카테고리를 영어로 매핑하는 Map
  final Map<String, String> categoryMapping = {
    '전체': 'place',
    '맛집': 'restaurant',
    '카페': 'cafe',
    '편의점': 'supermarket',
    '은행': 'bank',
    '병원': 'hospital',
    '약국': 'pharmacy',
    '영화관': 'cinema',
    '놀거리': 'entertainment',
    '헬스장': 'gym',
    '공원': 'park',
  };

  Future<void> loadImages() async {
    String category =
        categoryMapping[widget.selectedCategory] ?? 'all'; // 한글 카테고리를 영어로 변환

    for (var i = 0; i < widget.places.length; i++) {
      String imageUrl;

      // 카테고리가 '맛집' 또는 '카페'일 경우 로컬 이미지 사용
      if (widget.selectedCategory == '맛집') {
        imageUrl = restaurantImages[i % restaurantImages.length];
      } else if (widget.selectedCategory == '카페') {
        imageUrl = cafeImages[i % cafeImages.length];
      } else {
        // 그 외 카테고리에서는 Unsplash API를 사용
        imageUrl = await fetchImageUrl(category, i);
      }

      // 이미지 캐시 저장
      if (mounted) {
        setState(() {
          imageCache[i] = imageUrl;
        });
      }
    }
  }

  Future<String> fetchImageUrl(String category, int index) async {
    // print('category $category');
    const String accessKey = 'Tb5m_5NwxbsmqkmYjx5_8sPmhHnXxMhfUTPN3JsH_gQ';
    final String url =
        'https://api.unsplash.com/search/photos?query=$category&client_id=$accessKey&page=${index + 1}';

    // print('url $url');

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['results'].isNotEmpty) {
        // 랜덤 인덱스를 선택하기 위해 Random 클래스 사용
        final randomIndex = Random().nextInt(data['results'].length);
        return data['results'][randomIndex]['urls']['small'];
      }
    }
    return 'https://via.placeholder.com/150';
  }

  @override
  void initState() {
    super.initState();

    // print로 places 값을 출력
    // print('Received places 받은거! : ${widget.places}');
    loadImages();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        width: deviceWidth,
        constraints: BoxConstraints(
          minHeight: deviceHeight * 0.2,
        ),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 18,
          ),
          child: Column(
            children: widget.places.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map<String, String> place = entry.value;
              final String imageUrl =
                  imageCache[index] ?? 'https://via.placeholder.com/150';

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: widget.selectedCategory == '맛집' ||
                                  widget.selectedCategory == '카페'
                              ? Image.asset(
                                  imageUrl, // 로컬 이미지를 표시
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  imageUrl, // 네트워크 이미지를 표시
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                place['name'] ?? '이름 없음',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                place['address'] ?? '주소 정보 없음',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 5),
                              ElevatedButton(
                                onPressed: () {
                                  // 위도와 경도를 double 타입으로 변환 (null 체크 추가)
                                  double latitude = place['latitude'] != null
                                      ? double.parse(place['latitude']!)
                                      : 36.3551083; // 기본값 설정
                                  double longitude = place['longitude'] != null
                                      ? double.parse(place['longitude']!)
                                      : 127.3379517; // 기본값 설정

                                  // null 체크 후 값 출력
                                  print('위도: $latitude, 경도: $longitude');
                                  print('장소 이름: ${place['name']}');
                                  print('주소: ${place['address']}');
                                  print('ID: ${place['id']}');

                                  // ResultMapPage로 이동하며 데이터 전달
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultMapPage(
                                        lat: latitude, // 위도
                                        lng: longitude, // 경도
                                        placeName:
                                            place['name'] ?? '이름 없음', // null 체크
                                        address: place['address'] ??
                                            '주소 정보 없음', // null 체크
                                        searchQuery: place['name'] ??
                                            '검색어 없음', // null 체크
                                        placeId:
                                            place['id'] ?? 'ID 없음', // null 체크
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.white,
                                  foregroundColor: Colors.grey,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: const BorderSide(
                                      color: AppColors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  '지도보기',
                                  style: TextStyle(fontSize: 13),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (index != widget.places.length - 1)
                    const Divider(
                      color: AppColors.grey,
                      thickness: 1,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
