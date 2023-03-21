// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:upwork/pages/pages.dart';
import 'package:upwork/theme.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('PROPOSALS');

  final pages = const [
    JobsPage(),
    ProposalsPage(),
    MessagesPage(),
    NotificationsPage(),
    ProfilePage(),
  ];

  final pageTitles = const [
    'Jobs',
    'Proposals',
    'Messages',
    'Notifications',
    'Profile',
  ];

  void _onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _) {
            return Text(value);
          },
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavigationBarItem(
            index: 0,
            lable: 'JOBS',
            icon: FontAwesomeIcons.briefcase,
            isSelected: (selectedIndex == 0),
            onTap: handleItemSelected,
          ),
          _NavigationBarItem(
            index: 1,
            lable: 'PROPOSALS',
            icon: FontAwesomeIcons.fileCirclePlus,
            isSelected: (selectedIndex == 1),
            onTap: handleItemSelected,
          ),
          _NavigationBarItem(
            index: 2,
            lable: 'MESSAGES',
            icon: FontAwesomeIcons.solidMessage,
            isSelected: (selectedIndex == 2),
            onTap: handleItemSelected,
          ),
          _NavigationBarItem(
            index: 3,
            lable: 'NOTIFICATIONS',
            icon: FontAwesomeIcons.solidBell,
            isSelected: (selectedIndex == 3),
            onTap: handleItemSelected,
          ),
          _NavigationBarItem(
            index: 4,
            lable: 'PROFILE',
            icon: FontAwesomeIcons.userLarge,
            isSelected: (selectedIndex == 4),
            onTap: handleItemSelected,
          ),
        ],
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  _NavigationBarItem({
    Key? key,
    required this.index,
    required this.lable,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  final int index;
  final String lable;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              lable,
              style: isSelected
                  ? const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    )
                  : const TextStyle(fontSize: 8),
            ),
          ],
        ),
      ),
    );
  }
}
