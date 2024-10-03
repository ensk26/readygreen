import 'package:flutter/material.dart';
import 'package:readygreen/api/pointStep_api.dart';
import 'package:readygreen/constants/appcolors.dart';
import 'package:readygreen/screens/point/pointDetail.dart';
import 'package:readygreen/widgets/common/bgcontainer.dart';


class PointPage extends StatefulWidget {
  @override
  _PointPageState createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  final PointstepApi pointstepApi = PointstepApi();
  List<Map<String, dynamic>> steps = [];
  String point = '0';
  int maxIndex = -1;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    String fetchedPoint = await pointstepApi.fetchPoint(); // 데이터를 기다림
    List<Map<String, dynamic>> fetchedSteps = await pointstepApi.fetchSteps(); // 데이터를 기다림
    setState(() {
      point = fetchedPoint; // 상태 업데이트
      steps = fetchedSteps; // 상태 업데이트
    });

    print(steps);
    print(point);
    int maxStepsIndex = -1; // 초기값 설정
    int maxSteps = 0; // 최대 걸음수 초기화

    for (int i = 0; i < steps.length; i++) {
      int currentSteps = steps[i]['steps'] ?? 0; // 현재 걸음수 가져오기

      if (currentSteps > maxSteps) {
        maxSteps = currentSteps; // 최대 걸음수 업데이트
        maxStepsIndex = i; // 인덱스 업데이트
      }
    }
    setState(() {
      maxIndex = maxStepsIndex;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the background color of the Scaffold to gray
      backgroundColor: Colors.grey[200], // Light gray background
      body: SingleChildScrollView(
        child: BackgroundContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/coin.png',
                  height: 150),
                    const SizedBox(height: 10),
                    Text(
                      '지금 내 포인트는?',
                      style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${point} 포인트',
                      style: TextStyle(fontSize: 28, color: AppColors.green, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                  onTap: () {
                    // 페이지 이동을 처리하는 부분
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PointDetailPage()), // PointDetailPage로 이동
                    );
                  },
                  child: Card(
                    elevation: 0, // 그림자 제거
                    color: Colors.white, // Card background color to white
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '포인트 상세 내역 보기',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 24,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 0, // 그림자 제거
                  color: Colors.white, // Card background color to white
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '오늘 걸음수',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start, // Row 위젯 내의 시작점 정렬
                          children: [
                            Image.asset('assets/images/walk.png', height: 120),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(steps.length>0?
                                  '${steps[0]['steps']} 걸음':'걸음',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: const Color.fromARGB(255, 105, 181, 6),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5), // 간격 추가
                                SizedBox(
                                  width: 150, // 텍스트 길이를 제한하여 오버플로우 발생 시 줄바꿈을 유도
                                  child: Text(
                                    '현재까지 약 ${steps.length > 0 ? (steps[0]['steps'] * 70 / 1000).toStringAsFixed(1) : 0.0}km를 걸었어요!',
                                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                    softWrap: true, // 자동으로 다음 줄로 넘어가도록 설정
                                    overflow: TextOverflow.visible, // 텍스트 오버플로우 처리
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 0, // 그림자 제거
                  color: Colors.white, // Card background color to white
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '걸음 추세',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        // const SizedBox(height: 8),
                        Center(
                          child: Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: steps.length>0?'${steps[0]['steps']}':'0', 
                                      style: TextStyle(
                                        fontSize: 25, 
                                        fontWeight: FontWeight.bold, 
                                        color: Colors.black87,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' 걸음', 
                                      style: TextStyle(
                                        fontSize: 16, // 걸음은 기존 크기 유지
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8), 
                              Text(steps.length>0?steps[0]['steps']<steps[1]['steps']?'걸음수가 어제보다 줄어들었어요!':
                                '오늘은 어제보다 ${steps[0]['steps']-steps[1]['steps']}걸음 더 걸었어요!'
                                : '로딩중...',
                                style: TextStyle(fontSize: 13, color: AppColors.greytext),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildWalkingTrendGraph(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 간단한 걸음 추세 그래프
  Widget _buildWalkingTrendGraph() {
  return SizedBox(
    height: 130, // 전체 높이를 200으로 설정
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildBar(steps.length>0?steps[6]['dayInitial']:'?', steps.length>0?steps[6]['steps']/steps[maxIndex]['steps']:0,0),
        _buildBar(steps.length>0?steps[5]['dayInitial']:'?', steps.length>0?steps[5]['steps']/steps[maxIndex]['steps']:0,0),
        _buildBar(steps.length>0?steps[4]['dayInitial']:'?', steps.length>0?steps[4]['steps']/steps[maxIndex]['steps']:0,0),
        _buildBar(steps.length>0?steps[3]['dayInitial']:'?', steps.length>0?steps[3]['steps']/steps[maxIndex]['steps']:0,0),
        _buildBar(steps.length>0?steps[2]['dayInitial']:'?', steps.length>0?steps[2]['steps']/steps[maxIndex]['steps']:0,0),
        _buildBar(steps.length>0?steps[1]['dayInitial']:'?', steps.length>0?steps[1]['steps']/steps[maxIndex]['steps']:0,0),
        _buildBar('오늘', steps.length>0?steps[0]['steps']/steps[maxIndex]['steps']:0,1),
      ],
    ),
  );
}

  // 바 그래프 요소
  Widget _buildBar(String day, double heightFactor, int type) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end, 
    children: [
      Container(
        width: 27,
        height: 100 * heightFactor,
        decoration: BoxDecoration(
          color: type == 0 
              ? AppColors.routegreen.withOpacity(0.5) 
              : AppColors.routegreen,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      SizedBox(height: 5),
      Text(day, style: TextStyle(fontSize: 12,color: AppColors.greytext)),
    ],
  );
}


}
