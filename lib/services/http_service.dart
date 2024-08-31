import 'package:dio/dio.dart';

class HttpService {
  final _dio = Dio();
  Future<Response?> fetchData(String url) async {
    try {
      Response response = await _dio.get(url);
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
