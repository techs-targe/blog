#!/bin/bash

# 使用方法: ./create_article_image.sh "記事番号" "記事タイトル"
# 例: ./create_article_image.sh "002" "新しい記事のタイトル"

if [ $# -ne 2 ]; then
    echo "使用方法: $0 <記事番号> <記事タイトル>"
    echo "例: $0 002 \"新しい記事のタイトル\""
    exit 1
fi

ARTICLE_ID=$1
TITLE=$2
BASE_IMAGE="images/default.png"
OUTPUT_IMAGE="images/${ARTICLE_ID}.png"

# ベース画像が存在するか確認
if [ ! -f "$BASE_IMAGE" ]; then
    echo "エラー: ベース画像 $BASE_IMAGE が見つかりません"
    exit 1
fi

# 画像にタイトルを追加
echo "画像を生成中: $OUTPUT_IMAGE"
convert "$BASE_IMAGE" \
    -gravity center \
    -font "Noto-Sans-CJK-JP-Bold" \
    -pointsize 48 \
    -fill white \
    -stroke black \
    -strokewidth 2 \
    -kerning 1 \
    -annotate +0+0 "$TITLE" \
    "$OUTPUT_IMAGE"

if [ $? -eq 0 ]; then
    echo "✅ 画像を生成しました: $OUTPUT_IMAGE"
else
    echo "❌ 画像の生成に失敗しました"
    exit 1
fi