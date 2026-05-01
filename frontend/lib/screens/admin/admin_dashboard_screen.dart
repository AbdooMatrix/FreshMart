import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: 'Admin Panel',
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        trailing: IconButton(
          icon: const Icon(Icons.power_settings_new, color: Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ───── Welcome Card ─────
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('WELCOME BACK',
                      style: AppTextStyles.labelBold
                          .copyWith(color: Colors.white.withOpacity(0.8))),
                  const SizedBox(height: 4),
                  Text('ADMIN USER',
                      style: AppTextStyles.h1.copyWith(color: Colors.white)),
                  const SizedBox(height: 4),
                  Text('Manage your platform and monitor activity',
                      style: AppTextStyles.bodyMd
                          .copyWith(color: Colors.white.withOpacity(0.9))),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // ───── Stats Grid 2×2 ─────
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.gutter,
              mainAxisSpacing: AppSpacing.gutter,
              childAspectRatio: 1.3,
              children: const [
                _StatCard(icon: Icons.group, value: '247', label: 'Total Users'),
                _StatCard(icon: Icons.storefront, value: '12', label: 'Active Vendors'),
                _StatCard(icon: Icons.receipt_long, value: '38', label: 'Orders Today'),
                _StatCard(icon: Icons.payments, value: '\$1,847', label: 'Revenue Today'),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // ───── Quick Actions (WIRED) ─────
            Text('QUICK ACTIONS',
                style: AppTextStyles.labelBold
                    .copyWith(color: AppColors.primaryContainer)),
            const SizedBox(height: AppSpacing.sm),
            _ActionRow(
              icon: Icons.manage_accounts,
              title: 'User Management',
              subtitle: 'View and manage all users',
              onTap: () => Navigator.pushNamed(context, '/admin/user-management'),
            ),
            const SizedBox(height: AppSpacing.sm),
            _ActionRow(
              icon: Icons.list_alt,
              title: 'All Orders',
              subtitle: 'Monitor system-wide orders',
              onTap: () => Navigator.pushNamed(context, '/admin/all-orders'),
            ),
            const SizedBox(height: AppSpacing.sm),
            _ActionRow(
              icon: Icons.analytics,
              title: 'Sales Reports',
              subtitle: 'View analytics and trends',
              onTap: () => Navigator.pushNamed(context, '/admin/reports'),
            ),
            const SizedBox(height: AppSpacing.lg),

            // ───── Recent Activity (WIRED) ─────
            Text('RECENT ACTIVITY',
                style: AppTextStyles.labelBold
                    .copyWith(color: AppColors.primaryContainer)),
            const SizedBox(height: AppSpacing.sm),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.surfaceVariant),
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
              child: Column(
                children: [
                  _ActivityRow(
                    icon: Icons.person_add,
                    iconColor: AppColors.primaryContainer,
                    title: 'New customer registered',
                    time: '2 minutes ago',
                    onTap: () => Navigator.pushNamed(
                        context, '/admin/user-management'),
                  ),
                  const Divider(height: 1, color: AppColors.surfaceVariant),
                  _ActivityRow(
                    icon: Icons.shopping_bag,
                    iconColor: AppColors.primaryContainer,
                    title: 'Order #1247 placed',
                    time: '15 minutes ago',
                    onTap: () => Navigator.pushNamed(
                        context, '/admin/all-orders'),
                  ),
                  const Divider(height: 1, color: AppColors.surfaceVariant),
                  _ActivityRow(
                    icon: Icons.delivery_dining,
                    iconColor: AppColors.tertiary,
                    title: 'Delivery completed for #1245',
                    time: '1 hour ago',
                    onTap: () => Navigator.pushNamed(
                        context, '/admin/all-orders'),
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

// ───── Helper Widgets ─────

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value, label;
  const _StatCard(
      {required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.surface,
      border: Border.all(color: AppColors.surfaceVariant),
      borderRadius: BorderRadius.circular(AppRadius.xl),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primaryContainer, size: 24),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.h1),
        const SizedBox(height: 4),
        Text(label.toUpperCase(),
            style: AppTextStyles.labelBold
                .copyWith(color: AppColors.onSurfaceVariant)),
      ],
    ),
  );
}

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final VoidCallback onTap;
  const _ActionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(AppRadius.xl),
    child: Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.surfaceVariant),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Icon(icon, color: AppColors.primaryContainer),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title.toUpperCase(),
                    style: AppTextStyles.labelBold),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: AppTextStyles.bodyMd.copyWith(
                        fontSize: 12,
                        color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.outline),
        ],
      ),
    ),
  );
}

class _ActivityRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title, time;
  final VoidCallback onTap;
  const _ActivityRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMd),
                const SizedBox(height: 2),
                Text(time,
                    style: AppTextStyles.bodyMd.copyWith(
                        fontSize: 12,
                        color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right,
              color: AppColors.outline, size: 18),
        ],
      ),
    ),
  );
}