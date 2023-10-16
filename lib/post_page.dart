import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_04/post_view_model.dart';
import 'package:flutter_riverpod_04/session_provider.dart';

class PostPage extends ConsumerWidget {
  PostPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("나 빌드됨");
    PostModel? model = ref.watch(postProvider); // 최초에 nill이 들어올 수 있기 때문에 ? 붙이기
    if (model == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        body: Column(
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.network(
                "https://picsum.photos/id/50/200/200",
                fit: BoxFit.cover,
              ),
            ),
            Text(
                "id : ${model.id}, userId : ${model.userId}, title : ${model.title}"),
            ElevatedButton(
                onPressed: () {
                  ref.read(postProvider.notifier).change(); // 값 변경하기
                },
                child: Text("값변경")),
            ElevatedButton(
                onPressed: () {
                  SessionUser sessionUser = ref.read(sessionProvider); // 값 변경하기
                  sessionUser.isLogin = true;
                },
                child: Text("로그인")),
          ],
        ),
      );
    }
  }
}
