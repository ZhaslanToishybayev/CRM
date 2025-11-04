/// Create Team Screen
/// Form for creating or editing a team

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/team_model.dart';
import '../providers/team_provider.dart';

class CreateTeamScreen extends ConsumerStatefulWidget {
  final TeamModel? team;
  final String? organizationId;
  final String? departmentId;

  const CreateTeamScreen({
    Key? key,
    this.team,
    this.organizationId,
    this.departmentId,
  }) : super(key: key);

  @override
  ConsumerState<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends ConsumerState<CreateTeamScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _memberLimitController = TextEditingController();

  String? _selectedIcon;
  String? _selectedColor;
  bool _isLoading = false;

  final List<Map<String, String>> _iconOptions = [
    {'name': 'group', 'label': 'Group'},
    {'name': 'code', 'label': 'Developers'},
    {'name': 'design_services', 'label': 'Designers'},
    {'name': 'campaign', 'label': 'Marketing'},
    {'name': 'sales', 'label': 'Sales'},
    {'name': 'support_agent', 'label': 'Support'},
  ];

  final List<String> _colorOptions = [
    '#2196F3', // Blue
    '#4CAF50', // Green
    '#FF9800', // Orange
    '#9C27B0', // Purple
    '#F44336', // Red
    '#009688', // Teal
    '#3F51B5', // Indigo
    '#E91E63', // Pink
  ];

  @override
  void initState() {
    super.initState();
    if (widget.team != null) {
      _nameController.text = widget.team!.name;
      _descriptionController.text = widget.team!.description ?? '';
      _memberLimitController.text = widget.team!.memberLimit?.toString() ?? '';
      _selectedIcon = widget.team!.icon;
      _selectedColor = widget.team!.color;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _memberLimitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.team != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Team' : 'Create Team'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveTeam,
            child: _isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Team name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Team Name *',
                  hintText: 'Enter team name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a team name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Team description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter team description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Icon selection
              const Text(
                'Team Icon',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _iconOptions.map((option) {
                  final isSelected = _selectedIcon == option['name'];
                  return ChoiceChip(
                    label: Text(option['label']!),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedIcon = selected ? option['name'] : null;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Color selection
              const Text(
                'Team Color',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _colorOptions.map((color) {
                  final isSelected = _selectedColor == color;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedColor = isSelected ? null : color;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _parseColor(color),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.black : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Member limit
              TextFormField(
                controller: _memberLimitController,
                decoration: const InputDecoration(
                  labelText: 'Member Limit',
                  hintText: 'Leave empty for no limit',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Info box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[700]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'You can add team members after creating the team.',
                        style: TextStyle(color: Colors.blue[700]),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveTeam,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(isEditing ? 'Update Team' : 'Create Team'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveTeam() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final notifier = ref.read(teamNotifierProvider.notifier);

      if (widget.team != null) {
        // Update existing team
        await notifier.updateTeam(
          teamId: widget.team!.id,
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          icon: _selectedIcon,
          color: _selectedColor,
          memberLimit: _memberLimitController.text.trim().isEmpty
              ? null
              : int.parse(_memberLimitController.text.trim()),
        );
      } else {
        // Create new team
        // TODO: Get current user ID from auth provider
        final currentUserId = 'current_user_id';

        await notifier.createTeam(
          name: _nameController.text.trim(),
          departmentId: widget.departmentId!,
          organizationId: widget.organizationId!,
          createdBy: currentUserId,
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          icon: _selectedIcon,
          color: _selectedColor,
          memberLimit: _memberLimitController.text.trim().isEmpty
              ? null
              : int.parse(_memberLimitController.text.trim()),
        );
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Color _parseColor(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    final color = int.parse(hexColor, radix: 16);
    return Color(color | 0xFF000000);
  }
}
