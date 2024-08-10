import 'package:flutter/material.dart';

class QuantityDialog extends StatefulWidget {
  final int initialQuantity;
  final String productName;

  const QuantityDialog({
    super.key,
    required this.initialQuantity,
    required this.productName,
  });

  @override
  _QuantityDialogState createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<QuantityDialog> {
  late TextEditingController _quantityController;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _quantityController =
        TextEditingController(text: widget.initialQuantity.toString());
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  void _validateQuantity(String value) {
    int? quantity = int.tryParse(value);
    if (quantity == null || quantity < 1) {
      setState(() {
        errorMessage = 'Please enter a valid number greater than 0';
      });
    } else if (quantity >= 999) {
      setState(() {
        errorMessage = 'Quantity cannot be more than 999';
      });
    } else {
      setState(() {
        errorMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Dialog(
      child: Container(
        height: 180,
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              widget.productName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: width * 0.5,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
              ),
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: _quantityController,
                onChanged: _validateQuantity,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],
            const SizedBox(height: 16),
            SizedBox(
              width: width * 0.5,
              child: ElevatedButton(
                onPressed: errorMessage == null
                    ? () {
                        int quantity = int.parse(_quantityController.text);
                        Navigator.of(context).pop(quantity);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
