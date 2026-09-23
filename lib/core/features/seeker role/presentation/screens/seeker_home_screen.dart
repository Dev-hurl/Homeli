import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homeli/core/features/seeker%20role/models/featured_card_data.dart';
import 'package:homeli/core/features/seeker%20role/models/nearby_residences_data.dart';
import 'package:homeli/core/features/seeker%20role/presentation/widgets/nearby_residences_card.dart';
import 'package:homeli/core/features/seeker%20role/presentation/widgets/featured_card.dart';
import 'package:homeli/core/routing/app_router.dart';
import 'package:hugeicons/hugeicons.dart';

enum ApartmentType { rent, sale }

class SeekerHomeScreen extends StatefulWidget {
  final String firstName;
  const SeekerHomeScreen({super.key, required this.firstName});

  @override
  State<SeekerHomeScreen> createState() => _SeekerHomeScreenState();
}

class _SeekerHomeScreenState extends State<SeekerHomeScreen> {
  final String _imagePath = 'assets/images/avatar.png';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 24),
        leading: Image.asset(
          'assets/icons/Homeli Logo T Inverted.png',
          width: 40,
          height: 40,
        ),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRouter.notifications),
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedNotification01,
              size: 22,
              strokeWidth: 2,
            ),
          ),
          SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              context.push(AppRouter.seekerProfile);
            },
            child: CircleAvatar(
              radius: 24,
              child: _imagePath.isNotEmpty
                  ? Image.asset(_imagePath, fit: BoxFit.cover,)
                  : HugeIcon(
                      icon: HugeIcons.strokeRoundedUser02,
                      size: 22,
                      strokeWidth: 2,
                    ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: colorScheme.surfaceContainerHigh,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 6,
                        children: [
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedLocation09,
                            color: colorScheme.secondaryContainer,
                          ),
                          Text(
                            'Nigeria,IB',
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              //
                            },
                            child: HugeIcon(
                              icon: HugeIcons.strokeRoundedArrowDown01,
                              strokeWidth: 2,
                              color: colorScheme.secondaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning ${widget.firstName}',
                    style: textTheme.bodyMedium?.copyWith(),
                  ),
                  Text(
                    'Find your perfect place',
                    style: textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SearchBar(
                //padding: WidgetStateProperty.all(horizontal:2),
                keyboardType: TextInputType.text,
                backgroundColor: WidgetStateProperty.all(colorScheme.surface),
                elevation: WidgetStateProperty.all(0),
                leading: HugeIcon(
                  icon: HugeIcons.strokeRoundedSearch02,
                  strokeWidth: 2,
                  color: colorScheme.secondary,
                ),
                trailing: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: colorScheme.secondary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: IconButton(
                      onPressed: () {
                        context.push(AppRouter.seekerSearchFilters);
                      },
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedPreferenceHorizontal,
                        color: colorScheme.surface,
                        strokeWidth: 1.5,
                        size: 20,
                      ),
                    ),
                  ),
                ],
                hintText: 'Search city, neighbourhood, villa',
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Selection',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.secondaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.primaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ...featureCard.map(
                (feature) => Padding(
                  padding: EdgeInsetsGeometry.only(bottom: 12),
                  child: FeaturedCard(featuredCard: feature),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nearby Residences',
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.secondaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Curated spots within 2 miles of you',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.secondaryContainer,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: IconButton(
                      onPressed: () {
                        context.push(AppRouter.seekerSearchFilters);
                      },
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedPreferenceHorizontal,
                        color: colorScheme.secondaryContainer,
                        strokeWidth: 1.5,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              ...nearbyProperty.map(
                (property) => Padding(
                  padding: EdgeInsetsGeometry.only(bottom: 12),
                  child: NearbyResidencesCard(nearbyResidences: property),
                ),
              ),
              // Grid alternative: comment out the list above and uncomment this.
              // SizedBox(
              //   height: 520,
              //   child: GridView.builder(
              //     physics: NeverScrollableScrollPhysics(),
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       crossAxisSpacing: 12,
              //       mainAxisSpacing: 12,
              //       childAspectRatio: 0.72,
              //     ),
              //     itemCount: nearbyProperty.length,
              //     itemBuilder: (context, index) {
              //       return NearbyResidencesCard(
              //         nearbyResidences: nearbyProperty[index],
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
