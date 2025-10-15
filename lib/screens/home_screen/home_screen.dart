import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hasper_ebook/utils/search.dart';

import '../../components/drawer.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: SvgPicture.asset('assets/icons/menu.svg',
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)),
              splashRadius: 22,
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
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
      body: HomeScreenBody(),
    );
  }
}
