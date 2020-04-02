import 'package:dio/dio.dart';

class HttpUtils {
  static String homeUrl =
      'https://m.douban.com/rexxar/api/v2/movie/modules?need_manual_chart_card=1&for_mobile=1';

  static Future getHttp(String url) async {
    try {
      Response response = await Dio().get(url,
          options: Options(headers: {
            'Referer': 'https://m.douban.com/movie/',
            'Sec-Fetch-Dest': 'empty',
            'User-Agent':
                'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Mobile Safari/537.36'
          }));
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
