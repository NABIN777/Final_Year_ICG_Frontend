import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../config/constants/hive_table_constant.dart';

final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Hive Adapters
    // Hive.registerAdapter(HomeHiveModelAdapter());

    // Add dummy data
    // await addDummyPosts();
  }

  Future<void> addPost(HomeHiveModel post) async {
    var box = await Hive.openBox<HomeHiveModel>(HiveTableConstant.postBox);
    await box.add(post);
  }

  Future<List<HomeHiveModel>> getAllPosts() async {
    var box = await Hive.openBox<HomeHiveModel>(HiveTableConstant.postBox);
    var posts = box.values.toList();
    box.close();
    return posts;
  }

  // Future<void> addDummyPosts() async {
  //   var box = await Hive.openBox<HomeHiveModel>(HiveTableConstant.postBox);
  //   if (box.isEmpty) {
  //     final post = HomeHiveModel(
  //       audio: 'smth',
  //       title: 'Sample Title',
  //       description: 'Sample Description',
  //       author: 'Nirajan Khanal',
  //       duration: '5:32',
  //       category: 'Technology',
  //       images: 'assets/images/sample_image.png',
  //     );

  //     await addPost(post);
  //   }
  // }

  Future<void> deleteAllData() async {
    var box = await Hive.openBox<HomeHiveModel>(HiveTableConstant.postBox);
    await box.clear();
  }

  Future<void> closeHive() async {
    await Hive.close();
  }

  Future<void> deleteHive() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await Hive.deleteBoxFromDisk(HiveTableConstant.postBox);
    await Hive.deleteFromDisk();
  }

  addpodcast(hiveModel) {}
}

class HomeHiveModel {}

class HomeHiveModelAdapter {}
