// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _WeatherClient implements WeatherClient {
  _WeatherClient(this._dio, {this.baseUrl}) {
    baseUrl ??=
        'https://api.openweathermap.org/data/2.5/onecall?lat=21.0292463&lon=105.7840287&exclude=hourly,daily&appid=874a52330809cbc3fe14d16f1567718d';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<WeatherModel> getWeatherCurrent() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WeatherModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WeatherModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
