import 'package:flutter/material.dart';
import '../widgets/category_screen/category_fetcher.dart';
import '../widgets/expense_form.dart';
import '../screens/pdf_screen.dart';
import '../screens/set_reminder_screen.dart';

class CategoryScreen extends StatefulWidget {
  static const name = '/category_screen';

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              _isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
              color: _isDarkMode ? Colors.yellow : Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            },
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                _buildPopupMenuItem(
                  icon: Icons.notification_add,
                  text: 'Set Reminder',
                  value: 'set_reminder',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SetReminderScreen(),
                      ),
                    );
                  },
                ),
                _buildPopupMenuItem(
                  icon: Icons.notifications,
                  text: 'Notifications',
                  value: 'notifications',
                  onPressed: () {
                    print('Notifications');
                  },
                ),
                _buildPopupMenuItem(
                  icon: Icons.picture_as_pdf,
                  text: 'Export to PDF',
                  value: 'export_pdf',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PdfScreen(),
                      ),
                    );
                  },
                ),
              ];
            },
          ),
        ],
      ),
      body: const CategoryFetcher(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const ExpenseForm(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem({
    required IconData icon,
    required String text,
    required String value,
    required Function? onPressed,
  }) {
    return PopupMenuItem(
      child: Row(
        children: <Widget>[
          Icon(icon),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
      value: value,
      onTap: onPressed != null ? () => onPressed() : null,
    );
  }
}
