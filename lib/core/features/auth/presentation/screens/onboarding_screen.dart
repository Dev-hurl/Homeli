import 'package:flutter/material.dart';
import 'package:homeli/core/features/auth/presentation/screens/role_setup_screen.dart';

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
      imagePath: 'assets/images/onboard1.png',
    ),
    OnboardingSlide(
      title: 'Guided Walkthroughs & Digital Keys',
      subtitle: 'Tour extraordinary spaces in person or via immersive 3D scans. Unlock secure, seamless access with encrypted digital passes.',
      imagePath: 'assets/images/onboard2.png',
    ),
  ];

  void _finishOnboarding() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => RoleSetupScreen()),
    );
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
      appBar: AppBar(
        leading: Image.asset('assets/icons/Homeli Logo Inverted.png'),
        
        actions: [
          FilledButton(
            onPressed: _onSkip,
            style: FilledButton.styleFrom(
              elevation: 0,
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
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final slides = _slides[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              slides.imagePath,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _slides.length,
                            (dotIndex) => AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              height: 8,
                              width: dotIndex == _currentPage ? 24 : 8,
                              decoration: BoxDecoration(
                                color: dotIndex == _currentPage
                                    ? colorScheme.primary
                                    : colorScheme.surfaceContainerHigh,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          slides.title,
                          textAlign: TextAlign.center,
                          style: textTheme.headlineLarge?.copyWith(
                            color: colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          slides.subtitle,
                          textAlign: TextAlign.center,
                          style: textTheme.labelLarge?.copyWith(
                            color: colorScheme.secondary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _onGetStartedPressed,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: colorScheme.primary,
                            ),
                            child: Text(
                              _currentPage == _slides.length - 1
                                  ? 'Get Started'
                                  : 'Continue',
                              style: textTheme.labelLarge?.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
