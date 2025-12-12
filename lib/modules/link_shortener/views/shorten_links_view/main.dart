import 'package:flutter/material.dart';

class ShortenLinksView extends StatefulWidget {
  const ShortenLinksView({super.key});

  @override
  State<ShortenLinksView> createState() => _ShortenLinksViewState();
}

class _ShortenLinksViewState extends State<ShortenLinksView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shorten Links')),
      body: const Center(child: Text('Shorten Links')),
    );
  }
}
