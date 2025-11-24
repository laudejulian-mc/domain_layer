import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../membership/providers.dart';
import '../../membership/membership_state.dart';
import '../../../domain/entities/user.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(membershipNotifierProvider) as MembershipState;
    final notifier = ref.read(membershipNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(labelText: 'Email'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'password',
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(6),
                ]),
              ),
              const SizedBox(height: 12),
              FormBuilderDropdown<UserRole>(
                name: 'role',
                decoration: const InputDecoration(labelText: 'Role'),
                initialValue: UserRole.member,
                items: UserRole.values
                    .map((r) => DropdownMenuItem(value: r, child: Text(r.toString().split('.').last)))
                    .toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: state.status == MembershipStatus.loading
                    ? null
                    : () {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          final values = _formKey.currentState!.value;
                          notifier.register(values['email'] as String, values['password'] as String, values['role'] as UserRole);
                        }
                      },
                child: state.status == MembershipStatus.loading
                    ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator())
                    : const Text('Create Account'),
              ),
              if (state.errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(state.errorMessage!, style: const TextStyle(color: Colors.red)),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
