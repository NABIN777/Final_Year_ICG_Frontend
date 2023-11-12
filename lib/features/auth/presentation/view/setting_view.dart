// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:podtalk/features/auth/domain/entity/user_entity.dart';
// import 'package:podtalk/features/auth/presentation/viewmodel/auth_view_model.dart';
// import 'package:podtalk/features/auth/presentation/widget/change_username_view.dart';

// class Setting extends ConsumerStatefulWidget {
//   const Setting({super.key});

//   @override
//   ConsumerState<Setting> createState() => _SettingState();
// }

// class _SettingState extends ConsumerState<Setting> {
//   UserEntity? userEntity;

//   Future<void> _fetchPodcasts() async {
//     final authviewmodel = ref.read(authViewModelProvider.notifier);
//     print('data leko xa ?');
//     await authviewmodel.changeuser(context, userEntity!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Center(),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: Center(),
//             ),
//             const SizedBox(height: 20.0),
//             Consumer(
//               builder: (context, watch, child) {
//                 final authstate = ref.watch(authViewModelProvider);
//                 if (authstate.isLoading) {
//                   return const CircularProgressIndicator();
//                 }

//                 if (authstate.error != null) {
//                   return Text(
//                     'Error: ${authstate.error}',
//                     style: const TextStyle(
//                       color: Colors.red,
//                       fontSize: 16.0,
//                     ),
//                   );
//                 }

//                 final List<UserEntity>? user = authstate.users;
//                 print('user aayo ? $user');

//                 return Wrap(
//                   children: List.generate(user?.length ?? 0, (index) {
//                     UserEntity users = user![index];
//                     print('aako xa ?? ${users.id}');
//                     print('aako xa ?? ${users.username}');

//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ChangeUsernameView(
//                               user: users,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Container(
//                           // Your content here
//                           ),
//                     );
//                   }),
//                 );
//               },
//             ),
//             const SizedBox(height: 20.0),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text('Change Username'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ChangeUsernameView(
//                       user: userEntity!,
//                     ),
//                   ),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.delete),
//               title: const Text('Delete Account'),
//               onTap: () {
//                 // Handle delete account action
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
