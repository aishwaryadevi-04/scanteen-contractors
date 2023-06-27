import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabChange,
  }) : super(key: key);

  final int selectedIndex;
  final ValueChanged<int> onTabChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      child: SizedBox(
        height: 42,
        child: GNav(
          selectedIndex: selectedIndex,
          onTabChange: (index) {
            onTabChange(index);
            switch (index) {
              case 0:
                 Navigator.of(context).pushNamed('/');
                break;
              case 1:
                Navigator.of(context).pushNamed('/add_item');
                break;
              case 2:
                // Navigator.pushNamed(context, '/contact');
                break;
            }
          },
          backgroundColor: const Color(0xFF17181D),
          color: Colors.white,
          activeColor: const Color(0XFF17181D),
          tabBackgroundColor: const Color(0xFFE09145),
          gap: 8,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.add,
              text: 'Add',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
