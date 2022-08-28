import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TabsPage extends StatefulWidget {
  final FirebaseAnalyticsObserver observer;
  const TabsPage({Key? key, required this.observer}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState(observer);
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin {
  final FirebaseAnalyticsObserver observer;
  _TabsPageState(this.observer);
  late TabController _controller;
  int seletedIndex = 0;
  final List<Tab> tabs = <Tab>[
    const Tab(
      text: '1번',
      icon: Icon(Icons.looks_one),
    ),
    const Tab(
      text: '2번',
      icon: Icon(Icons.looks_two),
    ),
  ];
  @override
  void initState() {
    super.initState();
    _controller = TabController(
        length: tabs.length, vsync: this, initialIndex: seletedIndex);
    _controller.addListener(() {
      setState(() {
        if (seletedIndex != _controller.index) {
          seletedIndex = _controller.index;
          _sendCurrentTab();
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // observer.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    // observer.unsubscribe(this);
    super.dispose();
  }

  void _sendCurrentTab() {
    observer.analytics.setCurrentScreen(
      screenName: 'tab/$seletedIndex',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _controller,
          tabs: tabs,
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: tabs.map((Tab tab) {
          return Center(child: Text(tab.text!));
        }).toList(),
      ),
    );
  }
}
