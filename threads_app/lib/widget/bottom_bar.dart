import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:threads_app/features/home/home.dart';
import 'package:threads_app/features/home/profile.dart';
import 'package:threads_app/features/posts/create_post.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final pages = [
    const HomePage(),
    Container(
      color: Colors.red,
      child: const Center(
        child: Text('Search'),
      ),
    ),
   const CreatePostPage(),
    Container(
      color: Colors.yellow,
      child: const Center(
        child: Text('Notifications'),
      ),
    ),
    const ProfilePage(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
