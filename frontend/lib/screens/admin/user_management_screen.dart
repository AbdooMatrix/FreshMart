import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  int _selectedFilter = 0;

  static const _filters = [
    'All (247)',
    'Customers (218)',
    'Vendors (12)',
    'Delivery (15)',
    'Admins (2)',
  ];

  static const _users = [
    _UserData(name: 'Test Customer', email: 'customer@test.com', role: 'Customer',  roleType: _RoleType.customer,  canDelete: true),
    _UserData(name: 'Vendor User',   email: 'vendor@test.com',   role: 'Vendor',    roleType: _RoleType.vendor,    canDelete: true),
    _UserData(name: 'Ahmed Mahmoud', email: 'ahmed@delivery.com', role: 'Delivery', roleType: _RoleType.delivery,  canDelete: true),
    _UserData(name: 'Admin User',    email: 'admin@test.com',     role: 'Admin',    roleType: _RoleType.admin,     canDelete: false),
    _UserData(name: 'Sara Mohamed',  email: 'sara@example.com',   role: 'Customer', roleType: _RoleType.customer,  canDelete: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'User Management'),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    children: [
                      // ───── Search Bar ─────
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          border: Border.all(color: AppColors.surfaceVariant),
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md),
                        child: Row(
                          children: [
                            const Icon(Icons.search,
                                color: AppColors.outline),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search by name or email...',
                                  hintStyle: AppTextStyles.bodyMd.copyWith(
                                      color: AppColors.outline),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  fillColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // ───── Filter Chips ─────
                      SizedBox(
                        height: 36,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _filters.length,
                          separatorBuilder: (_, __) =>
                          const SizedBox(width: AppSpacing.sm),
                          itemBuilder: (_, i) {
                            final active = i == _selectedFilter;
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedFilter = i),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.md,
                                    vertical: AppSpacing.sm),
                                decoration: BoxDecoration(
                                  color: active
                                      ? AppColors.primaryContainer
                                      : AppColors.secondaryFixed,
                                  borderRadius: BorderRadius.circular(
                                      AppRadius.full),
                                ),
                                child: Text(_filters[i].toUpperCase(),
                                    style: AppTextStyles.labelBold.copyWith(
                                        color: active
                                            ? Colors.white
                                            : AppColors.onSurface)),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // ───── User List ─────
                      ...List.generate(
                        _users.length,
                            (i) => Padding(
                          padding: EdgeInsets.only(
                              bottom: i < _users.length - 1
                                  ? AppSpacing.gutter
                                  : AppSpacing.xl * 2),
                          child: _UserRow(user: _users[i]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ───── FAB ─────
          Positioned(
            bottom: 24,
            right: 24,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 56, height: 56,
                decoration: const BoxDecoration(
                  color: AppColors.primaryContainer,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x20000000),
                        blurRadius: 12,
                        offset: Offset(0, 4))
                  ],
                ),
                child: const Icon(Icons.person_add,
                    color: Colors.white, size: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _RoleType { customer, vendor, delivery, admin }

class _UserData {
  final String name, email, role;
  final _RoleType roleType;
  final bool canDelete;
  const _UserData(
      {required this.name, required this.email, required this.role,
        required this.roleType, required this.canDelete});
}

class _UserRow extends StatelessWidget {
  final _UserData user;
  const _UserRow({required this.user});

  Color get _avatarColor {
    switch (user.roleType) {
      case _RoleType.customer: return AppColors.primaryContainer;
      case _RoleType.vendor:   return AppColors.primaryContainer;
      case _RoleType.delivery: return AppColors.tertiary;
      case _RoleType.admin:    return AppColors.secondary;
    }
  }

  IconData get _icon {
    switch (user.roleType) {
      case _RoleType.customer: return Icons.person;
      case _RoleType.vendor:   return Icons.storefront;
      case _RoleType.delivery: return Icons.delivery_dining;
      case _RoleType.admin:    return Icons.admin_panel_settings;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.surfaceVariant),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: _avatarColor,
              shape: BoxShape.circle,
            ),
            child: Icon(_icon, color: Colors.white),
          ),
          const SizedBox(width: AppSpacing.md),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name.toUpperCase(),
                    style: AppTextStyles.labelBold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(user.email,
                    style: AppTextStyles.bodyMd.copyWith(
                        fontSize: 12,
                        color: AppColors.onSurfaceVariant),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: AppSpacing.xs),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _avatarColor,
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                  child: Text(user.role.toUpperCase(),
                      style: AppTextStyles.labelBold.copyWith(
                          fontSize: 10, color: Colors.white)),
                ),
              ],
            ),
          ),

          // Actions
          Column(
            children: [
              _ActionBtn(
                icon: Icons.edit,
                color: AppColors.primary,
                onTap: () {},
              ),
              if (user.canDelete) ...[
                const SizedBox(height: AppSpacing.xs),
                _ActionBtn(
                  icon: Icons.delete,
                  color: AppColors.error,
                  onTap: () {},
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _ActionBtn(
      {required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32, height: 32,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}