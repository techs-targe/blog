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

# タイトルの長さをチェック（文字数が20文字以上の場合は2行に分割）
TITLE_LENGTH=${#TITLE}

# 画像にタイトルを追加（バナースタイル）
echo "画像を生成中: $OUTPUT_IMAGE"

if [ $TITLE_LENGTH -gt 20 ]; then
    # 長いタイトルは2行に分割
    # タイトルを適切な位置で分割（「で」「を」「の」「に」などで分割を試みる）
    if [[ "$TITLE" == *"で"* ]]; then
        FIRST_LINE=$(echo "$TITLE" | sed 's/\(.*で\).*/\1/')
        SECOND_LINE=$(echo "$TITLE" | sed 's/.*で\(.*\)/\1/')
    elif [[ "$TITLE" == *"を"* ]]; then
        FIRST_LINE=$(echo "$TITLE" | sed 's/\(.*を[^を]*\).*/\1/')
        SECOND_LINE=$(echo "$TITLE" | sed 's/.*を[^を]*\(.*\)/\1/')
    else
        # 文字数で半分に分割
        HALF_LENGTH=$((TITLE_LENGTH / 2))
        FIRST_LINE=$(echo "$TITLE" | cut -c1-$HALF_LENGTH)
        SECOND_LINE=$(echo "$TITLE" | cut -c$((HALF_LENGTH + 1))-)
    fi
    
    echo "2行に分割: '$FIRST_LINE' / '$SECOND_LINE'"
    
    convert "$BASE_IMAGE" \
        -fill "rgba(0,0,0,0.7)" \
        -draw "rectangle 0,200 1200,400" \
        -gravity center \
        -font "Noto-Sans-CJK-JP-Bold" \
        -pointsize 42 \
        -fill white \
        -annotate +0-25 "$FIRST_LINE" \
        -annotate +0+35 "$SECOND_LINE" \
        "$OUTPUT_IMAGE"
else
    # 短いタイトルは1行で表示
    convert "$BASE_IMAGE" \
        -fill "rgba(0,0,0,0.7)" \
        -draw "rectangle 0,200 1200,400" \
        -gravity center \
        -font "Noto-Sans-CJK-JP-Bold" \
        -pointsize 52 \
        -fill white \
        -annotate +0+0 "$TITLE" \
        "$OUTPUT_IMAGE"
fi

if [ $? -eq 0 ]; then
    echo "✅ 画像を生成しました: $OUTPUT_IMAGE"
else
    echo "❌ 画像の生成に失敗しました"
    exit 1
fi