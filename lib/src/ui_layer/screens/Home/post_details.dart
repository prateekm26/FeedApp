import 'package:feed_app/src/business_layer/providers/feed_provider.dart';
import 'package:feed_app/src/data_layer/models/feed/post_res_model.dart';
import 'package:feed_app/src/data_layer/res/app_colors.dart';
import 'package:feed_app/src/data_layer/res/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDetails extends StatefulWidget {
  Post? post;
  PostDetails({Key? key, this.post}) : super(key: key);

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  late FeedProvider _feedProvider;
  @override
  Widget build(BuildContext context) {
    _feedProvider = Provider.of<FeedProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              AppImages.backArrow,
            ),
          ),
        ),
        title: const Text(
          "Post Details",
          style: TextStyle(color: AppColors.blackColor),
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Post by ${_feedProvider.getUserDetail(widget.post!.userId!).name}",
              style: const TextStyle(color: AppColors.blackColor, fontSize: 18),
            ),
            /* const SizedBox(
              height: 8,
            ),*/
            Text(
                "@${_feedProvider.getUserDetail(widget.post!.userId!).username}"),
            const SizedBox(
              height: 8,
            ),
            Text(
                "${_feedProvider.getUserDetail(widget.post!.userId!).company!.name} | ${_feedProvider.getUserDetail(widget.post!.userId!).address!.city}"),
            const SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
            ),
            Text(
              " ${widget.post!.title ?? ""}",
              style: const TextStyle(
                  color: backgroundColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 21),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(" ${widget.post!.body ?? ""}")
          ],
        ),
      ),
    );
  }
}
