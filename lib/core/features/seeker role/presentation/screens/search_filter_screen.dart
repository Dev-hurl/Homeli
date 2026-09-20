import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class SearchFiltersScreen extends StatefulWidget {
  SearchFiltersScreen({super.key});

  @override
  State<SearchFiltersScreen> createState() => _SearchFiltersScreenState();
}

class _SearchFiltersScreenState extends State<SearchFiltersScreen> {
  final _destinationController = TextEditingController(text: 'New York, NY');

  String _selectedPropertyType = 'Apartment';
  final _propertyTypes = ['All Homes', 'House', 'Apartment', 'Villa'];

  RangeValues _priceRange = RangeValues(1500, 6000);
  static double _minPrice = 800;
  static double _maxPrice = 12000;

  String _selectedBedrooms = '2';
  final _bedroomOptions = ['Any', '1', '2', '3', '4+'];

  String _selectedBathrooms = '2';
  final _bathroomOptions = ['Any', '1', '2', '3+'];

  final Set<String> _selectedAmenities = {'Verified Host', 'Pet Friendly'};
  final _amenities = [
    'Verified Host',
    'In-Unit Laundry',
    'Balcony / Terrace',
    'Pet Friendly',
    'Workspace',
    'Parking',
  ];

  bool _instantBooking = true;
  bool _flexibleLease = false;

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: Icon(Icons.close),
                  ),
                  Expanded(
                    child: Text(
                      'Search & Filters',
                      textAlign: TextAlign.center,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => setState(() {
                      _selectedPropertyType = 'All Homes';
                      _priceRange = RangeValues(1500, 6000);
                      _selectedBedrooms = 'Any';
                      _selectedBathrooms = 'Any';
                      _selectedAmenities.clear();
                      _instantBooking = false;
                      _flexibleLease = false;
                    }),
                    child: Text('Reset'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DESTINATION',
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _destinationController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: colorScheme.surface,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12),
                          child: HugeIcon(
                            icon: HugeIcons.strokeRoundedLocation09,
                            size: 18,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => _destinationController.clear(),
                          icon: Icon(Icons.cancel, size: 18),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(
                            color: colorScheme.outlineVariant,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Property Type',
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Selected: $_selectedPropertyType',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _propertyTypes.length,
                        separatorBuilder: (_, _) => SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final type = _propertyTypes[index];
                          final selected = type == _selectedPropertyType;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedPropertyType = type),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selected
                                    ? colorScheme.primary
                                    : colorScheme.surfaceContainerHigh,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                type,
                                style: textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Monthly Price',
                                      style: textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Includes estimated taxes & fees',
                                      style: textTheme.labelSmall?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
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
                                  color: colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '\$${_priceRange.start.round()} - \$${_priceRange.end.round()}',
                                  style: textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          RangeSlider(
                            values: _priceRange,
                            min: _minPrice,
                            max: _maxPrice,
                            activeColor: colorScheme.primary,
                            inactiveColor: colorScheme.surfaceContainerHigh,
                            onChanged: (values) =>
                                setState(() => _priceRange = values),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Min: \$${_minPrice.round()}',
                                style: textTheme.labelSmall,
                              ),
                              Text('Avg: \$3,450', style: textTheme.labelSmall),
                              Text(
                                'Max: \$${_maxPrice.round()}+',
                                style: textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Rooms & Beds',
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Bedrooms',
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: 8),
                    _StepperChipRow(
                      options: _bedroomOptions,
                      selected: _selectedBedrooms,
                      onSelected: (v) => setState(() => _selectedBedrooms = v),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Bathrooms',
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: 8),
                    _StepperChipRow(
                      options: _bathroomOptions,
                      selected: _selectedBathrooms,
                      onSelected: (v) => setState(() => _selectedBathrooms = v),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amenities',
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '${_amenities.length} Curated',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _amenities.map((amenity) {
                        final selected = _selectedAmenities.contains(amenity);
                        return GestureDetector(
                          onTap: () => setState(
                            () => selected
                                ? _selectedAmenities.remove(amenity)
                                : _selectedAmenities.add(amenity),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? colorScheme.secondary
                                  : colorScheme.surface,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: selected
                                    ? Colors.transparent
                                    : colorScheme.outlineVariant,
                              ),
                            ),
                            child: Text(
                              amenity,
                              style: textTheme.labelMedium?.copyWith(
                                color: selected
                                    ? colorScheme.onSecondary
                                    : colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    _ToggleRow(
                      title: 'Instant Booking',
                      subtitle: 'Book without waiting for host',
                      value: _instantBooking,
                      onChanged: (v) => setState(() => _instantBooking = v),
                    ),
                    Divider(height: 24),
                    _ToggleRow(
                      title: 'Flexible Lease',
                      subtitle: 'Month-to-month contracts',
                      value: _flexibleLease,
                      onChanged: (v) => setState(() => _flexibleLease = v),
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/onboard1.png',
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'LIVE PREVIEW',
                                  style: textTheme.labelSmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                Text(
                                  '142 Matches in New York',
                                  style: textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'From \$2,100 to \$5,800/mo avg',
                                  style: textTheme.labelSmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  TextButton(onPressed: () {}, child: Text('Clear')),
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
                            'Apply Filters (142 Places)',
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
          ],
        ),
      ),
    );
  }
}

class _StepperChipRow extends StatelessWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;
  const _StepperChipRow({
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: options.map((option) {
        final isSelected = option == selected;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onSelected(option),
              child: Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? colorScheme.secondary
                      : colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  option,
                  style: textTheme.labelMedium?.copyWith(
                    color: isSelected
                        ? colorScheme.onSecondary
                        : colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _ToggleRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2),
              Text(
                subtitle,
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: colorScheme.primary,
        ),
      ],
    );
  }
}
