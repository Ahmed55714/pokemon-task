import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/text_theme.dart';
import '../../../../helper/responsive_helper.dart';

class DetailCard extends StatelessWidget {
  final String title;
  final String value;

  const DetailCard({Key? key, required this.title, required this.value})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Card(
      margin: EdgeInsets.symmetric(vertical: responsive.height(0.012)),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsive.width(0.04)),
      ),
      shadowColor: AppColors.colorBlue.withOpacity(0.2),
      child: Padding(
        padding: EdgeInsets.all(responsive.width(0.045)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(responsive),
            SizedBox(height: responsive.height(0.01)),
            _buildValue(responsive),
          ],
        ),
      ),
    );
  }

  // title text.
  Widget _buildTitle(ResponsiveHelper responsive) {
    return Row(
      children: [
        Text(
          title,
          style: TextThemes.headertextDetals.copyWith(
            fontSize: responsive.width(0.045),
          ),
        ),
      ],
    );
  }

  // value text.
  Widget _buildValue(ResponsiveHelper responsive) {
    return Text(
      value,
      style: TextThemes.textDetals.copyWith(fontSize: responsive.width(0.04)),
    );
  }
}
