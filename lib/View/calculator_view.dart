import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/calculator_controller.dart';

class CalculatorView extends StatelessWidget {
  CalculatorView({super.key});

  final CalculatorController controller = Get.put(CalculatorController());

  final List<String> buttons = [
    'sin', 'cos', 'tan', 'log', 'ln',
    '√', '^', '%', '(', ')',
    '7', '8', '9', '÷', 'DEL',
    '4', '5', '6', '×', 'C',
    '1', '2', '3', '-', 'Ans', // <-- Added Ans button here
    '0', '.', '=', '+', 'EXP', // <-- Added EXP button here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              Get.changeThemeMode(
                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => _showHistory(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Obx(
              () => Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Get.isDarkMode ? Colors.black54 : Colors.grey[200],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Text(
                        controller.input.value,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      controller.result.value,
                      style: TextStyle(
                        fontSize: 24,
                        color: Get.isDarkMode ? Colors.grey : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final btn = buttons[index];
                return btn.isEmpty
                    ? const SizedBox.shrink()
                    : GestureDetector(
                        onTap: () {
                          if (btn == 'C') {
                            controller.clear();
                          } else if (btn == '=') {
                            controller.calculate();
                          } else if (btn == 'DEL') {
                            controller.delete();
                          } else if (btn == 'Ans') {
                            controller.appendValue(controller.result.value);
                          } else if (btn == 'EXP') {
                            controller.appendValue('e^');
                          } else {
                            controller.appendValue(btn);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: _isOperator(btn)
                                ? Colors.blue
                                : (Get.isDarkMode
                                    ? Colors.grey[800]
                                    : Colors.grey[300]),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              btn,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: _isOperator(btn)
                                    ? Colors.white
                                    : (Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _isOperator(String x) {
    return [
      '+',
      '-',
      '×',
      '÷',
      '=',
      'sin',
      'cos',
      'tan',
      'log',
      'ln',
      '√',
      '^',
      '%'
    ].contains(x);
  }

  void _showHistory(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: 300,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.black : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Calculation History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.history.length,
                    itemBuilder: (context, index) {
                      final item = controller.history[index];
                      return ListTile(
                        title: Text(item),
                        onLongPress: () {
                          controller.history.removeAt(index);
                          Get.snackbar('Deleted', 'History item removed.');
                        },
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
