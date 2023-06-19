import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:transactions/actions.dart';
import 'package:transactions/app_state.dart';
import 'package:transactions/auth/constants.dart';
import 'package:transactions/models/transaction.dart';
import 'package:transactions/utils.dart';
import 'package:uuid/uuid.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController commissionController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  OperationType selectedOperationType = OperationType.deposit;

  DateTime dt = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildDateTimeButton(),
                  buildDateTimeText(dateTime: dt),
                ],
              ),
              const SizedBox(height: 8.0),
              buildFormField(
                controller: amountController,
                hintText: 'Amount',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validatorText: 'Please provide Amount',
              ),
              const SizedBox(height: 8.0),
              buildFormField(
                controller: commissionController,
                hintText: 'Commission',
                counterText: '',
                maxLength: 20,
                validatorText: 'Please provide Commission',
              ),
              const SizedBox(height: 8.0),
              buildFormField(
                controller: totalController,
                hintText: 'Total',
                keyboardType: TextInputType.number,
                validatorText: 'Please provide Total',
              ),
              const SizedBox(height: 8.0),
              buildFormField(
                controller: numberController,
                hintText: 'Transaction Number',
                counterText: '',
                maxLength: 20,
                validatorText: 'Please provide transaction number',
              ),
              const SizedBox(height: 16.0),
              buildOperationTypeDropdown(),
              const SizedBox(height: 24.0),
              buildCreateTransactionButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDateTimeButton() {
    return MaterialButton(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(22),
          ),
          side: BorderSide(color: Colors.white, width: 0.5)),
      onPressed: () async {
        final DateTime? result = await showDateTimePicker(context: context);
        if (result != null) {
          setState(() {
            dt = result;
          });
        }
      },
      child: const Text('Pick date and time'),
    );
  }

  Widget buildFormField({
    required TextEditingController controller,
    required String hintText,
    String? counterText,
    int? maxLength,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    required String validatorText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: kTextFieldDecoration.copyWith(
        hintText: hintText,
        counterText: counterText,
      ),
      maxLength: maxLength,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorText;
        }
        return null;
      },
    );
  }

  Widget buildOperationTypeDropdown() {
    return DropdownButtonFormField<OperationType>(
      value: selectedOperationType,
      onChanged: (OperationType? newValue) {
        setState(() {
          selectedOperationType = newValue!;
        });
      },
      items: OperationType.values.map((OperationType operationType) {
        return DropdownMenuItem<OperationType>(
          value: operationType,
          child: Text(operationType.toString().split('.').last),
        );
      }).toList(),
      decoration: const InputDecoration(
        labelText: 'Operation Type',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget buildCreateTransactionButton() {
    return StoreConnector<AppState, VoidCallback>(
      converter: (store) => () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          store.dispatch(
            AddTransactionAction(
              transaction: Transaction(
                id: const Uuid().v1(),
                transaction_date: dt,
                amount: int.parse(amountController.text),
                commission: commissionController.text,
                total: double.parse(totalController.text),
                transaction_number: numberController.text,
                operation_type: selectedOperationType,
              ),
            ),
          );
        }
      },
      builder: (_, callback) {
        return ElevatedButton(
          onPressed: callback,
          child: const Text('Create Transaction'),
        );
      },
    );
  }
}

Future<DateTime?> showDateTimePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  initialDate ??= DateTime.now();
  firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
  lastDate ??= initialDate.add(const Duration(days: 7));

  final DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  if (selectedDate == null) return null;

  if (!context.mounted) return selectedDate;

  final TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(selectedDate),
  );

  return selectedTime == null
      ? selectedDate
      : DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
}
