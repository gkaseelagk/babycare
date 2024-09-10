
import 'package:flutter/material.dart';
import 'package:scratcher/widgets.dart';

class ScratchCardWidget extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final VoidCallback onTap;

  ScratchCardWidget({
    required this.imageUrl,
    required this.productName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scratcher(
      accuracy: ScratchAccuracy.high,
      color: Colors.grey,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imageUrl, fit: BoxFit.cover),
            SizedBox(height: 10),
            Text(
              productName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: onTap,
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}