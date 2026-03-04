part of '../main.dart';

class RootLayout extends ConsumerStatefulWidget {
  const RootLayout({super.key});

  @override
  ConsumerState<RootLayout> createState() => _RootLayoutState();
}

class _RootLayoutState extends ConsumerState<RootLayout> {
  int _currentIndex = 0;

  void _showAddClientDialog() {
    // Получаем состояние CRM страницы через контекст
    final crmState = context.findAncestorStateOfType<_CRMPageState>();
    if (crmState != null) {
      crmState._showAddClientDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: const Key('root_layout_scaffold'),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          DashboardPage(
            onNavigateToCRM: () {
              setState(() {
                _currentIndex = 2;
              });
            },
            onNavigateToTasks: () {
              setState(() {
                _currentIndex = 1;
              });
            },
            onNavigateToReports: () {
              setState(() {
                _currentIndex = 3;
              });
            },
            onShowAddTaskDialog: () {
              _showAddTaskDialog(context);
            },
            onShowAddClientDialog: () {
              _showAddClientDialog();
            },
          ),
          const TasksPage(),
          const CRMPage(),
          const ReportsPage(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.6),
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? const Color(0x33000000)
                    : const Color(0x140F172A),
                blurRadius: 24,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.dashboard_outlined,
                    key: Key('nav_dashboard'),
                  ),
                  activeIcon: Icon(Icons.dashboard, key: Key('nav_dashboard')),
                  label: 'Главная',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.task_outlined, key: Key('nav_tasks')),
                  activeIcon: Icon(Icons.task, key: Key('nav_tasks')),
                  label: 'Задачи',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_outline, key: Key('nav_crm')),
                  activeIcon: Icon(Icons.people, key: Key('nav_crm')),
                  label: 'CRM',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.analytics_outlined, key: Key('nav_reports')),
                  activeIcon: Icon(Icons.analytics, key: Key('nav_reports')),
                  label: 'Отчеты',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline, key: Key('nav_profile')),
                  activeIcon: Icon(Icons.person, key: Key('nav_profile')),
                  label: 'Профиль',
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton(
              key: const Key('fab_add_task'),
              tooltip: 'Добавить задачу',
              onPressed: () {
                _showAddTaskDialog(context);
              },
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.add, size: 28),
            )
          : _currentIndex == 2
          ? FloatingActionButton(
              key: const Key('fab_add_client'),
              tooltip: 'Добавить клиента',
              onPressed: () {
                _showAddCRMItemDialog(context);
              },
              backgroundColor: const Color(0xFF8B5CF6),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.add, size: 28),
            )
          : null,
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddTaskBottomSheet(),
    );
  }

  void _showAddCRMItemDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddClientBottomSheet(),
    );
  }
}

// ========== DASHBOARD PAGE ==========
