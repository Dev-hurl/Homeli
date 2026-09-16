import 'package:flutter/material.dart';
import 'package:homeli/core/features/auth/models/role_setup_model.dart';

final List<RoleSetupModel> roleSetup = [
    RoleSetupModel(
      roleIcon: Icon(Icons.map_rounded),
      roleName: 'SEEKER',
      rolePurpose: 'Find a Home',
      subtitle: 'Browse verified apartments, architect-designed homes, and luxury stays with zero booking hassle.',
    ),

    RoleSetupModel(
      roleIcon: Icon(Icons.home_sharp),
      roleName: 'LISTER',
      rolePurpose: 'List Properties',
      subtitle: 'Reach qualified tenants, automate background checks, manage leases, and receive direct inquiries.',
    ),
  ];