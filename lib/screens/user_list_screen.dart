import 'package:flutter/material.dart';

import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import '../widgets/user_card.dart';

/// Halaman untuk menampilkan daftar pengguna.
class UserListScreen extends StatefulWidget {
  final UserRepository? repository;

  const UserListScreen({
    super.key,
    this.repository,
  });

  @override
  State<UserListScreen> createState() =>
      _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late final UserRepository _repository;

  List<User> _users = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _repository = widget.repository ?? UserRepositoryImpl();

    _loadUsers();
  }

  /// Memuat data pengguna dari repository.
  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final users = await _repository.getUsers();

      if (!mounted) return;

      setState(() {
        _users = users;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pengguna'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage!),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _loadUsers,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (_users.isEmpty) {
      return const Center(
        child: Text('Tidak ada data pengguna'),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadUsers,
      child: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];

          return UserCard(
            user: user,
            onTap: () => _showUserDetail(user),
          );
        },
      ),
    );
  }

  /// Menampilkan detail pengguna.
  void _showUserDetail(User user) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Username: ${user.username}'),
              Text('Email: ${user.email}'),
              Text('Telepon: ${user.phone}'),
              Text('Website: ${user.website}'),
              Text('Perusahaan: ${user.companyName}'),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}