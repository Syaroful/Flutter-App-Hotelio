import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelio/config/app_asset.dart';
import 'package:hotelio/config/app_color.dart';
import 'package:hotelio/page/history_page.dart';
import 'package:hotelio/page/nearby_page.dart';

import '../controller/c_home.dart';
import '../widget/coming_soon.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final cHome = Get.put(CHome());
  final List<Map> listNav = [
    // icon nearby
    {'icon': AppAsset.iconNearby, 'label': 'Nearby'},
    // icon history
    {'icon': AppAsset.iconHistory, 'label': 'History'},
    // icon Payment
    {'icon': AppAsset.iconPayment, 'label': 'Payment'},
    // icon Reward
    {'icon': AppAsset.iconReward, 'label': 'Reward'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (cHome.indexPage == 0) {
          return NearbyPage();
        }
        if (cHome.indexPage == 1) {
          return const HistoryPage();
        }
        return const ComingSoon();
      }),
      bottomNavigationBar: Obx(() {
        return Material(
          elevation: 8,
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.only(top: 8, bottom: 6),
            child: BottomNavigationBar(
              currentIndex: cHome.indexPage,
              onTap: (value) => cHome.indexPage = value,
              elevation: 0,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              // 'fixed' unutk memunculkan label dari semua icon
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.white,
              selectedIconTheme: const IconThemeData(
                color: AppColor.primary,
              ),
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              selectedFontSize: 12,
              items: listNav.map((e) {
                return BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(e['icon'])),
                  label: e['label'],
                );
              }).toList(),
            ),
          ),
        );
      }),
    );
  }
}
