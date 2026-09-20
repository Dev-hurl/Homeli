import 'package:flutter/material.dart';
import 'package:homeli/core/features/lister%20role/models/verification_item_model.dart';
import 'package:hugeicons/hugeicons.dart';

class VerificationCard extends StatelessWidget {
  final VerificationItemModel item;
  final String? uploadedFileName;
  final VoidCallback onUploadTap;

  const VerificationCard({
    super.key,
    required this.item,
    required this.uploadedFileName,
    required this.onUploadTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    late final Color chipColor;
    late final Color chipTextColor;
    late final String chipLabel;
    late final IconData? chipIcon;

    switch (item.status) {
      case VerificationStatus.verified:
        chipColor = colorScheme.secondary;
        chipTextColor = colorScheme.onSecondary;
        chipLabel = 'Verified';
        chipIcon = Icons.check;
        break;
      case VerificationStatus.actionRequired:
        chipColor = colorScheme.primary;
        chipTextColor = Colors.black;
        chipLabel = 'Action Required';
        chipIcon = null;
        break;
      case VerificationStatus.scheduled:
        chipColor = colorScheme.surfaceContainerHigh;
        chipTextColor = colorScheme.onSurface;
        chipLabel = 'Scheduled';
        chipIcon = null;
        break;
      case VerificationStatus.connected:
        chipColor = colorScheme.tertiary;
        chipTextColor = Colors.white;
        chipLabel = 'Connected';
        chipIcon = Icons.check;
        break;
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: HugeIcon(
                  icon: item.icon,
                  size: 18,
                  color: colorScheme.secondary,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: chipColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (chipIcon != null) ...[
                      Icon(chipIcon, size: 12, color: chipTextColor),
                      SizedBox(width: 4),
                    ],
                    Text(
                      chipLabel,
                      style: textTheme.labelSmall?.copyWith(
                        color: chipTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            item.description,
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          if (item.needsUpload) ...[
            SizedBox(height: 12),
            GestureDetector(
              onTap: onUploadTap,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      color: colorScheme.secondary,
                      size: 24,
                    ),
                    SizedBox(height: 6),
                    Text(
                      uploadedFileName ?? 'Tap to Upload Document',
                      style: textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Supports PDF, JPG, or PNG (Max 25MB)',
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
