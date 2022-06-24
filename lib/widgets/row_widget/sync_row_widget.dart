import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';

class SyncRowWidget extends StatelessWidget {
  const SyncRowWidget(
      {Key? key, required this.synced, required this.text, this.onTap})
      : super(key: key);

  final String synced;
  final String text;
  final VoidCallback? onTap;

  // SyncController controller = Get.find<SyncController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: TextWidget(
                text: text,
                textColor: AppColors.grey,
                align: TextAlign.start,
              )),
          synced == AppStrings.txtSynced
              ? Row(
                  children: const [
                    TextWidget(
                      text: AppStrings.txtSynced,
                      textColor: AppColors.greenish,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.check_circle,
                        color: AppColors.greenish,
                      ),
                    ),
                  ],
                )
              : Container(
                  height: 40,
                  alignment: Alignment.center,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(), primary: AppColors.blue),
                    onPressed: onTap,
                    child: (synced == AppStrings.txtSyncing)
                        ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                              strokeWidth: 1.5,
                            ))
                        : const Text(AppStrings.txtSync),
                  ),
                )
        ],
      ),
    );
  }
}
