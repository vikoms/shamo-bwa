class BaseResponse<T> {
  final Meta meta;
  final T data;

  BaseResponse({required this.meta, required this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      meta: Meta.fromJson(json['meta']),
      data: json['data'],
    );
  }
}

class Meta {
  final int code;
  final String status;
  final String message;

  Meta({required this.code, required this.status, required this.message});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      code: json['code'],
      status: json['status'],
      message: json['message'],
    );
  }
}
