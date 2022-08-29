import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_ichiran/util/string_util.dart';
import 'package:url_launcher/url_launcher.dart';
import '../db/select.dart';
import '../db/model/list.dart';
import '../main.dart';
import 'package:flutter/services.dart';

class ListPage extends ConsumerWidget {
  ListPage({Key? key}) : super(key: key);

  void getItems() async {
    List<Item> items = await getLists();
    print(items[0].uri);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Item>> items = ref.watch(itemProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('履歴'),
      ),
      body: items.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Text('Error: $err'),
          data: (items) {
            return RefreshIndicator(
              onRefresh: () async {
                ref.refresh(itemProvider);
              },
              child: Center(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final String item = items[index].uri;
                    return ListTile(
                      title: Text(item),
                      onTap: () async {
                        if (StringUtil.iscontainHttp(item)) {
                          // URLならブラウザ
                          Uri uri = Uri.parse(item);
                          launchUrl(uri, mode: LaunchMode.externalApplication);
                        } else {
                          // クリップボードにコピー
                          final data = ClipboardData(text: item);
                          await Clipboard.setData(data);
                        }
                      },
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}
