import 'package:flutter/material.dart';
import 'package:animated_dropdown_button/animated_dropdown_button.dart';

class AnimatedSearchBoxWidget extends StatefulWidget {
  const AnimatedSearchBoxWidget({super.key});

  @override
  State<AnimatedSearchBoxWidget> createState() =>
      _AnimatedSearchBoxWidgetState();
}

class TitleModel extends AnimatedDropdownItem {
  final String name;
  TitleModel(this.name);
  @override
  String get text => name;
  @override
  String get value => name;
}

class _AnimatedSearchBoxWidgetState extends State<AnimatedSearchBoxWidget> {
  late final AnimatedSearchBoxController animatedSearchController;
  final AnimatedDropdownButtonController animalsController =
      AnimatedDropdownButtonController(
    items: [
      "Flutter Agency",
      "Introduction to Flutter",
      "Flutter Widgets",
      "State Management",
    ],
    initialValue: "Flutter Agency",
  );

  @override
  void initState() {
    super.initState();
    animatedSearchController = AnimatedSearchBoxController(
      items: animals,
      initialValue: TitleModel(
        'Flutter Agency',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Column(
          children: [
            Text(
              'Flutter Agency',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 165, 149, 149),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Animated Search Box',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    AnimatedSearchBox(
                      width: 336,
                      controller: animatedSearchController,
                      backgroundColor: Colors.white,
                      hintText: 'Type an Topic name',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 200,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ANIMATED DROPDOWN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    AnimatedDropdownButton(
                      controller: animalsController,
                      backgroundColor: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final List<TitleModel> animals = [
  TitleModel("Flutter Agency"),
  TitleModel("State Management"),
  TitleModel("Flutter Widgets"),
  TitleModel("Introduction to Flutter"),
  TitleModel("Creating Beautiful UIs with Flutter Widgets"),
  TitleModel("State Management in Flutter Apps"),
  TitleModel("Flutter Navigation and Routing Techniques"),
  TitleModel("Flutter Animation and Customization Tips"),
];
