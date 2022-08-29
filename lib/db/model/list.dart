class Item {
  Item({
    required this.uri,
  });
  final String uri;
  Map<String, dynamic> toMap() {
    return {
      'uri': uri,
    };
  }
}
