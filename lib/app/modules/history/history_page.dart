import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/notifier/change_notifier_listener.dart';
import '../../core/ui/theme/app_colors.dart';
import '../../core/ui/widgets/expense_card.dart';
import '../../core/ui/widgets/messages.dart';
import '../../core/utils/text_extension.dart';
import '../../models/expense_model.dart';
import 'history_controller.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required HistoryController controller})
      : _controller = controller;

  final HistoryController _controller;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();

    ChangeNotifierListener(
      changeNotifierController: context.read<HistoryController>(),
    ).listener(
      context: context,
      errorVoidCallback: (notifier, listenerInstance) {
        Messages.of(context).showError(notifier.errorMessage);
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget._controller.searchListOfExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HISTORY'),
        automaticallyImplyLeading: false,
      ),
      body: Selector<HistoryController, List<ExpenseModel>>(
        selector: (context, controller) => controller.listOfExpenses,
        builder: (context, value, _) => Visibility(
          visible: value.isNotEmpty,
          replacement: const SizedBox.shrink(),
          child: ListView.separated(
            itemCount: value.length,
            itemBuilder: (context, index) {
              var expense = value[index];
              return Visibility(
                visible: index == 0,
                replacement: ExpenseCard(
                  expenseName: expense.expenseName,
                  value: expense.expenseValue,
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(
                            thickness: 2,
                            color: AppColors.primary.shade300,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: AppColors.primary.shade100,
                          child: Text(
                            DateFormat('dd/MM/yyyy').format(
                              value[index].createDate,
                            ),
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: AppColors.primary.shade400,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ExpenseCard(
                      expenseName: expense.expenseName,
                      value: expense.expenseValue,
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              if (index >= 1 &&
                  DateTime(
                        value[index - 1].createDate.year,
                        value[index - 1].createDate.month,
                        value[index - 1].createDate.day,
                      ).compareTo(DateTime(
                        value[index].createDate.year,
                        value[index].createDate.month,
                        value[index].createDate.day,
                      )) >
                      0) {
                return Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        thickness: 2,
                        color: AppColors.primary.shade300,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: AppColors.primary.shade100,
                      child: Text(
                        DateFormat('dd/MM/yyyy').format(
                          value[index].createDate,
                        ),
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: AppColors.primary.shade400,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
