import 'package:flutter/material.dart';
import 'view.dart';
import 'model.dart';
import 'model_json.dart';

class TweetPage extends StatefulWidget {
  const TweetPage({super.key});
  @override
  State<TweetPage> createState() => _TweetPageState();
}

class _TweetPageState extends State<TweetPage> {
  // すべてのツイート（データ源）
  List<Tweet> _all = const [];

  // 選択中の発言者（null = 全部表示）
  String? _selectedUser;

  // 表示用（フィルタ適用）
  List<Tweet> get _visible {
    if (_selectedUser == null) return _all;
    return _all.where((t) => t.userName == _selectedUser).toList();
  }

  // 発言者の候補（重複なし）
  List<String> get _users =>
    (_all.map((t) => t.userName).toSet().toList()..sort());
    
  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async { 
    final items = await TweetLoader.fetchTweets();
    setState(() {
      _all = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedUser == null ? 'タイムライン表示' : '$_selectedUser の投稿'),
        actions: [
          IconButton(onPressed: _fetch, icon: Icon(Icons.update)),
          // 発言者フィルタ（PopupMenu）
          PopupMenuButton<String?>(
            tooltip: '発言者でフィルタ',
            initialValue: _selectedUser,
            onSelected: (value) => setState(() => _selectedUser = value),
            itemBuilder: (context) => [
              const PopupMenuItem<String?>(
                value: null,
                child: Text('すべて表示'),
              ),
              const PopupMenuDivider(),
              ..._users.map(
                (name) => PopupMenuItem<String?>(
                  value: name,
                  child: Row(
                    children: [
                      if (_selectedUser == name)
                        const Icon(Icons.check, size: 18),
                      if (_selectedUser == name) const SizedBox(width: 8),
                      Text(name),
                    ],
                  ),
                ),
              ),
            ],
            icon: const Icon(Icons.filter_list),
          ),
          // フィルタ解除のショートカット
          if (_selectedUser != null)
            IconButton(
              tooltip: 'フィルタ解除',
              icon: const Icon(Icons.clear),
              onPressed: () => setState(() => _selectedUser = null),
            ),
        ],
      ),
      body: SafeArea(
        child: _visible.isEmpty
            ? const Center(child: Text('投稿がありません'))
            : ListView.builder(
                itemCount: _visible.length,
                itemBuilder: (context, i) => tweetCard(context, _visible[i]),
              ),
      ),
    );
  }
}