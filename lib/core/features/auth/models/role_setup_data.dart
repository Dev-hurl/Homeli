import 'package:flutter/material.dart';
import 'package:homeli/core/constants/app_colors.dart';
import 'package:homeli/core/features/auth/models/role_setup_model.dart';
import 'package:hugeicons/hugeicons.dart';

final List<RoleSetupModel> roleSetup = [
  RoleSetupModel(
    roleIcon: UnconstrainedBox(
      child: HugeIcon(
        icon: HugeIcons.strokeRoundedGlobalSearch,
        size: 20,
        color: AppColors.bluePrimary,
      ),
    ),
    roleName: 'SEEKER',
    rolePurpose: 'Find a Home',
    subtitle: 'Browse verified apartments, architect-designed homes, and luxury stays with zero booking hassle.',
  ),

  RoleSetupModel(
    roleIcon: UnconstrainedBox(
      child: HugeIcon(
        icon: HugeIcons.strokeRoundedRealEstate01,
        size: 20,
        color: AppColors.bluePrimary,
      ),
    ),
    roleName: 'LISTER',
    rolePurpose: 'List Properties',
    subtitle: 'Reach qualified tenants, automate background checks, manage leases, and receive direct inquiries.',
  ),
];
