import 'package:dots_indicator/dots_indicator.dart';
import 'package:ekasir_app/core/assets/assets.gen.dart';
import 'package:ekasir_app/core/components/spaces.dart';
import 'package:ekasir_app/core/constants/colors.dart';
import 'package:ekasir_app/presentation/auth/pages/login_page.dart';
import 'package:ekasir_app/presentation/auth/pages/registration_page.dart';
import 'package:ekasir_app/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:ekasir_app/presentation/onboarding/bloc/onboarding_event.dart';
import 'package:ekasir_app/presentation/onboarding/bloc/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Onboarding extends StatelessWidget {
  final PageController controller = PageController(initialPage: 0);
  Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardingBloc, OnboardingStates>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              PageView(
                controller: controller,
                onPageChanged: (value) {
                  state.pageIndex = value;
                  BlocProvider.of<OnboardingBloc>(context)
                      .add(OnboardingEvents());
                },
                children: [
                  _page(
                    context: context,
                    pageIndex: 0,
                    imageUrl: Assets.images.onboarding1.path,
                    title: 'Welcome to Our POS Solution!',
                    desc: 'Transform Your Business with Ease.',
                  ),
                  _page(
                    context: context,
                    pageIndex: 1,
                    imageUrl: Assets.images.onboarding2.path,
                    title: 'Simplify Operations, Maximize Profits',
                    desc: 'Unleash the Power of POS',
                  ),
                  _page(
                    context: context,
                    pageIndex: 2,
                    imageUrl: Assets.images.onboarding3.path,
                    title: 'Your Success, Our Priority',
                    desc: 'Empowering Your Business Growth',
                  ),
                ],
              ),
              Positioned(
                bottom: 150,
                child: DotsIndicator(
                  dotsCount: 3,
                  position: state.pageIndex.toDouble(),
                  decorator: DotsDecorator(
                    color: AppColors.disabled,
                    activeColor: AppColors.primary,
                    size: const Size.square(9.0),
                    activeSize: const Size(36.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                child: Row(
                  children: [
                    Visibility(
                      visible: state.pageIndex != 3,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text('Next'),
                      ),
                    ),
                    SpaceWidth(100),
                    Visibility(
                      visible: state.pageIndex != 3,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return const RegistrationPage();
                            }),
                          );
                        },
                        child: Text('Get Started'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _page({
    pageIndex,
    imageUrl,
    title,
    desc,
    required BuildContext context,
  }) {
    return Column(
      children: [
        SpaceHeight(100),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Image.asset(
              Assets.images.logo.path,
              width: 100,
              height: 100,
            )),
        Image.asset(
          imageUrl,
        ),
        const SizedBox(height: 40),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
          selectionColor: AppColors.black,
        ),
        SpaceHeight(10),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: Text(
            desc,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
