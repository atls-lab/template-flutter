import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final Dio dio = Dio(BaseOptions(
  baseUrl: dotenv.env['BASE_URL'] ?? '',
  followRedirects: false,
));
