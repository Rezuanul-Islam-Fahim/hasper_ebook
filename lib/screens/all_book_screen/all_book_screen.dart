import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hasper_ebook/components/drawer.dart';
import 'package:hasper_ebook/screens/all_book_screen/components/body.dart';
import 'package:hasper_ebook/styles.dart';
import 'package:hasper_ebook/utils/search.dart';

class AllBookScreen extends StatelessWidget {
  static const String routeName = '/all-book';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: SvgPicture.asset(
                'assets/icons/menu.svg',
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              splashRadius: 22,
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        centerTitle: true,
        title: Text('All Books', style: appBarTitle()),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            splashRadius: 22,
            onPressed: () => showSearch(
              context: context,
              delegate: Search(),
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: AllBookScreenBody(),
    );
  }
}
