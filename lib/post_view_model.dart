// 비지니스 모델은 모두 창고에 넣어야 한다.
// 1. 창고 데이터 (model)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_04/post_repository.dart';
import 'package:flutter_riverpod_04/session_provider.dart';

class PostModel {
  int id;
  int userId;
  String title;

  PostModel(this.id, this.userId, this.title);

  PostModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        userId = json["userId"],
        title = json["title"];
}

// 2. 창고 (view model)
class PostViewModel extends StateNotifier<PostModel?> {
  // 생성자를 통해 상태를 부모에게 전달
  PostViewModel(super.state, this.ref);

  Ref ref;

  // 상태 초기화(필수로 있어야함!)
  void init() async {
    // 통신코드
    PostModel postModel = await PostRepository().fetchPost(40);
    state = postModel;
  }

  // 상태 변경(로그인 상태의 여부에 따라 분기시키기)
  void change() async {
    // ref에 접근하기(창고 관리자를 통해 ref를 넘겨 받아서 접근함)
    SessionUser sessionUser = ref.read(sessionProvider);
    if (sessionUser.isLogin) {
      // 통신코드
      PostModel postModel = await PostRepository().fetchPost(50);
      state = postModel;
    }
  }
}

// 3. 창고 관리자 (provider)
final postProvider =
    StateNotifierProvider.autoDispose<PostViewModel, PostModel?>((ref) {
  return PostViewModel(null, ref)..init();
});
