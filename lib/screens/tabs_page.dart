import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manoo/constant/color.dart';
import 'package:manoo/constant/text_style.dart';
import 'package:manoo/services/auth_methods.dart';
import 'package:manoo/widgets/tab_bar.dart';
import 'all_posts_screen.dart';
import 'user_posts_screen.dart';

class TabsPage extends StatefulWidget {


  const TabsPage({Key? key, }) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: primary,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  AuthMethods().signOut();
                },
                icon: Icon(Icons.exit_to_app_rounded)
            ),
            toolbarHeight: 60,
            elevation: 0,
            backgroundColor: primary,
            automaticallyImplyLeading: true,
            centerTitle: true,

            title: const TabBar(
                isScrollable: true,
                physics: PageScrollPhysics(),
                indicatorWeight: 4,
                indicatorColor: primaryLight,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: style1,
                labelColor: white,
                unselectedLabelColor: white,
                tabs: [
                  BuildTabBar(title: "My Posts"),
                  BuildTabBar(title: "All Posts")
                ]
            ),
          ),
          body:  const TabBarView(
            children: [
              UserPosts(),
              AllPosts()
            ],
          ),
        )
    );
  }

}



