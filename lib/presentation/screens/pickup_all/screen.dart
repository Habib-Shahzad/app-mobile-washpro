import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PickUpAllScreen extends StatelessWidget {
  const PickUpAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Forgot Password')),
        body: const Column(children: [
          Text('Forgot Password Screen'),
        ]));
  }
}
