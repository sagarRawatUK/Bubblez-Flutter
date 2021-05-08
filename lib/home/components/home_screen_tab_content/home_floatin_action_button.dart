import 'package:bubblez/home/components/post/text_post.dart';
import 'package:bubblez/home/components/postOperations/uploadPost.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CustomHomeFloatingActionButton extends StatefulWidget {
  Function _updateBottomSheetInstance;

  CustomHomeFloatingActionButton(this._updateBottomSheetInstance);

  @override
  _CustomHomeFloatingActionButtonState createState() =>
      _CustomHomeFloatingActionButtonState();
}

class _CustomHomeFloatingActionButtonState
    extends State<CustomHomeFloatingActionButton> {
  bool _isSheetOpen;

  @override
  void initState() {
    super.initState();
    _isSheetOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          _isSheetOpen = !_isSheetOpen;
        });
        if (_isSheetOpen) {
          var _bottomSheetController = showBottomSheet(
            context: context,
            builder: (context) => Container(
              height: 70,
              color: theme.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<UploadPost>(context, listen: false)
                          .pickUploadPostImage(context, ImageSource.camera);
                    },
                    child: Icon(Icons.camera_alt),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<UploadPost>(context, listen: false)
                          .pickUploadPostImage(context, ImageSource.camera);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.video,
                      size: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<UploadPost>(context, listen: false)
                          .pickUploadPostImage(context, ImageSource.gallery);
                    },
                    child: Icon(Icons.image),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TextPostScreen()));
                    },
                    child: Icon(Icons.text_format),
                  ),
                ],
              ),
            ),
          );
          widget._updateBottomSheetInstance(_bottomSheetController);
          _bottomSheetController.closed.then((value) {
            setState(() {
              _isSheetOpen = !_isSheetOpen;
            });
            widget._updateBottomSheetInstance(null);
          });
        } else {
          Navigator.pop(context);
          setState(() {
            _isSheetOpen = !_isSheetOpen;
          });
        }
      },
      backgroundColor: _isSheetOpen ? white : theme.primaryColor,
      child: _isSheetOpen
          ? Icon(
              Icons.close,
              size: 30,
              color: theme.primaryColor,
            )
          : Icon(
              Icons.add,
              size: 30,
              color: white,
            ),
    );
  }
}
