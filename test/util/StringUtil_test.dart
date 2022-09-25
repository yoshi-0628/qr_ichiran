import 'package:flutter_test/flutter_test.dart';
import 'package:qr_ichiran/util/string_util.dart';

void main() {
  test('StringUtilのiscontainHttpのテスト', () {
    bool onlyText = StringUtil.iscontainHttp('abc');
    bool containHttp = StringUtil.iscontainHttp('http://www.google.com/');
    bool containHttps = StringUtil.iscontainHttp('https://www.google.com/');
    bool kara = StringUtil.iscontainHttp('');

    // httpsを含まない場合、false,httpを含む場合true
    expect(onlyText, false);
    expect(containHttp, true);
    expect(containHttps, true);
    expect(kara, false);
  });
}
