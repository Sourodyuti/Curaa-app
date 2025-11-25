import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/pet_provider.dart';
import '../../../data/models/pet_model.dart';
import '../../../config/app_theme.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class PetOnboardingScreen extends StatefulWidget {
  const PetOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<PetOnboardingScreen> createState() => _PetOnboardingScreenState();
}

class _PetOnboardingScreenState extends State<PetOnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  String _selectedAge = 'Adult';
  String _selectedPhilosophy = 'Budget-friendly & reliable';
  bool _hasHealthIssues = false;
  final List<String> _healthIssues = [];
  final _healthIssueController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _healthIssueController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final petProvider = context.read<PetProvider>();
    final userId = ''; // Get from auth provider or storage

    final pet = PetModel(
      userId: userId,
      name: _nameController.text.trim(),
      breed: _breedController.text.trim(),
      age: _selectedAge,
      foodPhilosophy: _selectedPhilosophy,
      hasHealthIssues: _hasHealthIssues,
      healthIssues: _healthIssues,
      profileCompleted: true,
    );

    final success = await petProvider.createPet(pet);

    if (success && mounted) {
      context.go('/');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pet profile created successfully!'),
          backgroundColor: AppTheme.accentColor,
        ),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(petProvider.error ?? 'Failed to create profile'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  List<Step> _buildSteps() {
    return [
      // Step 1: Basic Info
      Step(
        title: const Text('Basic Info'),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        content: Column(
          children: [
            CustomTextField(
              controller: _nameController,
              label: 'Pet\'s Name',
              hint: 'What do you call your furry friend?',
              prefixIcon: const Icon(Icons.pets),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your pet\'s name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _breedController,
              label: 'Breed',
              hint: 'What breed is your pet?',
              prefixIcon: const Icon(Icons.category_outlined),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the breed';
                }
                return null;
              },
            ),
          ],
        ),
      ),

      // Step 2: Age
      Step(
        title: const Text('Age'),
        isActive: _currentStep >= 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How old is your pet?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ...PetAge.values.map((age) {
              return RadioListTile<String>(
                title: Text(age.value),
                value: age.value,
                groupValue: _selectedAge,
                activeColor: AppTheme.primaryColor,
                onChanged: (value) {
                  setState(() {
                    _selectedAge = value!;
                  });
                },
              );
            }).toList(),
          ],
        ),
      ),

      // Step 3: Food Philosophy
      Step(
        title: const Text('Food'),
        isActive: _currentStep >= 2,
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What\'s your food philosophy?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ...FoodPhilosophy.values.map((philosophy) {
              return RadioListTile<String>(
                title: Text(philosophy.value),
                value: philosophy.value,
                groupValue: _selectedPhilosophy,
                activeColor: AppTheme.primaryColor,
                onChanged: (value) {
                  setState(() {
                    _selectedPhilosophy = value!;
                  });
                },
              );
            }).toList(),
          ],
        ),
      ),

      // Step 4: Health Issues
      Step(
        title: const Text('Health'),
        isActive: _currentStep >= 3,
        state: _currentStep > 3 ? StepState.complete : StepState.indexed,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Any health issues?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('My pet has health issues'),
              value: _hasHealthIssues,
              activeColor: AppTheme.primaryColor,
              onChanged: (value) {
                setState(() {
                  _hasHealthIssues = value;
                  if (!value) {
                    _healthIssues.clear();
                  }
                });
              },
            ),
            if (_hasHealthIssues) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _healthIssueController,
                      decoration: const InputDecoration(
                        hintText: 'Add health issue',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    color: AppTheme.primaryColor,
                    onPressed: () {
                      if (_healthIssueController.text.isNotEmpty) {
                        setState(() {
                          _healthIssues.add(_healthIssueController.text);
                          _healthIssueController.clear();
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: _healthIssues.map((issue) {
                  return Chip(
                    label: Text(issue),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () {
                      setState(() {
                        _healthIssues.remove(issue);
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Onboarding'),
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 3) {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _currentStep += 1;
                });
              }
            } else {
              _handleSubmit();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep -= 1;
              });
            }
          },
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Consumer<PetProvider>(
                      builder: (context, petProvider, child) {
                        return CustomButton(
                          text: _currentStep < 3 ? 'Continue' : 'Complete',
                          onPressed: details.onStepContinue!,
                          isLoading: petProvider.isLoading,
                        );
                      },
                    ),
                  ),
                  if (_currentStep > 0) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        text: 'Back',
                        onPressed: details.onStepCancel!,
                        isOutlined: true,
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
          steps: _buildSteps(),
        ),
      ),
    );
  }
}
