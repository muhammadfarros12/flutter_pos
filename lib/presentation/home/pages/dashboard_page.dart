import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos/data/datasources/auth_local_datasource.dart';
import 'package:flutter_pos/data/models/response/auth_response_model.dart';
import 'package:flutter_pos/presentation/auth/pages/login_page.dart';
import 'package:flutter_pos/presentation/home/bloc/logout/logout_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('dashboard'),
        actions: [
          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              state.maybeWhen(
                  orElse: () {},
                  success: () {
                    AuthLocalDatasource().removeAuthData();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  });
            },
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    context.read<LogoutBloc>().add(LogoutEvent.logout());
                  },
                  icon: const Icon(Icons.logout));
            },
          )
        ],
      ),
      body: const Center(
        child: Text('Dashboard'),
      ),
    );
  }
}
