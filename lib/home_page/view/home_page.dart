import 'package:flutter/material.dart';
import 'package:transactions/home_page/view/diagram_page.dart';
import 'package:transactions/home_page/view/list_view_page.dart';
import 'package:transactions/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [
    const ListViewPage(),
    const DiagramPage(),
  ];

  int currentNavBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_sharp),
            label: 'Diagram',
          ),
        ],
        currentIndex: currentNavBarIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        onTap: (index) {
          setState(() {
            currentNavBarIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: currentNavBarIndex,
        children: [..._pages],
      ),
    );
  }
}
