import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/ui/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/text_extension.dart';
import '../../home_controller.dart';

// ignore: must_be_immutable
class EqualityTabAdapter extends StatefulWidget {
  EqualityTabAdapter({
    super.key,
    required double divisionValue,
    required double valueCalculated,
    required double valueComplete,
    required HomeController controller,
  })  : _valueComplete = valueComplete,
        _valueCalculated = valueCalculated,
        _divisionValue = divisionValue,
        _controller = controller;

  final HomeController _controller;
  final double _valueComplete;
  double _divisionValue;
  double _valueCalculated;

  @override
  State<EqualityTabAdapter> createState() => _EqualityTabAdapterState();
}

class _EqualityTabAdapterState extends State<EqualityTabAdapter> {
  final _calculateFormKey = GlobalKey<FormState>();
  final _divisionEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    _divisionEC.text = widget._divisionValue.toInt().toString();

    widget._valueCalculated = widget._valueComplete;
    widget._divisionValue = double.tryParse(_divisionEC.text) ?? 0;
    widget._valueCalculated /= widget._divisionValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _calculateFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _divisionEC,
                  decoration: const InputDecoration(
                    labelText: 'Value',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) =>
                      value == null || value.isEmpty || int.parse(value) < 1
                          ? 'Please add a valid value'
                          : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const Divider(color: Colors.transparent),
                ElevatedButton(
                  onPressed: () {
                    if (_calculateFormKey.currentState?.validate() ?? false) {
                      FocusManager.instance.primaryFocus?.unfocus();

                      widget._controller.updateTotalValue(_divisionEC.text);

                      setState(() {
                        widget._valueCalculated = widget._valueComplete;
                        widget._divisionValue =
                            double.tryParse(_divisionEC.text) ?? 0;
                        widget._valueCalculated /= widget._divisionValue;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary.shade500,
                  ),
                  child: const Text('Calculate'),
                ),
              ],
            ),
            Text(
              '\$ ${widget._valueCalculated.toMoney()}${widget._divisionValue > 1 ? ' / ${widget._divisionValue.toInt()}' : ''}',
              style: context.textTheme.displayLarge?.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
