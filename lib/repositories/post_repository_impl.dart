
import '../models/post.dart';
import '../services/api_service.dart';
import 'post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final ApiService _apiService;

  PostRepositoryImpl({
    required this._apiService,
  });

  @override
  Future<List<Post>> getPosts() {
    return _apiService.getPosts();
  }
}
