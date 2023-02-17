import 'package:dio/dio.dart';

class DioErrorHelper {
  static String getErrorMessage(DioError error) {
    String errorMessage = "An unknown error occurred.";
    switch (error.type) {
      case DioErrorType.connectTimeout:
        errorMessage = "Connection timeout with API server.";
        break;
      case DioErrorType.sendTimeout:
        errorMessage = "Send timeout in connection with API server.";
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = "Receive timeout in connection with API server.";
        break;
      case DioErrorType.response:
        errorMessage =
            "Received invalid status code: ${error.response?.statusCode} \n error: ${error.response?.statusMessage}";
        break;
      case DioErrorType.cancel:
        errorMessage = "Request to API server was cancelled.";
        break;
      case DioErrorType.other:
        errorMessage =
            "Connection to API server failed due to internet connection issue.";
        break;
    }
    return errorMessage;
  }
}
