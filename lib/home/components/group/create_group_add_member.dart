import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bubblez/home/components/chat_tabs/chat_group_tab_screen.dart';
import 'package:bubblez/home/components/group/group_info_edit.dart';
import 'package:bubblez/style/colors.dart';
import 'package:flutter/material.dart';

class ChatCreateGroupAddMemberScreen extends StatefulWidget {
  @override
  _ChatCreateGroupAddMemberScreenState createState() =>
      _ChatCreateGroupAddMemberScreenState();
}

class GroupItems {
  String image;
  String name;

  GroupItems(this.image, this.name);
}

class _ChatCreateGroupAddMemberScreenState
    extends State<ChatCreateGroupAddMemberScreen> {
  final List<String> _selectedMember = [];

  @override
  Widget build(BuildContext context) {
    List<GroupItems> _groupItems = [
      GroupItems('assets/images/Layer707.png', 'Emili Williamson'),
      GroupItems('assets/images/Layer709.png', 'Harshu Makkar'),
      GroupItems('assets/images/Layer948.png', 'Mrs. White'),
      GroupItems('assets/images/Layer884.png', 'Marie Black'),
      GroupItems('assets/images/Layer915.png', 'Emili Williamson'),
      GroupItems('assets/images/Layer946.png', 'Emili Williamson'),
      GroupItems('assets/images/Layer948.png', 'Emili Williamson'),
      GroupItems('assets/images/Layer949.png', 'Emili Williamson'),
      GroupItems('assets/images/Layer950.png', 'Emili Williamson'),
    ];
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final myAppBar = AppBar(
      backgroundColor: white,
      title: Text(
        'Select Members',
        style: theme.textTheme.headline6
            .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      actions: [
        Icon(Icons.search),
        SizedBox(
          width: 10,
        ),
      ],
      leading: Icon(Icons.chevron_left),
    );
    final bHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppBar.preferredSize.height;
    return Scaffold(
      appBar: myAppBar,
      body: FadedSlideAnimation(
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: _selectedMember.length == 0
                      ? bHeight * 0.9
                      : bHeight * 0.8108,
                  child: ListView.builder(
                    itemCount: _groupItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(_groupItems[index].image),
                        ),
                        title: Text(_groupItems[index].name),
                        subtitle: Text("iamaronsmith"),
                        trailing: Checkbox(
                          value: _selectedMember
                              .contains("iamaronsmith" + '$index'),
                          onChanged: (val) {
                            setState(() {
                              if (val) {
                                _selectedMember.add("iamaronsmith" + '$index');
                              } else {
                                _selectedMember
                                    .remove("iamaronsmith" + '$index');
                              }
                            });
                            print(_selectedMember);
                          },
                          key: ValueKey('$index'),
                          activeColor: theme.primaryColor,
                        ),
                      );
                    },
                  ),
                ),
                if (_selectedMember.length == 0)
                  Container()
                else
                  Container(
                    height: 60,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _selectedMember.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Stack(
                              children: [
                                FadedScaleAnimation(
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        AssetImage(_groupItems[index].image),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: theme.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      size: 17,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                          ],
                        );
                      },
                    ),
                  ),
                GestureDetector(
                  onTap: _selectedMember.length == 0
                      ? null
                      : () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatGroupTabScreen()));
                        },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _selectedMember.length == 0
                          ? grey
                          : theme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "next",
                      style: theme.textTheme.button,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
