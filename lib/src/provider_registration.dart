import 'package:feed_app/src/business_layer/providers/base_provider.dart';
import 'package:feed_app/src/business_layer/providers/feed_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class RegisterProviders {
  //Register all providers used in the application here
  static List<SingleChildWidget> providers(BuildContext context) {
    return [
      ChangeNotifierProvider<BaseProvider>(
        create: (context) => BaseProvider(),
      ),
      ChangeNotifierProvider<FeedProvider>(
        create: (context) => FeedProvider(),
      ),
    ];
  }
}
