# 記事管理ガイド

## 新しい記事を追加する方法

### 1. 記事フォルダを作成
```bash
mkdir article/002
```

### 2. テンプレートをコピー
```bash
cp article/template.html article/002/index.html
```

### 3. 記事を編集
`article/002/index.html`を開いて以下を変更：

- `<title>`: 記事タイトル - techs-targe
- メタタグ内の「記事タイトル」を実際のタイトルに変更
- `XXX`を記事番号（002など）に置換
- `<h3>記事タイトル</h3>`を実際のタイトルに変更
- `<div class="article-meta">yymmdd hh:mm</div>`を実際の日時に変更
- `<article>`内に記事本文を追加
- シェア機能の`text`を実際のタイトルに変更

### 4. 画像を追加
```bash
# images/002.png を追加
```

### 5. index.htmlの記事リストを更新
`/blog/index.html`の`posts`配列に新しい記事を追加：
```javascript
const posts = [
    { id: '002', title: '新しい記事タイトル', date: 'yymmdd hh:mm' },
    { id: '001', title: 'AI時代における統合者の必要性', date: '250712 11:58' }
];
```

### 6. GitHubにプッシュ
```bash
git add .
git commit -m "記事追加: 新しい記事タイトル"
git push origin main
```

## 記事URLの構造

- 記事一覧: `https://techs-targe.github.io/blog/`
- 個別記事: `https://techs-targe.github.io/blog/article/001/`

## X Cardsの確認

記事公開後、以下で確認：
- https://cards-dev.twitter.com/validator