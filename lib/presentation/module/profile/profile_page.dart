import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../utils/ui_utils.dart';
import '../../theme/app_color.dart';
import 'profile_provider.dart';

class ProfilePage extends StatefulWidget {
  final Function() onNavigateToAddStory;
  final Function() onNavigateToHome;
  final Function() onLogoutSuccess;

  const ProfilePage({
    super.key,
    required this.onNavigateToAddStory,
    required this.onNavigateToHome,
    required this.onLogoutSuccess,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProfileProvider>().getUserName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          buildBody(),
          buildBottomNav(),
        ],
      ),
    );
  }

  Widget buildBody() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            UIUtils.heightSpace(32),
            Container(
              decoration: const BoxDecoration(
                color: AppColor.neutral100,
                shape: BoxShape.circle,
              ),
              padding: UIUtils.paddingAll(16),
              child: const Icon(
                CupertinoIcons.person_fill,
                color: AppColor.neutral400,
                size: 100,
              ),
            ),
            UIUtils.heightSpace(16),
            Consumer<ProfileProvider>(builder: (context, provider, child) {
              return Text(
                provider.userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              );
            }),
            UIUtils.heightSpace(16),
            TextButton(
              onPressed: () {
                context.read<ProfileProvider>().logout(
                      onSuccess: widget.onLogoutSuccess,
                    );
              },
              child: Text(
                "Logout",
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            UIUtils.heightSpace(75),
          ],
        ),
      ),
    );
  }

  Widget buildBottomNav() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 75,
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.15)),
        padding: UIUtils.paddingAll(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              highlightColor: Colors.white.withOpacity(0.15),
              onPressed: widget.onNavigateToAddStory,
              icon: const Icon(
                CupertinoIcons.camera,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: widget.onNavigateToHome,
              highlightColor: Colors.white.withOpacity(0.15),
              icon: const Icon(
                CupertinoIcons.house,
                color: Colors.white,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              child: const IconButton(
                onPressed: null,
                icon: Icon(
                  CupertinoIcons.person_fill,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
