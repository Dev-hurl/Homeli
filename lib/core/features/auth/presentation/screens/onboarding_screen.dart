import 'package:flutter/material.dart';

class OnboardingSlide {
  final String title;
  final String subtitle;
  final String imagePath;

  const OnboardingSlide({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}

class OnboardingScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingSlide> _slides = [
    OnboardingSlide(
      title: 'Discover Curated Santuaries',
      subtitle: 'Explore hand-selected architectural gems, lofts, and design-forward penthouses vetted for light, proportion, and craftsmanship.',
      imagePath: 'assets/images/onboard1.png',
    ),
    OnboardingSlide(
      title: 'Guided Walkthroughs & Digital Keys',
      subtitle: 'Tour extraordinary spaces in person or via immersive 3D scans. Unlock secure, seamless access with encrypted digital passes.',
      imagePath: 'assets/images/onboard2.png',
    ),
  ];

  Future<void> _goToLogin() async {
    /*await context.read<AuthProvider>().completeOnboarding();
    if (!mounted) return;
    context.go('/signup');
    */
  }

  void _onGetStartedPressed() {
    if (_currentPage == _slides.length - 1) {
      _goToLogin();
      debugPrint('Navigated');
    } else {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose;
    super.dispose();
  }

  void _onSkip() {
    //TODO: fix
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: Container(color: colorScheme.primary),
        title: Text(
          'Homeli',
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.secondaryContainer,
          ),
        ),
        actions: [
          FilledButton(
            onPressed: _onSkip,
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.surfaceContainerHigh,
            ),
            child: Text(
              'Skip',
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.primaryContainer,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _slides.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                final slides = _slides[index];
                return Padding(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 12),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(16),
                          child: Image.asset(
                            slides.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),

                      /*
                      PAge Dots
                      */
                      Text(
                        slides.title,
                        style: textTheme.headlineLarge?.copyWith(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        slides.subtitle,
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _onGetStartedPressed,
                        child: Text(
                          _currentPage == _slides.length - 1
                              ? 'Get Started'
                              : 'Continue',
                          style: textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
