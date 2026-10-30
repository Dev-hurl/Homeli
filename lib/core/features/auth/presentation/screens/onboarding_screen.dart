import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homeli/core/routing/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingSlide {
  final String title;
  final String subtitle;
  final String imagePath;

  OnboardingSlide({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

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
      imagePath: 'assets/images/elite-prop.jpg',
    ),
    OnboardingSlide(
      title: 'Guided Walkthroughs & Digital Keys',
      subtitle: 'Tour extraordinary spaces in person or via immersive 3D scans. Unlock secure, seamless access with encrypted digital passes.',
      imagePath: 'assets/images/naksha.jpg',
    ),
  ];

  Future<void> _finishOnboarding() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(AppRouter.hasSeenOnboardingPreferenceKey, true);
    if (!mounted) return;
    context.go(AppRouter.roleSetup);
  }

  void _onGetStartedPressed() {
    if (_currentPage == _slides.length - 1) {
      _finishOnboarding();
    } else {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onSkip() {
    _finishOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _slides.length,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (context, index) {
          final slides = _slides[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(slides.imagePath, fit: BoxFit.cover),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x66000000),
                      Color(0x22000000),
                      Color(0xCC000000),
                    ],
                    stops: [0, 0.38, 1],
                  ),
                ),
              ),
              SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/icons/Homeli Logo T Inverted.png',
                                    height: 40,
                                  ),
                                  TextButton(
                                    onPressed: _onSkip,
                                    style: TextButton.styleFrom(
                                      foregroundColor: colorScheme.surface,
                                      backgroundColor: colorScheme.onSurface
                                          .withValues(alpha: 0.7),
                                    ),
                                    child: Text(
                                      'Skip',
                                      style: textTheme.labelMedium?.copyWith(
                                        color: colorScheme.surface,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    slides.title,
                                    textAlign: TextAlign.center,
                                    style: textTheme.headlineLarge?.copyWith(
                                      color: colorScheme.surface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    slides.subtitle,
                                    textAlign: TextAlign.center,
                                    style: textTheme.labelLarge?.copyWith(
                                      color: colorScheme.surface,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      _slides.length,
                                      (dotIndex) => AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        height: 8,
                                        width: dotIndex == _currentPage
                                            ? 24
                                            : 8,
                                        decoration: BoxDecoration(
                                          color: dotIndex == _currentPage
                                              ? colorScheme.surface
                                              : colorScheme.onSurface,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: _onGetStartedPressed,
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      minimumSize: const Size(
                                        double.infinity,
                                        52,
                                      ),
                                      backgroundColor: colorScheme.primary,
                                    ),
                                    child: Text(
                                      _currentPage == _slides.length - 1
                                          ? 'Get Started'
                                          : 'Continue',
                                      style: textTheme.labelLarge?.copyWith(
                                        color: colorScheme.surface,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
