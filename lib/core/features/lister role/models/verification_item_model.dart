import 'package:hugeicons/hugeicons.dart';

enum VerificationStatus { verified, actionRequired, scheduled, connected }

class VerificationItemModel {
  final dynamic icon;
  final String title;
  final VerificationStatus status;
  final String description;
  final bool needsUpload;
  VerificationItemModel({
    required this.icon,
    required this.title,
    required this.status,
    required this.description,
    required this.needsUpload,
  });
}

final verificationItems = [
  VerificationItemModel(
    icon: HugeIcons.strokeRoundedIdentification,
    title: 'Government-Issued Phot...',
    status: VerificationStatus.verified,
    description: 'Passport ending in ••82 securely validated on Oct 14.',
    needsUpload: false,
  ),
  VerificationItemModel(
    icon: HugeIcons.strokeRoundedHome01,
    title: 'Proof of Ownership or Lease',
    status: VerificationStatus.actionRequired,
    description: 'Upload recent property deed, authorized sublease agreement, or water/electric utility bill for 32 W Mercer St.',
    needsUpload: true,
  ),
  VerificationItemModel(
    icon: HugeIcons.strokeRoundedVideoReplay,
    title: 'Architectural Inspection',
    status: VerificationStatus.scheduled,
    description: 'Live virtual walkthrough with Homeli Specialist for Oct 25, 11:00 AM PST.',
    needsUpload: false,
  ),
  VerificationItemModel(
    icon: HugeIcons.strokeRoundedBank,
    title: 'Lister Payout Account',
    status: VerificationStatus.connected,
    description: 'Direct Deposit linked via Chase Checking •••• 4120.',
    needsUpload: false,
  ),
];
