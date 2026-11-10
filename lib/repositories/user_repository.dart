import '../models/user.dart';

/// Abstraksi repository untuk mengelola data pengguna.
abstract class UserRepository {
  /// Mengambil seluruh data pengguna.
  Future<List<User>> getUsers();

  /// Mengambil data pengguna berdasarkan ID.
  Future<User> getUserById(int id);
}