import 'package:flutter/material.dart';

import '../../../../core/ui/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../models/percent_model.dart';

class PercentTabAdapter extends StatefulWidget {
  const PercentTabAdapter({
    super.key,
    required double valueComplete,
  }) : _valueComplete = valueComplete;

  final double _valueComplete;

  @override
  State<PercentTabAdapter> createState() => _PercentTabAdapterState();
}

class _PercentTabAdapterState extends State<PercentTabAdapter> {
  var numberOfDivisions = 1.0;
  var restValue = 100.0;
  var listOfTextInputs = List.generate(
    1,
    (index) => PercentModel(
      value: 0,
      maxValue: 100,
    ),
  );

  void calculateRest() {
    var totalValue = 0.0;
    for (var item in listOfTextInputs) {
      totalValue += item.value;
    }
    restValue = 100 - totalValue;
  }

  void addNewSlider(double newValue) {
    if (restValue > 0 || newValue < numberOfDivisions) {
      numberOfDivisions = newValue;
    }

    if (newValue.toInt() > listOfTextInputs.length) {
      while (newValue.toInt() > listOfTextInputs.length) {
        if (restValue > 0) {
          listOfTextInputs.add(
            PercentModel(
              value: 0,
              maxValue: restValue,
            ),
          );

          return;
        }
      }
    }

    if (newValue.toInt() < listOfTextInputs.length) {
      while (newValue.toInt() < listOfTextInputs.length) {
        listOfTextInputs.removeLast();
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'How many divisions? ${numberOfDivisions.toInt()}',
            style: const TextStyle(fontSize: 16),
          ),
          Slider(
            value: numberOfDivisions,
            divisions: 8,
            min: 1,
            max: 10,
            onChanged: (newValue) => setState(() => addNewSlider(newValue)),
            activeColor: AppColors.primary.shade900,
            label: '${numberOfDivisions.toInt()}',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${restValue.toStringAsFixed(1)} % rest',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) => Column(
                      children: [
                        Text(
                          'Position ${index + 1} have ${listOfTextInputs[index].value.toStringAsFixed(1)} %',
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Flexible(
                              flex: 10,
                              child: Slider(
                                min: 0,
                                max: listOfTextInputs[index].maxValue,
                                divisions: 200,
                                value: listOfTextInputs[index].value,
                                label:
                                    '${listOfTextInputs[index].value.toStringAsFixed(1)}%',
                                activeColor: AppColors.primary.shade500,
                                onChanged: (newValue) => setState(() {
                                  calculateRest();
                                  if (restValue > 0 ||
                                      newValue <
                                          listOfTextInputs[index].value) {
                                    listOfTextInputs[index].value = newValue;
                                  }
                                }),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Text(
                                '\$ ${(widget._valueComplete * (listOfTextInputs[index].value * 0.01)).toMoney()}',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    separatorBuilder: (_, index) => const SizedBox(height: 8),
                    itemCount: listOfTextInputs.length,
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
