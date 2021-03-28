import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/home/components/post/create_post.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';

class UploadGalleryTab extends StatelessWidget {
  final List<String> imagesList = [
    'Layer946',
    'Layer947',
    'Layer948',
    'Layer949',
    'Layer950',
    'Layer951',
    'Layer971',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: FadedSlideAnimation(
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
          ),
          itemCount: 30,
          itemBuilder: (context, index) {
            int num = index % imagesList.length;
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreatePostScreen()));
              },
              child: Image.asset('assets/images/${imagesList[num]}.png'),
            );
          },
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
