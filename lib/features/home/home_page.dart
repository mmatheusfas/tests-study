import 'package:flutter/material.dart';
import 'package:tests_study/features/home/home_controller.dart';
import 'package:tests_study/repositories/advice/advice_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.adviceRepository});

  final AdviceRepository adviceRepository;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _homeController;

  @override
  void initState() {
    super.initState();
    _homeController = HomeController(widget.adviceRepository);
    _homeController.getArticle();
  }

  @override
  void dispose() {
    _homeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('Advice of the day'),
      ),
      body: ListenableBuilder(
        listenable: _homeController,
        builder: (_, __) {
          return Padding(
            padding: const EdgeInsets.all(64.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _homeController.isLoading ? const CircularProgressIndicator() : Text(_homeController.advice),
                  const Spacer(),
                  OutlinedButton(
                    key: const Key('New Advice Button'),
                    onPressed: _homeController.getArticle,
                    child: const Text('New advice'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
