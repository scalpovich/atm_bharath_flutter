import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';

class MoneyTransferIFSCSearchCard extends StatelessWidget {
  const MoneyTransferIFSCSearchCard(
      {Key? key,
      required this.bank,
      required this.branch,
      required this.state,
      required this.district,
      required this.onTap,
      required this.ifscCode})
      : super(key: key);

  final String bank;
  final String branch;
  final String state;
  final String district;
  final String ifscCode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 8.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: bank,
                        textColor: AppColors.grey,
                        textSize: 14,
                      ),
                      TextWidget(
                        text: branch,
                        textColor: AppColors.grey,
                        textSize: 12,
                      ),
                      TextWidget(
                        text: state,
                        textColor: AppColors.grey,
                        textSize: 12,
                      ),
                      TextWidget(
                        text: district,
                        textColor: AppColors.grey,
                        textSize: 12,
                      ),
                    ],
                  )),
              Expanded(
                  flex: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blue, width: 1)),
                    child:
                        TextWidget(text: ifscCode, textColor: AppColors.blue),
                  ))
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
