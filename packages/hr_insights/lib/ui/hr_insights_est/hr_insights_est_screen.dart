import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_insights/data/res/strings/hr_insights_navigator_strings.dart';
import 'package:hr_insights/hr_insights.dart';
import 'package:hr_insights/widgets/custom_button.dart';

class HrInsightsEstScreen extends StatelessWidget {
  const HrInsightsEstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController establishmentIdController =
        TextEditingController();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.h),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: establishmentIdController,
                decoration: InputDecoration(
                  labelText: 'Establishment ID',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),
              CustomButton(
                label: "Login",
                onTap: () {
                  final establishmentId = establishmentIdController.text;
                  if (establishmentId.isEmpty) {
                    // Show an error message for empty input
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Please enter an establishment ID')),
                    );
                    return;
                  }
                  if (int.tryParse(establishmentId) == null) {
                    // Show an error message for invalid number
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter a valid number')),
                    );
                    return;
                  }

                  // If input is valid, proceed with the login logic
                  SharedPreferencesUtils().setString('estId', establishmentId);
                  print('navigating');
                  Navigator.pushReplacementNamed(
                    context,
                    HrInsightsNavigatorStrings.hrInsightsHooksRoute,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
