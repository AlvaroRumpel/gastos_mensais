import 'package:flutter/material.dart';

import '../../utils/extensions.dart';
import '../theme/app_colors.dart';

// ignore: must_be_immutable
class ExpenseCard extends StatelessWidget {
  String expenseName;
  double value;
  Function()? onRemove;
  Function()? onClick;

  ExpenseCard({
    super.key,
    this.expenseName = 'Without name',
    this.value = 0.0,
    this.onRemove,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      height: 80,
      constraints: const BoxConstraints(maxHeight: 88, minHeight: 72),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColors.primary.shade50,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 16,
            child: InkWell(
              onTap: onClick,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8,
                  top: 8,
                  bottom: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      expenseName.toUpperCase(),
                      style: TextStyle(
                        color: AppColors.black.shade500,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            '\$',
                            style: TextStyle(
                              color: AppColors.black.shade500,
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 11,
                          fit: FlexFit.tight,
                          child: Text(
                            value.toMoney(),
                            style: TextStyle(
                              color: AppColors.black.shade500,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
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
          ),
          Visibility(
            visible: onRemove != null,
            replacement: const SizedBox.shrink(),
            child: Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Material(
                color: AppColors.red.shade100,
                child: InkWell(
                  onTap: onRemove,
                  child: Icon(
                    Icons.delete_forever,
                    color: AppColors.red.shade500,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
