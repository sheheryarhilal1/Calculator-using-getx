import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorController extends GetxController {
  var input = ''.obs;
  var result = ''.obs;
  var history = <String>[].obs;  // new

  void appendValue(String value) {
    input.value += value;
  }

  void clear() {
    input.value = '';
    result.value = '';
  }

  void delete() {
    if (input.isNotEmpty) {
      input.value = input.value.substring(0, input.value.length - 1);
    }
  }

  void calculate() {
    try {
      String expression = input.value;
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');
      expression = expression.replaceAll('√', 'sqrt');

      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      result.value = eval.toString();

      // Save to history
      history.insert(0, '${input.value} = ${result.value}');
      if (history.length > 10) {
        history.removeLast(); // only last 10
      }

      input.value = '';
    } catch (e) {
      result.value = 'Error';
    }
  }
}
