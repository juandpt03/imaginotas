import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imaginotas/src/features/auth/presentation/bloc/auth/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(child: Text('Welcome to the Home Screen!')),

      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<AuthBloc>().logout(),
        child: const Icon(Icons.logout),
      ),
    );
  }
}
