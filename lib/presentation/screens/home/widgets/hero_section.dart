import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../providers/pet_provider.dart';
import '../../../../config/app_theme.dart';
import '../../../widgets/custom_button.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Consumer<PetProvider>(
          builder: (context, petProvider, child) {
            if (petProvider.pet != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.pets,
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Hey ${petProvider.pet!.name}!',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'We have personalized recommendations just for you',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'View Pet Profile',
                    onPressed: () => context.push('/pet-profile'),
                    backgroundColor: Colors.white,
                    textColor: AppTheme.primaryColor,
                  ),
                ],
              );
            }

            // No pet profile
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to CURAA',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Premium pet care products and services tailored for your furry friend',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Create Pet Profile',
                  onPressed: () => context.push('/pet-onboarding'),
                  backgroundColor: Colors.white,
                  textColor: AppTheme.primaryColor,
                  icon: Icons.add_circle_outline,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
