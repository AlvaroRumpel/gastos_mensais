import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/notifier/change_notifier_listener.dart';
import '../../core/routes/routes.dart';
import '../../core/ui/theme/app_colors.dart';
import '../../core/ui/widgets/messages.dart';
import '../../core/utils/extensions.dart';
import '../../core/utils/text_extension.dart';
import '../../models/pattern_model.dart';
import '../navigatior/navigator_controller.dart';
import 'overhead_controller.dart';

class OverheadPage extends StatefulWidget {
  const OverheadPage({super.key, required OverheadController controller})
      : _controller = controller;

  final OverheadController _controller;

  @override
  State<OverheadPage> createState() => _OverheadPageState();
}

class _OverheadPageState extends State<OverheadPage> {
  @override
  void initState() {
    super.initState();

    ChangeNotifierListener(
      changeNotifierController: context.read<OverheadController>(),
    ).listener(
      context: context,
      errorVoidCallback: (notifier, listenerInstance) {
        Messages.of(context).showError(notifier.errorMessage);
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget._controller.searchPatterns();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OVERHEAD'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: Selector<OverheadController, List<PatternModel>>(
              selector: (context, controller) => controller.listOfPatterns,
              builder: (context, value, _) => Visibility(
                visible: value.isNotEmpty,
                replacement: const SizedBox.shrink(),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 16,
                    ),
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
                    child: ExpansionTile(
                      backgroundColor: AppColors.white.shade50,
                      iconColor: AppColors.primary,
                      collapsedIconColor: AppColors.primary,
                      title: Text(
                        value[index].name,
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: AppColors.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      children: [
                        ...value[index]
                            .expenses!
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      e.expenseName,
                                      style:
                                          context.textTheme.bodyLarge?.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '\$',
                                          style: context.textTheme.bodyLarge
                                              ?.copyWith(
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            e.expenseValue.toMoney(),
                                            textAlign: TextAlign.center,
                                            style: context.textTheme.bodyLarge
                                                ?.copyWith(
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        ElevatedButton.icon(
                          onPressed: () async {
                            context
                                .read<NavigatorController>()
                                .changePage(pageIndex: 1);
                            Navigator.pushNamed(
                              context,
                              Routes.homeRoute,
                              arguments: value[index],
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                              MediaQuery.of(context).size.width * .85,
                              32,
                            ),
                          ),
                          icon: const Icon(Icons.open_with_rounded),
                          label: const Text('Use in calculator'),
                        ),
                      ],
                    ),
                  ),
                  itemCount: value.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
