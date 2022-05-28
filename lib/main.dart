import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/studypage.dart';
import 'pages/editpage.dart';

void main() {
  runApp(const ProviderScope(child: MainPage()));
}

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Interval Learning App - Tab: ${controller.index}'),
            centerTitle: true,
            bottom: TabBar(
              controller: controller,
              tabs: [
                Tab(icon: Icon(Icons.edit), text: 'Bearbeitungsmodus'),
                Tab(icon: Icon(Icons.poll), text: 'Lernmodus'),
              ],
            ),
          ),
          body: TabBarView(
            controller: controller,
            children: [
              EditPage(),
              StudyPage(),
            ],
          ),
        ),
      );
}
