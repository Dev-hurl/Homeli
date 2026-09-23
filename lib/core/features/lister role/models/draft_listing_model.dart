class DraftListingModel {
  final String imagePath;
  final String title;
  final String stepLabel;
  final String note;

  DraftListingModel({
    required this.imagePath,
    required this.title,
    required this.stepLabel,
    required this.note,
  });
}

final draftListing = [
  DraftListingModel(
    imagePath: 'assets/images/new-uk-homes.png',
    title: 'Chelsea Townhouse',
    stepLabel: 'Draft (Step 2/3)',
    note: 'Pricing & verification pending',
  ),
];
