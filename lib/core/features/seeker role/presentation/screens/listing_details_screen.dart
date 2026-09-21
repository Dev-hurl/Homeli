import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homeli/core/features/seeker%20role/models/listing_detail_model.dart';
import 'package:homeli/core/features/shared/widgets/circle_icon_button.dart';
import 'package:hugeicons/hugeicons.dart';

final listingDetailData = ListingDetailModel(
  imagePaths: List.filled(5, 'assets/images/elite-prop.jpg'),
  statusLabel: 'For Rent',
  rating: 4.96,
  reviewCount: 48,
  title: 'The Glass Pavilion, Soho',
  address: '32 W Mercer St, Soho, Manhattan, NY',
  price: '\$3,850',
  moveInStatus: 'Immediate Move-in',
  quickFeatures: ['3 Beds', '2 Baths', '1,800 sq ft'],
  hostName: 'Larry Cho',
  hostImagePath: 'assets/images/avatar.png',
  hostResponseTime: 'Responds in < 15 mins',
  description: 'Experience refined urban elegance in this thoughtfully customized modern sanctuary. Soaring ceilings and floor-to-ceiling acoustic glass frame the city skyline, while the private courtyard pool offers a rare moment of stillness in Soho.',
  amenities: [
    AmenityItem(
      icon: HugeIcons.strokeRoundedRuler,
      label: 'Architectural Design',
    ),
    AmenityItem(
      icon: HugeIcons.strokeRoundedSquareLock02,
      label: 'Private Courtyard',
    ),
    AmenityItem(icon: HugeIcons.strokeRoundedCall02, label: 'Concierge 24/7'),
    AmenityItem(icon: HugeIcons.strokeRoundedWifi01, label: 'High-speed Fiber'),
    AmenityItem(
      icon: HugeIcons.strokeRoundedKey01,
      label: 'Smart Keyless Entry',
    ),
    AmenityItem(
      icon: HugeIcons.strokeRoundedCar01,
      label: 'Dedicated EV Charging',
    ),
  ],
  totalAmenitiesCount: 24,
  transitScore: '99/100',
  neighborhoodName: 'SoHo Cast-Iron District',
  neighborhoodDescription: 'Quiet cobblestone corridor near Mercer & Prince',
);

class ListingDetailScreen extends StatefulWidget {
  final ListingDetailModel listing;
  const ListingDetailScreen({super.key, required this.listing});

  @override
  State<ListingDetailScreen> createState() => _ListingDetailScreenState();
}

class _ListingDetailScreenState extends State<ListingDetailScreen> {
  final _pageController = PageController();
  int _currentImageIndex = 0;
  bool _isFavorited = true;
  bool _isDescriptionExpanded = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final listing = widget.listing;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 280,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: listing.imagePaths.length,
                    onPageChanged: (index) =>
                        setState(() => _currentImageIndex = index),
                    itemBuilder: (context, index) => Image.asset(
                      listing.imagePaths[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: CircleIconButton(
                    icon: HugeIcons.strokeRoundedArrowLeft01,
                    onTap: () => context.pop(),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Row(
                    children: [
                      CircleIconButton(
                        icon: HugeIcons.strokeRoundedShare08,
                        onTap: () {},
                      ),
                      SizedBox(width: 8),
                      CircleIconButton(
                        icon: HugeIcons.strokeRoundedFavourite,
                        iconColor: _isFavorited ? colorScheme.primary : colorScheme.secondary,
                        backgroundColor: colorScheme.surface,
                        onTap: () =>
                            setState(() => _isFavorited = !_isFavorited),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedVideoReplay,
                          size: 14,
                          color: colorScheme.primary,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Virtual Walkthrough',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_currentImageIndex + 1}/${listing.imagePaths.length}',
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.surface,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 64,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                scrollDirection: Axis.horizontal,
                itemCount: listing.imagePaths.length > 4
                    ? 4
                    : listing.imagePaths.length,
                separatorBuilder: (_, _) => SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isLast = index == 3 && listing.imagePaths.length > 4;
                  final selected = index == _currentImageIndex;
                  return GestureDetector(
                    onTap: () => _pageController.animateToPage(
                      index,
                      duration: Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selected
                                    ? colorScheme.secondaryContainer
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Image.asset(
                              listing.imagePaths[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (isLast)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '+${listing.imagePaths.length - 4}',
                                style: textTheme.labelMedium?.copyWith(
                                  color: colorScheme.surface,
                                  fontWeight: FontWeight.w700,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          listing.statusLabel,
                          style: textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, size: 14, color: Colors.amber),
                          SizedBox(width: 4),
                          Text(
                            '${listing.rating} (${listing.reviewCount} reviews)',
                            style: textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    listing.title,
                    style: textTheme.headlineMedium?.copyWith(
                      color: colorScheme.secondaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedLocation09,
                        size: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          listing.address,
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'MONTHLY LEASE',
                                style: textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                              SizedBox(height: 4),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: listing.price,
                                      style: textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' / mo',
                                      style: textTheme.labelMedium?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.bolt, size: 14),
                              SizedBox(width: 4),
                              Text(
                                listing.moveInStatus,
                                style: textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: listing.quickFeatures.length,
                      separatorBuilder: (_, _) => SizedBox(width: 8),
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          listing.quickFeatures[index],
                          style: textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: AssetImage(listing.hostImagePath),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listing.hostName,
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    listing.hostResponseTime,
                                    style: textTheme.labelSmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        CircleIconButton(
                          icon: HugeIcons.strokeRoundedCall02,
                          onTap: () {},
                        ),
                        SizedBox(width: 8),
                        CircleIconButton(
                          icon: HugeIcons.strokeRoundedMessage01,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'About this Sanctuary',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'OVERVIEW',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    listing.description,
                    maxLines: _isDescriptionExpanded ? null : 2,
                    overflow: _isDescriptionExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(
                      () => _isDescriptionExpanded = !_isDescriptionExpanded,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        _isDescriptionExpanded ? 'Show less' : 'Read more',
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Curated Amenities',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'All ${listing.totalAmenitiesCount}',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listing.amenities.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2.8,
                    ),
                    itemBuilder: (context, index) {
                      final amenity = listing.amenities[index];
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            HugeIcon(
                              icon: amenity.icon,
                              size: 18,
                              color: colorScheme.secondary,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                amenity.label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Neighborhood',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Transit Score ${listing.transitScore}',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/map-placeholder.png',
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listing.neighborhoodName,
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                listing.neighborhoodDescription,
                                style: textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text('Explore'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedMessage01,
                        size: 16,
                        color: colorScheme.onSurface,
                      ),
                      SizedBox(width: 6),
                      Text('Message Host'),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Request Tour',
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 6),
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowRight01,
                        size: 16,
                        color: colorScheme.onPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
