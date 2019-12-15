import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, banner) {
          if (banner.hasData) {
            var list = [
              'https://hellorfimg.zcool.cn/preview260/162472979.jpg',
              'https://hellorfimg.zcool.cn/preview260/1045935043.jpg',
              'https://hellorfimg.zcool.cn/preview260/1151536337.jpg'
            ];
            return Swiper(
              itemBuilder: (context, index) {
                return Image.network(
                  list[index],
                  fit: BoxFit.cover,
                );
              },
              itemCount: list.length,
              pagination: SwiperPagination(),
              control: SwiperControl(),
            );
          } else {
            return Container(
              child: Center(
                child: Text('加载中...'),
              ),
            );
          }
        },
      ),
    );
  }
}

Future getHomePageContent() async {
  try {
    var dio = Dio();
    dio.options.contentType = 'application/x-www-form-urlencoded';
    var response = await dio.get('https://www.xiuaa.com/');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('服务错误');
    }
  } catch (e) {
    print('error = $e');
  }
}
