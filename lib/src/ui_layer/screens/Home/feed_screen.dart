import 'package:feed_app/src/business_layer/providers/feed_provider.dart';
import 'package:feed_app/src/data_layer/res/app_colors.dart';
import 'package:feed_app/src/ui_layer/screens/Home/post_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../data_layer/models/feed/post_res_model.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late FeedProvider _feedProvider;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchUserList();
    });
  }

  Widget build(BuildContext context) {
    _feedProvider = Provider.of<FeedProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Feed",
          style: TextStyle(color: backgroundColor),
        ),
      ),
      body: _body(),
    );
  }

  void _fetchUserList() async {
    await _feedProvider.getUserList();
    await _feedProvider.getPostList();
  }

  _body() {
    return _feedProvider.postResModel.post != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: _feedProvider.postResModel.post!.length,
            itemBuilder: (BuildContext context, int index) {
              return _postDesign(_feedProvider.postResModel.post![index]);
            })
        : const Center(child: CircularProgressIndicator());
  }

  _postDesign(Post post) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostDetails(
                      post: post,
                    )));
      },
      child: Card(
        color: AppColors.cardBackground,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        elevation: 0.5, // Adjust the elevation for shadow effect
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "@${_feedProvider.getUserDetail(post.userId!).username}",
                style: TextStyle(color: backgroundColor),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                post.title ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: AppColors.blackColor),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                post.body ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
