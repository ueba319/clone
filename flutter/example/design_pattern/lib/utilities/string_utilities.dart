class StringUtilities {
  // プライベートコンストラクタ：外部からのインスタンス化を防ぐ
  StringUtilities._();

  // 静的インスタンス：クラス唯一のインスタンス
  static final StringUtilities _instance = StringUtilities._();

  // ファクトリコンストラクタ：StringUtilities()を通じてアクセス可能
  factory StringUtilities() {
    return _instance;
  }

  /// 全角スペースを半角スペースに変換したうえで、前後のスペースをトリミングする
  String trim(String text) {
    return text.replaceAll('　', ' ').trim();
  }

  /// 文字列が空文字かどうかを判定
  bool isEmpty(String text) {
    return trim(text).isEmpty;
  }
}
