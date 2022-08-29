import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_ichiran/db/insert.dart';
import 'package:qr_ichiran/db/model/list.dart';
import 'package:qr_ichiran/util/string_util.dart';
import 'package:qr_ichiran/widget/custom_alert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('読み取る'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      // 読み取ったら止める
      controller.pauseCamera();
      try {
        // 最後に内部ストレージに保存する
        insertList(Item(uri: scanData.code!));
        if (StringUtil.iscontainHttp(scanData.code!)) {
          // 読み取ったデータがurlだった場合外部ブラウザにアクセス
          Uri uri = Uri.parse(scanData.code!);
          launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          // クリップボードにコピー
          final data = ClipboardData(text: scanData.code!);
          await Clipboard.setData(data);
          var dialog =
              CustomAlertDialog(title: '読み取り完了', message: 'クリップボードにコピーしました。');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return dialog;
              });
        }
      } catch (e) {
        var dialog = CustomAlertDialog(
            title: 'エラー', message: '予期せぬエラーが発生しました。アプリを再起動してください');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return dialog;
            });
      }
      // 処理が終わったら再開
      await controller.resumeCamera();
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
