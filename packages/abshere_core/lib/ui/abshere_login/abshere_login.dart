import 'package:abshere_core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class AbshereLogin extends StatelessWidget {
  const AbshereLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Center(
        child: Text('Abshere Login'),
      ),
    );
  }
}
