import 'dart:convert';

import 'package:feed_app/src/business_layer/network/api_constants.dart';
import 'package:feed_app/src/business_layer/network/request_response_type.dart';
import 'package:feed_app/src/business_layer/util/helper/log_helper.dart';
import 'package:feed_app/src/data_layer/models/feed/post_res_model.dart';
import 'package:feed_app/src/data_layer/models/feed/user_res_model.dart';
import 'package:http/http.dart' as http;

import '../../data_layer/models/base_api_res_model.dart';

class FeedRepository {
  final String _tag = "Feed Repository: ";
  Map<String, dynamic>? _responseBody;

  Future<BaseApiResponseModel> getUser() async {
    try {
      final response = await http
          .get(Uri.parse("${ApiConstants.baseUrl}${ApiConstants.userList}"));

      LogHelper.logData(_tag + response.body.toString());
      if (response.body != null && response.statusCode == 200) {
        _responseBody = {};
        _responseBody!['user'] = json.decode(response.body.toString());
        print("res#### ${_responseBody}");
        return BaseApiResponseModel(
            data: UserResModel.fromJson(_responseBody!));
      } else {
        return BaseApiResponseModel(exceptionType: ExceptionType.apiException);
      }
    } catch (e) {
      LogHelper.logError(_tag + e.toString());
      return BaseApiResponseModel(exceptionType: ExceptionType.parseException);
    }
  }

  Future<BaseApiResponseModel> getPost() async {
    try {
      final response = await http
          .get(Uri.parse("${ApiConstants.baseUrl}${ApiConstants.postList}"));

      LogHelper.logData(_tag + response.body.toString());
      if (response.body != null && response.statusCode == 200) {
        _responseBody = {};
        _responseBody!['post'] = json.decode(response.body.toString());
        return BaseApiResponseModel(
            data: PostResModel.fromJson(_responseBody!));
      } else {
        return BaseApiResponseModel(exceptionType: ExceptionType.apiException);
      }
    } catch (e) {
      LogHelper.logError(_tag + e.toString());
      return BaseApiResponseModel(exceptionType: ExceptionType.parseException);
    }
  }
}
