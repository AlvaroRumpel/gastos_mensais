import 'package:flutter/material.dart';
import 'package:gastos_mensais/models/percent.dart';
import 'package:gastos_mensais/notifiers/historic_notifier.dart';
import 'package:gastos_mensais/utils/app_colors.dart';
import 'package:gastos_mensais/utils/extensions.dart';

class PercentDivisionTab extends StatefulWidget {
  const PercentDivisionTab({Key? key}) : super(key: key);

  @override
  State<PercentDivisionTab> createState() => _PercentDivisionTabState();
}

class _PercentDivisionTabState extends State<PercentDivisionTab> {
  final _numberOfDivisions = ValueNotifier<double>(1);
  final _listOfTextInputs = List.generate(
    1,
    (index) => ValueNotifier<Percent>(
      Percent(value: 0, maxValue: 100),
    ),
  );
  final _restValue = ValueNotifier<double>(100.0);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ValueListenableBuilder(
        valueListenable: _numberOfDivisions,
        builder: (context, double value, _) => Column(
          children: [
            Text(
              'How many divisions? ${value.toInt()}',
              style: const TextStyle(fontSize: 16),
            ),
            Slider(
              value: value,
              divisions: 8,
              min: 1,
              max: 10,
              onChanged: (newValue) =>
                  _restValue.value > 0 || newValue < _numberOfDivisions.value
                      ? _addDivision(newValue)
                      : null,
              activeColor: AppColors.primary.shade900,
              label: '${value.toInt()}',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _restValue,
                      builder: (context, double value, _) => Text(
                        '${value.toStringAsFixed(1)} % rest',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(color: Colors.transparent),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) => ValueListenableBuilder(
                        valueListenable: _listOfTextInputs[index],
                        builder: (context, Percent value, _) => Column(
                          children: [
                            Text(
                                'Position ${index + 1} have ${_listOfTextInputs[index].value.value.toStringAsFixed(1)} %'),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                Flexible(
                                  flex: 10,
                                  child: Slider(
                                    min: 0,
                                    max: value.maxValue,
                                    divisions: 200,
                                    value: value.value,
                                    label: value.value.toStringAsFixed(1) + '%',
                                    activeColor: AppColors.primary.shade500,
                                    onChanged: (newValue) =>
                                        _restValue.value > 0 ||
                                                newValue < value.value
                                            ? _calculateHowMuchPercents(
                                                newValue, index)
                                            : null,
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                      'R\$ ${(historicNotifier.value.toListSum() * (value.value * 0.01)).toMoney()}'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      separatorBuilder: (_, index) =>
                          const Divider(color: Colors.transparent),
                      itemCount: _listOfTextInputs.length,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _calculateHowMuchPercents(double newValue, int index) {
    _listOfTextInputs[index].value.value = newValue;
    _calculatRest();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    _listOfTextInputs[index].notifyListeners();
  }

  void _calculatRest() {
    var _totalValue = 0.0;
    for (var item in _listOfTextInputs) {
      _totalValue += item.value.value;
    }

    _restValue.value = 100 - _totalValue;
  }

  void _addDivision(double newValue) {
    _numberOfDivisions.value = newValue;
    _calculatRest();

    if (newValue.toInt() > _listOfTextInputs.length) {
      while (newValue.toInt() > _listOfTextInputs.length) {
        if (_restValue.value <= 0) {
          return;
        }
        _listOfTextInputs.add(
          ValueNotifier<Percent>(
            Percent(
              value: 0,
              maxValue: _restValue.value,
            ),
          ),
        );
      }
      return;
    }
    if (newValue.toInt() < _listOfTextInputs.length) {
      while (newValue.toInt() < _listOfTextInputs.length) {
        _listOfTextInputs.removeLast();
        _calculatRest();
      }
      return;
    }
    return;
  }
}
