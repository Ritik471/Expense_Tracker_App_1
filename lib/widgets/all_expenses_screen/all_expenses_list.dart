import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/database_provider.dart';
import '../expense_screen/expense_card.dart';

class AllExpensesList extends StatelessWidget {
  const AllExpensesList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var list = db.expenses;
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              list.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: list.length,
                        itemBuilder: (_, i) => ExpenseCard(list[i]),
                      ),
                    )
                  : const Center(
                      child: Text('No Entries Found'),
                    ),
            ],
          ),
        );
      },
    );
  }
}
