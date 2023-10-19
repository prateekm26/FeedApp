import 'package:feed_app/src/business_layer/providers/base_provider.dart';
import 'package:feed_app/src/business_layer/repository/feed_repository.dart';
import 'package:feed_app/src/data_layer/models/base_api_res_model.dart';
import 'package:feed_app/src/data_layer/models/feed/post_res_model.dart';
import 'package:feed_app/src/data_layer/models/feed/user_res_model.dart';

import '../network/request_response_type.dart';

class FeedProvider extends BaseProvider {
  final FeedRepository _feedRepository = FeedRepository();
  UserResModel _userResModel = UserResModel();
  PostResModel _postResModel = PostResModel();

  /// Api to get user list
  Future<String?> getUserList() async {
    if (await checkInternet()) {
      BaseApiResponseModel response = await _feedRepository.getUser();
      if (response.data != null && response.data is UserResModel) {
        _userResModel = response.data;
        if (_userResModel.user != null) {
          print("user fetched");
          notifyListeners();
          return HttpResponseType.success;
        } else {
          return "Something went wrong";
        }
      } else {
        return getExceptionMessage(exceptionType: response.exceptionType);
      }
    } else {
      return "No internet";
    }
  }

  /// api to get post list response
  Future<String?> getPostList() async {
    if (await checkInternet()) {
      BaseApiResponseModel response = await _feedRepository.getPost();
      if (response.data != null && response.data is PostResModel) {
        _postResModel = response.data;
        if (_postResModel.post!.isNotEmpty) {
          print("post fetched");
          notifyListeners();
          return HttpResponseType.success;
        } else {
          return "Something went wrong";
        }
      } else {
        return getExceptionMessage(exceptionType: response.exceptionType);
      }
    } else {
      return "No internet";
    }
  }

  User getUserDetail(int userId) {
    return userResModel.user!.firstWhere((element) => element.id == userId);
  }

  PostResModel get postResModel => _postResModel;

  UserResModel get userResModel => _userResModel;
}
