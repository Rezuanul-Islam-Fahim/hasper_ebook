import 'package:flutter/material.dart';
import 'package:hasper_ebook/screens/all_book_screen/all_book_screen.dart';
import 'package:hasper_ebook/screens/home_screen/home_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: 160,
            color: Color(0xFF1d212b),
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'HASPER E-BOOK',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Read Books Online',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          _buildTileItem(
            context,
            Icons.home_rounded,
            'Home',
            HomeScreen.routeName,
          ),
          _buildTileItem(
            context,
            Icons.book,
            'All Books',
            AllBookScreen.routeName,
          ),
        ],
      ),
    );
  }

  ListTile _buildTileItem(
    BuildContext context,
    IconData icon,
    String title,
    String routeName,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(routeName);
      },
    );
  }
}
