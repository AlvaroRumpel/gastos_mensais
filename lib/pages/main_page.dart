import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gastos_mensais/components/expense_card.dart';
import 'package:gastos_mensais/components/percent_division_tab.dart';
import 'package:gastos_mensais/components/total_card.dart';
import 'package:gastos_mensais/models/historic.dart';
import 'package:gastos_mensais/notifiers/historic_notifier.dart';
import 'package:gastos_mensais/utils/app_colors.dart';
import 'package:gastos_mensais/utils/currency_formatter.dart';
import 'package:gastos_mensais/utils/extensions.dart';
import 'package:gastos_mensais/utils/styles.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _formKeyAddExpense = GlobalKey<FormState>();
  final _formKeyCalculate = GlobalKey<FormState>();
  var expenseNameController = TextEditingController();
  var expenseValueController = TextEditingController();

  var divisionController = TextEditingController();

  var totalWithDivision = ValueNotifier(historicNotifier.value.toListSum());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text('Expenses'.toUpperCase()),
          ),
          primary: true,
          titleSpacing: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.playlist_add_outlined,
                      color: AppColors.white.shade500,
                      size: 34,
                    ),
                    onPressed: () async => await _openAddNewExpense(context),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.calculate_outlined,
                      color: AppColors.white.shade500,
                      size: 32,
                    ),
                    onPressed: () => _addCalculateExpense(context),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            ValueListenableBuilder<List<Historic>>(
              valueListenable: historicNotifier,
              builder: (context, List<Historic> value, __) {
                return TotalCard(
                  value: value.toListSum(),
                  division: totalWithDivision,
                  divisionFactor: divisionController.text,
                );
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 24,
                  bottom: 8,
                ),
                child: ValueListenableBuilder<List<Historic>>(
                    valueListenable: historicNotifier,
                    builder: (context, List<Historic> value, __) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (_, index) => ExpenseCard(
                          expenseName: value[index].expenseName,
                          value: value[index].expenseValue,
                          onRemove: () {
                            historicNotifier.removeItem(index);
                            _updateTotalWithDivision();
                          },
                        ),
                        itemCount: historicNotifier.value.length,
                        separatorBuilder: (_, index) => const Divider(
                          color: Colors.transparent,
                          height: 8,
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => await _openAddNewExpense(context),
          backgroundColor: AppColors.primary.shade500,
          elevation: 4,
          child: Icon(
            Icons.playlist_add_outlined,
            color: AppColors.white.shade500,
            size: 32,
          ),
        ),
      ),
    );
  }

  Future<void> _openAddNewExpense(BuildContext context) async {
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
            key: _formKeyAddExpense,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: expenseNameController,
                  decoration: inputDecoration(label: 'Expense name'),
                ),
                const Divider(color: Colors.transparent),
                TextFormField(
                  controller: expenseValueController,
                  decoration: inputDecoration(label: 'Value'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyPtBrInputFormatter(),
                  ],
                  validator: (value) =>
                      value == null || value.isEmpty || value == 'R\$ 0,00'
                          ? 'Please add a valid value'
                          : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const Divider(color: Colors.transparent),
                ElevatedButton(
                  onPressed: () {
                    if (_formKeyAddExpense.currentState!.validate()) {
                      historicNotifier.addItem(
                        name: expenseNameController.text.isEmpty
                            ? null
                            : expenseNameController.text,
                        value: expenseValueController.text,
                      );
                      _updateTotalWithDivision();

                      expenseNameController.clear();
                      expenseValueController.clear();
                      Navigator.of(context).pop();
                      return;
                    }
                  },
                  child: const Text('Add expense'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary.shade500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addCalculateExpense(BuildContext context) {
    return showModalBottomSheet(
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
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.only(
          bottom: 16,
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                labelPadding: const EdgeInsets.all(16),
                indicatorColor: AppColors.primary.shade500,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.normal),
                tabs: const [
                  Text('Equality'),
                  Text('Percent'),
                ],
              ),
              Flexible(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKeyCalculate,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  controller: divisionController,
                                  decoration: inputDecoration(label: 'value'),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'Please add a valid value'
                                          : null,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                const Divider(color: Colors.transparent),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKeyCalculate.currentState!
                                        .validate()) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      _updateTotalWithDivision();
                                    }
                                  },
                                  child: const Text('Calculate'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary.shade500,
                                  ),
                                ),
                              ],
                            ),
                            ValueListenableBuilder<double>(
                              valueListenable: totalWithDivision,
                              builder: (context, value, _) => Text(
                                'R\$ ' +
                                    value.toMoney() +
                                    (divisionController.text.isNotEmpty
                                        ? ' / ${divisionController.text}'
                                        : ''),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.primary.shade900,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const PercentDivisionTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateTotalWithDivision() {
    totalWithDivision.value = (historicNotifier.value.toListSum() /
        (divisionController.text.isNotEmpty && divisionController.text != '1'
            ? double.parse(divisionController.text)
            : 1));
  }
}
