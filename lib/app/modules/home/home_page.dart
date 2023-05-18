import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/notifier/change_notifier_listener.dart';
import '../../core/ui/theme/app_colors.dart';
import '../../core/ui/widgets/expense_card.dart';
import '../../core/ui/widgets/total_card.dart';
import '../../core/utils/currency_formatter.dart';
import '../../core/utils/extensions.dart';
import '../../models/expense_model.dart';
import '../../models/pattern_model.dart';
import '../navigatior/navigator_controller.dart';
import 'home_controller.dart';
import 'widgets/calculate_modal.dart';

class HomePage extends StatefulWidget {
  final HomeController _controller;

  const HomePage({Key? key, required HomeController controller})
      : _controller = controller,
        super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _addExpenseFormKey = GlobalKey<FormState>();
  final _expenseNameEC = TextEditingController();
  final _expenseValueEC = TextEditingController();

  @override
  void initState() {
    super.initState();

    ChangeNotifierListener(
      changeNotifierController: context.read<HomeController>(),
    ).listener(
      context: context,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var arguments =
          ModalRoute.of(context)?.settings.arguments as PatternModel?;
      widget._controller.patternModel = arguments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EXPENSES'),
        actions: [
          IconButton(
            onPressed: () => CalculateModal(
              context: context,
              valueComplete: widget._controller.totalValue,
              divisionValue: widget._controller.divisionValue,
            ),
            tooltip: 'Open to calculate',
            icon: const Icon(
              Icons.calculate_outlined,
              color: AppColors.white,
              size: 36,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: TotalCard(
                  value: context.select<HomeController, double>(
                    (value) => value.resultValue,
                  ),
                  divisionValue: context
                      .select<HomeController, double>(
                        (value) => value.divisionValue,
                      )
                      .toInt(),
                  minHeight: (constraints.maxHeight * .3),
                  maxHeight: (constraints.maxHeight * .5),
                  maxWidth: constraints.maxWidth,
                  saveExpenses: () => widget._controller.savePattern(),
                  onTapInValue: () => CalculateModal(
                    context: context,
                    valueComplete: widget._controller.totalValue,
                    divisionValue: widget._controller.divisionValue,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  addAutomaticKeepAlives: false,
                  addSemanticIndexes: false,
                  context.select<HomeController, List<ExpenseCard>>(
                    (value) => value.expensesList
                        .map(
                          (e) => ExpenseCard(
                            onRemove: () => value.removeExpense(e.id),
                            onClick: () => _editExpense(context, e),
                            expenseName: e.expenseName,
                            value: e.expenseValue,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: context.select<NavigatorController, int>(
                  (controller) => controller.currentPage) ==
              1
          ? FloatingActionButton(
              onPressed: () => _addExpense(context),
              backgroundColor: AppColors.primary,
              child: const Icon(
                Icons.playlist_add,
                color: AppColors.white,
              ),
            )
          : null,
    );
  }

  Future<void> _addExpense(BuildContext context) async {
    _expenseNameEC.clear();
    _expenseValueEC.clear();
    return await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        backgroundColor: AppColors.primary.shade50,
        title: const Text('Add new expense'),
        content: SingleChildScrollView(
          child: Form(
            key: _addExpenseFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _expenseNameEC,
                  decoration: const InputDecoration(
                    labelText: 'Expense name',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _expenseValueEC,
                  decoration: const InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyPtBrInputFormatter(),
                  ],
                  validator: (value) =>
                      value == null || value.isEmpty || value == '\$ 0,00'
                          ? 'Please add a valid value'
                          : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_addExpenseFormKey.currentState?.validate() ?? false) {
                      Navigator.of(_).pop();
                      await widget._controller.addNewExpense(
                        name: _expenseNameEC.text,
                        value: _expenseValueEC.text,
                      );
                      _expenseNameEC.clear();
                      _expenseValueEC.clear();
                      return;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: const Text('Add expense'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _editExpense(BuildContext context, ExpenseModel expense) async {
    _expenseNameEC.text = expense.expenseName;
    _expenseValueEC.text = expense.expenseValue.toMoney();
    return await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        backgroundColor: AppColors.primary.shade50,
        title: const Text('Edit expense'),
        content: SingleChildScrollView(
          child: Form(
            key: _addExpenseFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _expenseNameEC,
                  decoration: const InputDecoration(
                    labelText: 'Expense name',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _expenseValueEC,
                  decoration: const InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyPtBrInputFormatter(),
                  ],
                  validator: (value) =>
                      value == null || value.isEmpty || value == '\$ 0,00'
                          ? 'Please add a valid value'
                          : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_addExpenseFormKey.currentState?.validate() ?? false) {
                      Navigator.of(_).pop();
                      expense = expense.copyWith(
                        expenseName: _expenseNameEC.text,
                        expenseValue: double.parse(
                          _expenseValueEC.text
                              .replaceAll(RegExp(r'(\$) |\.'), '')
                              .replaceAll(',', '.'),
                        ),
                      );
                      await widget._controller.editExpense(expense);
                      _expenseNameEC.clear();
                      _expenseValueEC.clear();
                      return;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: const Text('Save expense'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
