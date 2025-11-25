import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mvc/user_setting.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final textController = TextEditingController();
  String result = "";
  String _userName = "";
  String _emoji = "";

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final n = await UserSetting.getName();
    final e = await UserSetting.getEmoji();
    setState(() {
      _userName = n;
      _emoji = e;
    });
  }

  Future<void> send() async {
    final url = Uri.parse("http://kmc2326.kamiyama.cc:2326/submit");
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        "userName": _userName, // ← プロファイル設定で保存したユーザ名
        "emoji": _emoji, // ← プロファイル設定で保存した絵文字も送信する
        "text": textController.text,
      },
    );
    setState(() {
      result = response.body; // そのまま表示
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("POST投稿画面")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "あなたのプロフィール",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // 名前＋絵文字の表示
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "$_emoji $_userName",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            
            TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: "メッセージ"),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: send,
              child: const Text("送信"),
            ),

            const SizedBox(height: 16),
            Text(result),
          ],
        ),
      ),
    );
  }
}
