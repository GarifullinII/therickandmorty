import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therickandmorty/common/app_colors.dart';
import 'package:therickandmorty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'feature/presentation/pages/person_screen.dart';
import 'locator_service.dart' as di;
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonListCubit>(
          create: (context) => sl<PersonListCubit>()..loadPerson(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          backgroundColor: AppColors.mainBackground,
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        home: const HomePage(),
      ),
    );
  }
}
