import 'package:flutter/material.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'https://cdn-icons-png.flaticon.com/512/706/706164.png',
      'title': 'Welcome',
      'subtitle': 'Forgot to bring your wallet when shopping?',
      'button': 'Continue'
    },
    {
      'image': 'https://cdn-icons-png.flaticon.com/512/201/201623.png',
      'title': 'Welcome',
      'subtitle': "Use Walle instead of cash!",
      'button': 'Continue'
    },
    {
      'image': 'https://cdn-icons-png.flaticon.com/512/7018/7018973.png',
      'title': 'Welcome',
      'subtitle': "Let's try Walle now!",
      'button': 'Get Started'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final item = onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.3,
                          child:
                              Image.network(item['image']!, fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          item['title']!,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['subtitle']!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            if (_currentPage < onboardingData.length - 1) {
                              _controller.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Terima kasih ${MyApp.fullName}! UAS kamu sudah selesai 😄'),
                                ),
                              );
                            }
                          },
                          child: Text(item['button']!),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(onboardingData.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? colorScheme.primary
                        : colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Text(MyApp.nim),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
