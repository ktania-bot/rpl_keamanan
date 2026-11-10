
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/user.dart';
import '../models/post.dart';
import 'logger.dart';

/// Service untuk komunikasi HTTP dengan REST API.
class ApiService {
  final http.Client _client;
  final String _baseUrl;

  ApiService({
    http.Client? client,
    String? baseUrl,
  })  : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? AppConfig.baseUrl;

  /// Mengambil daftar pengguna dari API.
  Future<List<User>> getUsers() async {
    try {
      Logger.info('Memulai pengambilan daftar pengguna');

      _logRequest('GET', '/users');

      final response = await _client
          .get(
            Uri.parse('$_baseUrl/users'),
            headers: _buildHeaders(),
          )
          .timeout(
            Duration(seconds: AppConfig.timeoutSeconds),
          );

      _logResponse(response.statusCode);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        Logger.info('Daftar pengguna berhasil diambil');

        return data
            .map(
              (item) => User.fromJson(
                item as Map<String, dynamic>,
              ),
            )
            .toList();
      }

      Logger.warning(
        'Pengambilan pengguna gagal dengan status ${response.statusCode}',
      );

      throw Exception(
        'Gagal memuat data pengguna. Status: ${response.statusCode}',
      );
    } on TimeoutException {
      Logger.error('Request pengguna mengalami timeout');

      throw Exception(
        'Request timeout. Periksa koneksi internet Anda.',
      );
    } on SocketException {
      Logger.error('Tidak ada koneksi internet');

      throw Exception(
        'Tidak ada koneksi internet. Periksa jaringan Anda.',
      );
    } on FormatException {
      Logger.error('Format data pengguna tidak valid');

      throw Exception(
        'Format data dari server tidak valid.',
      );
    }
  }

  /// Mengambil pengguna berdasarkan ID.
  Future<User> getUserById(int id) async {
    if (id <= 0) {
      throw ArgumentError(
        'ID pengguna harus lebih dari 0.',
      );
    }

    try {
      Logger.info('Memulai pengambilan data pengguna berdasarkan ID');

      _logRequest('GET', '/users/$id');

      final response = await _client
          .get(
            Uri.parse('$_baseUrl/users/$id'),
            headers: _buildHeaders(),
          )
          .timeout(
            Duration(seconds: AppConfig.timeoutSeconds),
          );

      _logResponse(response.statusCode);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            jsonDecode(response.body);

        Logger.info('Data pengguna berhasil diambil');

        return User.fromJson(data);
      }

      Logger.warning(
        'Pengambilan pengguna berdasarkan ID gagal: ${response.statusCode}',
      );

      throw Exception(
        'Gagal memuat data pengguna. Status: ${response.statusCode}',
      );
    } on TimeoutException {
      Logger.error('Request pengguna mengalami timeout');

      throw Exception(
        'Request timeout. Periksa koneksi internet Anda.',
      );
    } on SocketException {
      Logger.error('Tidak ada koneksi internet');

      throw Exception(
        'Tidak ada koneksi internet. Periksa jaringan Anda.',
      );
    } on FormatException {
      Logger.error('Format data pengguna tidak valid');

      throw Exception(
        'Format data dari server tidak valid.',
      );
    }
  }

  /// Mengambil seluruh daftar Post dari API.
  Future<List<Post>> getPosts() async {
    try {
      Logger.info('Memulai pengambilan daftar Post');

      _logRequest('GET', '/posts');

      final response = await _client
          .get(
            Uri.parse('$_baseUrl/posts'),
            headers: _buildHeaders(),
          )
          .timeout(
            Duration(seconds: AppConfig.timeoutSeconds),
          );

      _logResponse(response.statusCode);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        Logger.info('Daftar Post berhasil diambil');

        return data
            .map(
              (item) => Post.fromJson(
                item as Map<String, dynamic>,
              ),
            )
            .toList();
      }

      Logger.warning(
        'Pengambilan Post gagal dengan status ${response.statusCode}',
      );

      throw Exception(
        'Gagal mengambil data Post. Status: ${response.statusCode}',
      );
    } on TimeoutException {
      Logger.error('Request Post mengalami timeout');

      throw Exception(
        'Request mengalami timeout.',
      );
    } on SocketException {
      Logger.error('Tidak ada koneksi internet');

      throw Exception(
        'Tidak ada koneksi internet.',
      );
    } on FormatException {
      Logger.error('Format data Post tidak valid');

      throw Exception(
        'Format data Post tidak valid.',
      );
    }
  }

  /// Membuat header request HTTP.
  Map<String, String> _buildHeaders() {
    return {
      'Content-Type': 'application/json',
      'X-API-Key': AppConfig.apiKey,
    };
  }

  /// Mencatat request tanpa informasi sensitif.
  void _logRequest(String method, String endpoint) {
    Logger.debug('[$method] $endpoint');
  }

  /// Mencatat status response.
  void _logResponse(int statusCode) {
    Logger.debug('Response status: $statusCode');
  }

  /// Menutup HTTP client.
  void dispose() {
    _client.close();
  }
}
