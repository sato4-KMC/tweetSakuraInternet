import 'package:flutter/material.dart';
import 'user_setting.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController  = TextEditingController();
  final TextEditingController _emojiController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadCurrentValues();
  }
  Future<void> _loadCurrentValues() async {
    _nameController.text  = await UserSetting.getName();
    _emojiController.text = await UserSetting.getEmoji();
    setState(() {});
  }
  Future<void> _save() async {
    await UserSetting.setName(_nameController.text);
    await UserSetting.setEmoji(_emojiController.text);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('プロファイルを保存しました')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロファイル設定'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('名前'),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: '名前を入力'),
            ),
            const SizedBox(height: 16),
            const Text('絵文字'),
            TextField(
              controller: _emojiController,
              maxLength: 1,
              decoration: const InputDecoration(hintText: '🐈 など'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                child: const Text('保存する'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}