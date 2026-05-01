import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int _selectedPeriod = 1; // 0=Today, 1=This Week, 2=Month

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: 'Reports',
        trailing: IconButton(
          icon: const Icon(Icons.file_download, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ───── Period Toggle ─────
            Row(
              children: [
                _PeriodButton(label: 'Today',     index: 0, selected: _selectedPeriod, onTap: (i) => setState(() => _selectedPeriod = i)),
                const SizedBox(width: AppSpacing.sm),
                _PeriodButton(label: 'This Week', index: 1, selected: _selectedPeriod, onTap: (i) => setState(() => _selectedPeriod = i)),
                const SizedBox(width: AppSpacing.sm),
                _PeriodButton(label: 'Month',     index: 2, selected: _selectedPeriod, onTap: (i) => setState(() => _selectedPeriod = i)),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // ───── Revenue Summary Card ─────
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TOTAL REVENUE THIS WEEK',
                      style: AppTextStyles.labelBold
                          .copyWith(color: Colors.white.withOpacity(0.8))),
                  const SizedBox(height: AppSpacing.sm),
                  Text('\$8,247.50',
                      style: AppTextStyles.h1.copyWith(color: Colors.white)),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      const Icon(Icons.trending_up, color: Colors.white, size: 18),
                      const SizedBox(width: AppSpacing.xs),
                      Text('+12.5% vs last week',
                          style: AppTextStyles.bodyMd
                              .copyWith(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // ───── Bar Chart ─────
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.surfaceVariant),
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('DAILY SALES TREND',
                      style: AppTextStyles.labelBold
                          .copyWith(color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    height: 128,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        _Bar(heightFraction: 0.40, opacity: 0.30),
                        _Bar(heightFraction: 0.65, opacity: 0.40),
                        _Bar(heightFraction: 0.50, opacity: 0.50),
                        _Bar(heightFraction: 0.80, opacity: 0.60),
                        _Bar(heightFraction: 0.70, opacity: 0.70),
                        _Bar(heightFraction: 0.90, opacity: 0.80),
                        _Bar(heightFraction: 1.00, opacity: 1.00),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                        .map((d) => Text(d,
                        style: AppTextStyles.labelBold.copyWith(
                            fontSize: 10,
                            color: AppColors.onSurfaceVariant)))
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // ───── Stats Grid 2×2 ─────
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.gutter,
              mainAxisSpacing: AppSpacing.gutter,
              childAspectRatio: 1.5,
              children: [
                _StatCell(label: 'Orders',        value: '184',    trend: '↑ 8.2%',  isError: false),
                _StatCell(label: 'Avg Order',     value: '\$44.82', trend: '↑ 3.5%',  isError: false),
                _StatCell(label: 'New Users',     value: '29',     trend: '↑ 15.0%', isError: false),
                _StatCell(label: 'Cancellations', value: '7',      trend: '↑ 2.1%',  isError: true),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // ───── Top Selling Products ─────
            Text('TOP SELLING PRODUCTS',
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
                children: const [
                  _TopProductRow(rank: 1, name: 'Fresh Apples',    sold: '142 sold', revenue: '\$566.58'),
                  Divider(height: 1, color: AppColors.surfaceVariant),
                  _TopProductRow(rank: 2, name: 'Whole Milk',      sold: '98 sold',  revenue: '\$146.02'),
                  Divider(height: 1, color: AppColors.surfaceVariant),
                  _TopProductRow(rank: 3, name: 'Sourdough Bread', sold: '76 sold',  revenue: '\$342.00'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PeriodButton extends StatelessWidget {
  final String label;
  final int index;
  final int selected;
  final ValueChanged<int> onTap;
  const _PeriodButton(
      {required this.label, required this.index,
        required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final active = index == selected;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: active ? AppColors.primaryContainer : AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Text(label.toUpperCase(),
              textAlign: TextAlign.center,
              style: AppTextStyles.labelBold.copyWith(
                  color: active ? Colors.white : AppColors.onSurface)),
        ),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final double heightFraction;
  final double opacity;
  const _Bar({required this.heightFraction, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: FractionallySizedBox(
          alignment: Alignment.bottomCenter,
          heightFactor: heightFraction,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryContainer.withOpacity(opacity),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  final String label;
  final String value;
  final String trend;
  final bool isError;
  const _StatCell(
      {required this.label, required this.value,
        required this.trend, required this.isError});

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
          Text(label.toUpperCase(),
              style: AppTextStyles.labelBold
                  .copyWith(color: AppColors.onSurfaceVariant)),
          const SizedBox(height: AppSpacing.xs),
          Text(value,
              style: AppTextStyles.h1.copyWith(
                  color: isError ? AppColors.error : AppColors.onSurface)),
          const SizedBox(height: AppSpacing.xs),
          Text(trend,
              style: AppTextStyles.bodyMd.copyWith(
                  fontSize: 12,
                  color: isError ? AppColors.error : AppColors.primary)),
        ],
      ),
    );
  }
}

class _TopProductRow extends StatelessWidget {
  final int rank;
  final String name;
  final String sold;
  final String revenue;
  const _TopProductRow(
      {required this.rank, required this.name,
        required this.sold, required this.revenue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: 32, height: 32,
            decoration: const BoxDecoration(
              color: AppColors.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('$rank',
                  style: AppTextStyles.labelBold
                      .copyWith(color: Colors.white)),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name.toUpperCase(), style: AppTextStyles.labelBold),
                Text(sold,
                    style: AppTextStyles.bodyMd.copyWith(
                        fontSize: 12, color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Text(revenue,
              style: AppTextStyles.h2.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }
}