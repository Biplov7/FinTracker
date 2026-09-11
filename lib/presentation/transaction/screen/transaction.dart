import 'package:fintracker/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
  const Transaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text("Transactions", style: TextTheme.of(context).titleMedium),
        actions: [
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: Icon(Icons.filter_list)),
            ],
          ),
        ],
      ),
      body: SafeArea(child: Padding(padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              
            ),
          )
        ],
      ),)),
    );
  }
}
