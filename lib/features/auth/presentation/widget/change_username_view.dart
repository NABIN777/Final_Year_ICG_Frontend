import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../domain/entity/user_entity.dart';
import '../viewmodel/auth_view_model.dart';

// ignore: must_be_immutable
class ChangeUsernameView extends ConsumerStatefulWidget {
  UserEntity user;
  ChangeUsernameView({super.key, required this.user});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangeUsernameViewState();
}

class _ChangeUsernameViewState extends ConsumerState<ChangeUsernameView> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _newUsernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Change Username')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: _newUsernameController,
                decoration: const InputDecoration(labelText: 'New Username'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    var user = UserEntity(
                        firstname: _newUsernameController.text,
                        email: widget.user.email,
                        password: widget.user.password,
                        id: '${widget.user.id}',
                        lastname: widget.user.lastname);

                    ref
                        .read(authViewModelProvider.notifier)
                        .changeuser(context, user);

                    if (authState.error != null) {
                      showSnackBar(
                        message: authState.error.toString(),
                        context: context,
                        color: Colors.red,
                      );
                    } else {
                      showSnackBar(
                        message: 'update successfully',
                        context: context,
                      );
                    }
                  }
                },
                child: const Text(
                  'Update Username',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
