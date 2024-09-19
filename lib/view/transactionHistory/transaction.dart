import 'package:flutter/cupertino.dart';

import '../../utils/app_color_constant.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(color: AppColor.secondary60,);
  }
}
