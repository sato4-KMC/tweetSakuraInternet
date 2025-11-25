const express = require('express');
const app = express();
const fs = require('fs'); // これを追加
const cors = require('cors');
app.use(cors());

app.use(express.urlencoded({ extended: false }));

app.get('/', (req, res) => {
  res.send(`
    <form action="/submit" method="post">
      <input name="userName" placeholder="名前">
      <input name="emoji" placeholder="絵文字">
      <input name="text" placeholder="メッセージ">
      <input type="submit" value="送信">
    </form>
  `);
});

// 直近のツイート一覧を返す（JSON）
app.get('/tweets', (req, res) => {
//コピペ、ファイル存在を確認
  const FILE_PATH = 'backend/data.json';
  if (!fs.existsSync(FILE_PATH)) {
    return res.json([]); 
  }
  // utf8で生データ取得
  try {
    const raw = fs.readFileSync(FILE_PATH, 'utf8');
    // jsonに変更
    const data = JSON.parse(raw);
    if (!Array.isArray(data)) {
      return res.json([]);
    }
    // jsonを返す
    return res.json(data);
  } catch (err) {
    console.error('Error reading tweets:', err);
    return res.status(500).json({ error: 'Failed to read tweets' });
  }
});

// Tokyo の現在時刻を返す
function getTokyoTime() {
  return new Date().toLocaleString("ja-JP", {
    timeZone: "Asia/Tokyo",
    hour12: false
  });
}

app.post('/submit', (req, res) => {
  const { userName, text, emoji } = req.body;
  // 追加するJSONデータ
  const newItem = {
    emoji: emoji ?? "🐈",
    userName: userName ?? "名前",
    text: text ?? "メッセージ",
    createdAt: getTokyoTime(),
  };
  // ファイル読み込み
  const FILE_PATH = "backend/data.json";
  let data = [];
  if (fs.existsSync(FILE_PATH)) {
    data = JSON.parse(fs.readFileSync(FILE_PATH, "utf8"));
    if (!Array.isArray(data)) data = [];
  }  
  data.unshift(newItem); // 先頭に追加
  fs.writeFileSync(FILE_PATH, JSON.stringify(data, null, 2), "utf8"); // 保存
  res.json(data); // 結果を表示
});

app.listen(2326, () => console.log("http://localhost:2326/"));