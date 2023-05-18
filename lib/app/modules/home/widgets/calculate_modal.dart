import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/theme/app_colors.dart';
import '../home_controller.dart';
import 'calculate_modal_adpters/equality_tab_adapter.dart';
import 'calculate_modal_adpters/percent_tab_adapter.dart';

class CalculateModal {
  BuildContext context;
  double valueComplete;
  double divisionValue;
  double valueCalculated;

  CalculateModal({
    required this.context,
    required this.valueComplete,
    this.divisionValue = 0.0,
  }) : valueCalculated = valueComplete {
    _open();
  }

  Future<void> _open() async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.primary.shade50,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.only(
            bottom: 16,
          ),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  labelPadding: EdgeInsets.all(16),
                  indicatorColor: AppColors.primary,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  tabs: [
                    Text('Equality'),
                    Text('Percent'),
                  ],
                ),
                Flexible(
                  child: TabBarView(
                    children: [
                      EqualityTabAdapter(
                        divisionValue: divisionValue,
                        valueCalculated: valueCalculated,
                        valueComplete: valueComplete,
                        controller: context.read<HomeController>(),
                      ),
                      PercentTabAdapter(valueComplete: valueComplete),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
