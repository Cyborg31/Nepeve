import 'package:flutter/material.dart';

import '../auth.dart';

class ProviderPage extends InheritedWidget {
  final Auth auth;
  final db;
  final colors;

  ProviderPage({Key key, Widget child, this.auth, this.db, this.colors})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static ProviderPage of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<ProviderPage>());
}
