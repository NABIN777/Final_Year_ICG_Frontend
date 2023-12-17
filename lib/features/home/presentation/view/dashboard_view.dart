import 'package:flutter/material.dart';
import 'package:imagecaptiongenerator/features/home/presentation/view/home.dart';
import 'package:imagecaptiongenerator/features/home/presentation/view/setting.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../config/routers/app_route.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  void openSoundSettings() async {
    const url = 'app-settings:sound';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      print('Could not open sound settings.');
    }
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    }
    if (hour < 17) {
      return 'Good afternoon';
    }
    return 'Good Evening';
  }

  int selectedIndex = 0;
  // final int _selectedIndex = 0;
  List<Widget> lstBottomScreen = [const HomeView(), const SettingView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: selectedIndex == 0
          ? AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo.png'),
                    radius: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(greeting()),
                ],
              ),
              centerTitle: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.notification_important_outlined,
                      color: Colors.white),
                  onPressed: () {
                    // Navigator.pushNamed(context, AppRoute.detailRoute);
                    openSoundSettings();
                    const Text('put phone in silent mode');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.searchRoute);
                    const Text('Search');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.settingRoute);
                    const Text('Settings');
                  },
                ),
              ],
            )
          : null,
      body: lstBottomScreen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_applications),
            label: 'Setting',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
