import 'package:flutter/material.dart';
import 'package:lionsbotremotecontroller/models/user_model.dart';
import 'package:lionsbotremotecontroller/pages/profile_screen.dart';
import 'package:lionsbotremotecontroller/pages/remote_controll_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/homeScreen';
  const HomeScreen({super.key, this.loggedUserDetails});
  final UserModel? loggedUserDetails;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late UserModel? _loggedUserDetails;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.index = 0;
    _loggedUserDetails = widget.loggedUserDetails!;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            ProfileScreen(userDetails: _loggedUserDetails),
            const Center(
              child: Text("Messages screen"),
            ),
            const SizedBox(),
            const Center(
              child: Text("Settings screen"),
            ),
            const SizedBox(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          padding: const EdgeInsets.only(top: 75),
          child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.blue,
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Image.asset(
                      'assets/robot-head-1-48.png',
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                    ),
                  ))),
        ),
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelStyle: const TextStyle(fontSize: 13),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            labelColor: Colors.blue,
            unselectedLabelColor: const Color.fromARGB(255, 0, 129, 201),
            labelPadding: EdgeInsets.zero,
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            onTap: (index) {
              if (index == 4) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) {
                    return const RemoteControllScreen();
                  },
                ));
                _tabController.index = 0;
              }
            },
            tabs: const <Widget>[
              Tab(
                iconMargin: EdgeInsets.only(bottom: 5),
                icon: Icon(
                  Icons.account_circle_outlined,
                  size: 30,
                ),
                text: 'Profile',
              ),
              Tab(
                iconMargin: EdgeInsets.only(bottom: 5),
                icon: Icon(
                  Icons.messenger_outline_rounded,
                  size: 30,
                ),
                text: 'Messages',
              ),
              SizedBox(),
              Tab(
                iconMargin: EdgeInsets.only(bottom: 5),
                icon: Icon(
                  Icons.settings_outlined,
                  size: 30,
                ),
                text: 'Settings',
              ),
              Tab(
                iconMargin: EdgeInsets.only(bottom: 5),
                icon: Icon(
                  Icons.settings_remote_outlined,
                  size: 30,
                ),
                text: 'Remote',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
