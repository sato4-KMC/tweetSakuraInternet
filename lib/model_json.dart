import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';

class TweetLoader {
  static Tweet fromJson(Map<String, dynamic> json) {
    return Tweet(
      json['emoji'] ?? '😎', 
      json['userName'] ?? '未設定', 
      json['text'] ?? '未設定', 
      json['createdAt'] ?? '未設定'
    );
  }

  static Future<List<Tweet>> fetchTweets() async {
    final url = 'http://kmc2326.kamiyama.cc:2326/tweets'; // ← 読み込むデータ
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch tweets');
    }
    final List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((e) => fromJson(e)).toList();
  }
}