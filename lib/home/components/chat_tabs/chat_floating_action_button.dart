import 'package:bubblez/home/components/group/create_group_add_member.dart';
import 'package:flutter/material.dart';

class CustomChatFloatingActionButton extends StatelessWidget {
  final _selectedTab;

  CustomChatFloatingActionButton(this._selectedTab);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        if (_selectedTab == 1) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatCreateGroupAddMemberScreen()));
        }
      },
      child: Icon(
        _selectedTab == 0 ? Icons.person_add : Icons.group_add,
        color: Colors.white,
      ),
    );
  }
}
