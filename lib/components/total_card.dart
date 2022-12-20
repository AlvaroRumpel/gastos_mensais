import 'package:flutter/material.dart';
import 'package:gastos_mensais/utils/app_colors.dart';
import 'package:gastos_mensais/utils/extensions.dart';

class TotalCard extends StatelessWidget {
  double value;
  ValueNotifier<double> division;
  String divisionFactor;

  TotalCard({
    Key? key,
    this.value = 0.0,
    required this.division,
    required this.divisionFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      decoration: BoxDecoration(
        color: AppColors.primary.shade50,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Total'.toUpperCase(),
            style: TextStyle(
              color: AppColors.primary.shade900,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'R\$',
                  style: TextStyle(
                    color: AppColors.primary.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 11,
                child: Text(
                  value.toMoney(),
                  style: TextStyle(
                    color: AppColors.primary.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: division,
            builder: (context, double value, _) => Visibility(
              visible: value != this.value,
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Division by $divisionFactor'.toUpperCase(),
                    style: TextStyle(
                      color: AppColors.primary.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'R\$',
                          style: TextStyle(
                            color: AppColors.primary.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 11,
                        child: Text(
                          value.toMoney(),
                          style: TextStyle(
                            color: AppColors.primary.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
