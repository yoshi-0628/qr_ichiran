class StringUtil {
  // 引数にhttpが含まれているか確認する
  static bool iscontainHttp(String value) {
    return value.contains('http');
  }
}
