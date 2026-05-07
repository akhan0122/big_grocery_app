import 'package:biggroceryapp/core/global_widgets/app_elevated_button.dart';
import 'package:biggroceryapp/core/global_widgets/app_text.dart';
import 'package:biggroceryapp/core/global_widgets/custom_appbar_widget.dart';
import 'package:biggroceryapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int _currentStep = 2;
  int _selectedMethod = 1;
  bool _saveCard = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const AppBarWidget(title: 'Payment Method', showBackButton: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 22.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _CheckoutStepper(
                currentStep: _currentStep,
                onStepTap: (step) => setState(() => _currentStep = step),
              ),
              SizedBox(height: 18.h),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: _currentStep == 0
                    ? _CheckoutStepCard(
                        key: const ValueKey('delivery'),
                        icon: Icons.local_shipping_outlined,
                        title: 'Delivery',
                        subtitle: 'Standard delivery selected',
                        buttonText: 'Continue to address',
                        onPressed: () => setState(() => _currentStep = 1),
                      )
                    : _currentStep == 1
                    ? _CheckoutStepCard(
                        key: const ValueKey('address'),
                        icon: Icons.location_on_outlined,
                        title: 'Address',
                        subtitle: 'Home address selected',
                        buttonText: 'Continue to payment',
                        onPressed: () => setState(() => _currentStep = 2),
                      )
                    : _PaymentStepForm(
                        key: const ValueKey('payment'),
                        selectedMethod: _selectedMethod,
                        saveCard: _saveCard,
                        onMethodChanged: (method) {
                          setState(() => _selectedMethod = method);
                        },
                        onSaveCardChanged: (value) {
                          setState(() => _saveCard = value);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckoutStepper extends StatelessWidget {
  const _CheckoutStepper({required this.currentStep, required this.onStepTap});

  final int currentStep;
  final ValueChanged<int> onStepTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StepItem(
          label: 'DELIVERY',
          stepNumber: 1,
          state: _stateFor(0),
          onTap: () => onStepTap(0),
        ),
        Expanded(child: _StepLine(isActive: currentStep >= 1)),
        _StepItem(
          label: 'ADDRESS',
          stepNumber: 2,
          state: _stateFor(1),
          onTap: () => onStepTap(1),
        ),
        Expanded(child: _StepLine(isActive: currentStep >= 2)),
        _StepItem(
          label: 'PAYMENT',
          stepNumber: 3,
          state: _stateFor(2),
          onTap: () => onStepTap(2),
        ),
      ],
    );
  }

  _StepState _stateFor(int step) {
    if (currentStep > step) return _StepState.complete;
    if (currentStep == step) return _StepState.active;
    return _StepState.pending;
  }
}

enum _StepState { complete, active, pending }

class _StepItem extends StatelessWidget {
  const _StepItem({
    required this.label,
    required this.stepNumber,
    required this.state,
    required this.onTap,
  });

  final String label;
  final int stepNumber;
  final _StepState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isPending = state == _StepState.pending;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32.r),
      child: SizedBox(
        width: 72.w,
        child: Column(
          children: [
            Container(
              width: 34.r,
              height: 34.r,
              decoration: BoxDecoration(
                color: isPending
                    ? const Color(0xFFD9D9D9)
                    : AppColors.primaryDark,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: state == _StepState.complete
                    ? Icon(Icons.check, color: Colors.white, size: 18.sp)
                    : Text(
                        '$stepNumber',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isPending
                    ? const Color(0xFFB8B8B8)
                    : AppColors.textSecondary,
                fontSize: 8.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepLine extends StatelessWidget {
  const _StepLine({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.4.h,
      color: (isActive ? AppColors.primaryDark : const Color(0xFFD9D9D9))
          .withValues(alpha: isActive ? 0.55 : 1),
    );
  }
}

class _CheckoutStepCard extends StatelessWidget {
  const _CheckoutStepCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: const Color(0xFFE9E9E9)),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryDark, size: 38.sp),
          SizedBox(height: 10.h),
          AppText(
            text: title,
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          AppText(
            text: subtitle,
            color: AppColors.textSecondary,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 18.h),
          AppElevatedButton(
            height: 50.h,
            borderRadius: BorderRadius.circular(4.r),
            title: buttonText,
            titleStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}

class _PaymentStepForm extends StatelessWidget {
  const _PaymentStepForm({
    super.key,
    required this.selectedMethod,
    required this.saveCard,
    required this.onMethodChanged,
    required this.onSaveCardChanged,
  });

  final int selectedMethod;
  final bool saveCard;
  final ValueChanged<int> onMethodChanged;
  final ValueChanged<bool> onSaveCardChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: _PaymentOptionTile(
                icon: Icons.paypal,
                label: 'Paypal',
                isSelected: selectedMethod == 0,
                onTap: () => onMethodChanged(0),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _PaymentOptionTile(
                icon: Icons.credit_card,
                label: 'Credit Card',
                isSelected: selectedMethod == 1,
                onTap: () => onMethodChanged(1),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _PaymentOptionTile(
                icon: Icons.apple,
                label: 'Apple pay',
                isSelected: selectedMethod == 2,
                onTap: () => onMethodChanged(2),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        const _PaymentCardPreview(),
        SizedBox(height: 12.h),
        const _PaymentTextField(
          icon: Icons.account_circle_outlined,
          hint: 'Name on the card',
        ),
        const _PaymentTextField(icon: Icons.credit_card, hint: 'Card number'),
        Row(
          children: [
            const Expanded(
              child: _PaymentTextField(
                icon: Icons.calendar_today_outlined,
                hint: 'Month / Year',
              ),
            ),
            SizedBox(width: 2.w),
            const Expanded(
              child: _PaymentTextField(icon: Icons.lock_outline, hint: 'CVV'),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Switch(
              value: saveCard,
              activeThumbColor: AppColors.primaryDark,
              activeTrackColor: AppColors.primaryDark.withValues(alpha: 0.28),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: onSaveCardChanged,
            ),
            SizedBox(width: 4.w),
            AppText(
              text: 'Save this card',
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ],
        ),
        SizedBox(height: 12.h),
        AppElevatedButton(
          height: 58.h,
          borderRadius: BorderRadius.circular(4.r),
          title: 'Make a payment',
          titleStyle: TextStyle(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _PaymentOptionTile extends StatelessWidget {
  const _PaymentOptionTile({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.r),
        child: Container(
          height: 92.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(
              color: isSelected ? AppColors.primaryDark : Colors.transparent,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color(0xFF9B9B9B), size: 24.sp),
              SizedBox(height: 10.h),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentCardPreview extends StatelessWidget {
  const _PaymentCardPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20.w,
            top: -12.h,
            child: _CardBubble(size: 48.r, color: const Color(0xFF8CD840)),
          ),
          Positioned(
            right: 16.w,
            top: 54.h,
            child: _CardBubble(size: 14.r, color: const Color(0xFFF75F5F)),
          ),
          Positioned(
            right: -8.w,
            bottom: 26.h,
            child: _CardBubble(size: 42.r, color: const Color(0xFF8CD840)),
          ),
          Positioned(
            left: 18.w,
            top: 20.h,
            child: Row(
              children: [
                _CardBubble(size: 28.r, color: const Color(0xFFFF5F45)),
                Transform.translate(
                  offset: Offset(-10.w, 0),
                  child: _CardBubble(
                    size: 28.r,
                    color: const Color(0xFFF5B332),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 14.w,
            top: 12.h,
            child: Icon(Icons.more_vert, color: Colors.white, size: 20.sp),
          ),
          Positioned(
            left: 18.w,
            top: 72.h,
            child: Text(
              'XXXX   XXXX   XXXX   8790',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Positioned(
            left: 18.w,
            bottom: 18.h,
            child: _CardInfo(label: 'CARD HOLDER', value: 'RUSSELL AUSTIN'),
          ),
          Positioned(
            right: 18.w,
            bottom: 18.h,
            child: const _CardInfo(label: 'EXPIRES', value: '01 / 22'),
          ),
        ],
      ),
    );
  }
}

class _CardBubble extends StatelessWidget {
  const _CardBubble({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _CardInfo extends StatelessWidget {
  const _CardInfo({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 7.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 9.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _PaymentTextField extends StatelessWidget {
  const _PaymentTextField({required this.icon, required this.hint});

  final IconData icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: TextFormField(
        style: TextStyle(fontSize: 13.sp, color: AppColors.textPrimary),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(icon, color: const Color(0xFFB3B3B3), size: 20.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.r),
            borderSide: const BorderSide(color: Color(0xFFE9E9E9)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.r),
            borderSide: const BorderSide(color: Color(0xFFE9E9E9)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.r),
            borderSide: const BorderSide(color: AppColors.primaryDark),
          ),
        ),
      ),
    );
  }
}
