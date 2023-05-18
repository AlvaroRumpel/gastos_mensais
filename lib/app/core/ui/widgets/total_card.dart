import 'package:flutter/material.dart';

import '../../utils/extensions.dart';
import '../../utils/text_extension.dart';
import '../theme/app_colors.dart';

class TotalCard extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final double maxWidth;
  final Function() saveExpenses;
  final double value;
  final Function() onTapInValue;
  final int divisionValue;

  TotalCard({
    required this.minHeight,
    required this.maxHeight,
    required this.maxWidth,
    required this.saveExpenses,
    required this.value,
    required this.onTapInValue,
    required this.divisionValue,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      constraints: BoxConstraints(
        minHeight: minHeight,
        minWidth: maxWidth,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.shade100,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.white.shade600.withOpacity(.5),
            spreadRadius: 0,
            blurRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TOTAL',
                style: context.textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellow.shade100,
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 16,
                  ),
                  elevation: 2,
                ),
                onPressed: saveExpenses,
                icon: const Icon(
                  Icons.check,
                  color: AppColors.primary,
                ),
                label: Text(
                  'SAVE EXPENSE PATTERN',
                  style: context.textLabel,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$',
                style: context.textRegular?.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InkWell(
                  onTap: onTapInValue,
                  child: Text(
                    '${value.toMoney()} ${divisionValue > 1 ? '/ $divisionValue' : ''}',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: context.textTheme.displayMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible:
                1.0 - (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0) >
                    .13,
            child: Opacity(
              opacity: 1.0 -
                  (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0),
              child: Text(
                'Tap the value to calculate',
                style: context.textLabel,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
