import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';

class StatusCardWidget extends StatelessWidget {
  const StatusCardWidget({Key? key, required this.status}) : super(key: key);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: status.toLowerCase() == 'failed'
            ? AppColors.red
            : status.toLowerCase() == 'success'
                ? AppColors.green
                : AppColors.orange,
      ),
      child: Row(
        children: [
          status.toLowerCase() == 'failed'
              ?  Icon(
                  Icons.clear,
                  size: 15,
                  color: Theme.of(context).textTheme.bodyText1!.color!,
                )
              : status.toLowerCase() == 'success'
                  ?  Icon(
                      Icons.offline_pin_rounded,
                      size: 15,
                      color: Theme.of(context).textTheme.bodyText1!.color!,
                    )
                  :  SizedBox(
                      width: 13,
                      height: 13,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(context).textTheme.bodyText1!.color!,
                      ),
                    ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: TextWidget(
              text: status,
              textColor: Theme.of(context).textTheme.bodyText1!.color!,
              textSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
