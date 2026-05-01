import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class DeliveryDashboardScreen extends StatefulWidget {
  const DeliveryDashboardScreen({super.key});

  @override
  State<DeliveryDashboardScreen> createState() =>
      _DeliveryDashboardScreenState();
}

class _DeliveryDashboardScreenState extends State<DeliveryDashboardScreen> {
  bool _isOnline = true;

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: AppColors.tertiary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          color: AppColors.tertiary,
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: 56,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Center(
                        child: Text('DELIVERY',
                            style: AppTextStyles.h2
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.power_settings_new,
                          color: Colors.white),
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, '/login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ───── Agent Card ─────
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.tertiary,
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 56, height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.delivery_dining,
                            color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('DELIVERY AGENT',
                                style: AppTextStyles.labelBold.copyWith(
                                    color: Colors.white.withOpacity(0.8))),
                            Text('Ahmed Mahmoud',
                                style: AppTextStyles.h2
                                    .copyWith(color: Colors.white)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.white, size: 14),
                                const SizedBox(width: 4),
                                Text('4.8 rating',
                                    style: AppTextStyles.bodyMd
                                        .copyWith(color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  // ───── Online Toggle (WIRED to local state) ─────
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 12, height: 12,
                          decoration: BoxDecoration(
                            color: _isOnline
                                ? AppColors.primaryContainer
                                : AppColors.outline,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                            _isOnline
                                ? 'YOU ARE ONLINE'
                                : 'YOU ARE OFFLINE',
                            style: AppTextStyles.labelBold
                                .copyWith(color: Colors.white)),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            setState(() => _isOnline = !_isOnline);
                            _toast(_isOnline
                                ? 'You are now online'
                                : 'You are now offline');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.tertiary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(AppRadius.full),
                            ),
                          ),
                          child: Text(
                              _isOnline ? 'GO OFFLINE' : 'GO ONLINE',
                              style: AppTextStyles.labelBold
                                  .copyWith(color: AppColors.tertiary)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // ───── Stats Grid ─────
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.gutter,
              mainAxisSpacing: AppSpacing.gutter,
              childAspectRatio: 1.3,
              children: const [
                _DStatCard(
                    icon: Icons.inventory_2,
                    value: '3',
                    label: 'Active Orders'),
                _DStatCard(
                    icon: Icons.check_circle,
                    value: '12',
                    label: 'Delivered Today'),
                _DStatCard(
                    icon: Icons.payments,
                    value: '\$87.50',
                    label: 'Earnings Today'),
                _DStatCard(
                    icon: Icons.timer,
                    value: '28m',
                    label: 'Avg Delivery'),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // ───── Quick Actions (WIRED) ─────
            Text('QUICK ACTIONS',
                style: AppTextStyles.labelBold
                    .copyWith(color: AppColors.tertiary)),
            const SizedBox(height: AppSpacing.sm),
            _DActionRow(
              icon: Icons.list_alt,
              title: 'View Active Orders',
              subtitle: '3 orders waiting for delivery',
              filled: true,
              onTap: () =>
                  Navigator.pushNamed(context, '/delivery/active-orders'),
            ),
            const SizedBox(height: AppSpacing.sm),
            _DActionRow(
              icon: Icons.history,
              title: 'Delivery History',
              subtitle: 'View past deliveries',
              filled: false,
              onTap: () => _toast('Delivery History — coming in next phase'),
            ),
            const SizedBox(height: AppSpacing.sm),
            _DActionRow(
              icon: Icons.map,
              title: 'Delivery Map',
              subtitle: 'View routes and locations',
              filled: false,
              onTap: () => _toast('Delivery Map — coming in next phase'),
            ),
            const SizedBox(height: AppSpacing.lg),

            // ───── Urgent Pickup Alert (WIRED) ─────
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.errorContainer,
                border: Border.all(color: AppColors.error),
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.notifications_active,
                      color: AppColors.error),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('URGENT: NEW ORDER ASSIGNED',
                            style: AppTextStyles.labelBold
                                .copyWith(color: AppColors.error)),
                        const SizedBox(height: 4),
                        Text(
                            'Order #1247 is ready for pickup at FreshMart Store',
                            style: AppTextStyles.bodyMd),
                        const SizedBox(height: AppSpacing.sm),
                        ElevatedButton(
                          onPressed: () => Navigator.pushNamed(
                              context, '/delivery/order-details'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.error,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(AppRadius.full),
                            ),
                          ),
                          child: Text('VIEW NOW',
                              style: AppTextStyles.labelBold
                                  .copyWith(color: Colors.white)),
                        ),
                      ],
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

// ───── Helper Widgets ─────

class _DStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _DStatCard(
      {required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.surfaceVariant),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.tertiary, size: 24),
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
}

class _DActionRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool filled;
  final VoidCallback onTap;

  const _DActionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = filled ? AppColors.tertiary : AppColors.surface;
    final fg = filled ? Colors.white : AppColors.onSurface;
    final iconBg = filled
        ? Colors.white.withOpacity(0.2)
        : AppColors.tertiary.withOpacity(0.1);
    final iconColor = filled ? Colors.white : AppColors.tertiary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: bg,
          border:
          filled ? null : Border.all(color: AppColors.surfaceVariant),
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title.toUpperCase(),
                      style: AppTextStyles.labelBold.copyWith(color: fg)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: AppTextStyles.bodyMd.copyWith(
                        fontSize: 12,
                        color: filled
                            ? Colors.white.withOpacity(0.9)
                            : AppColors.onSurfaceVariant,
                      )),
                ],
              ),
            ),
            Icon(Icons.chevron_right,
                color: filled ? Colors.white : AppColors.outline),
          ],
        ),
      ),
    );
  }
}