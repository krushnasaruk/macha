import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../network/connectivity_service.dart';
import '../network/supabase_config.dart';
import '../theme/app_colors.dart';

final imageStorageServiceProvider = Provider<ImageStorageService>((ref) {
  final connectivity = ref.watch(connectivityServiceProvider);
  return ImageStorageService(connectivity: connectivity);
});

class ImageStorageService {
  final ImagePicker _picker;
  final ConnectivityService _connectivity;
  final Uuid _uuid;

  ImageStorageService({
    ImagePicker? picker,
    required ConnectivityService connectivity,
    Uuid? uuid,
  })  : _picker = picker ?? ImagePicker(),
        _connectivity = connectivity,
        _uuid = uuid ?? const Uuid();

  /// Picks an image from device gallery or camera.
  Future<XFile?> pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final file = await _picker.pickImage(
        source: source,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );
      return file;
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  /// Saves the picked image persistently to local app storage,
  /// and synchronously or asynchronously mirrors to Supabase storage when online.
  /// Returns a persistent image reference path or URL.
  Future<String?> saveProductImage(XFile pickedFile) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final menuImagesDir = Directory(p.join(appDir.path, 'menu_images'));
      if (!await menuImagesDir.exists()) {
        await menuImagesDir.create(recursive: true);
      }

      final ext = p.extension(pickedFile.path).isNotEmpty
          ? p.extension(pickedFile.path)
          : '.png';
      final fileName = 'prod_${_uuid.v4()}$ext';
      final persistentFile = File(p.join(menuImagesDir.path, fileName));

      // Copy from temporary picked path to persistent local storage
      final bytes = await pickedFile.readAsBytes();
      await persistentFile.writeAsBytes(bytes, flush: true);

      // Attempt remote upload if Supabase is connected & online
      if (_connectivity.isOnline && SupabaseConfig.isConfigured) {
        try {
          final supabase = SupabaseConfig.client;
          final remotePath = 'products/$fileName';
          await supabase.storage
              .from('menu-images')
              .uploadBinary(remotePath, bytes);
          final publicUrl = supabase.storage
              .from('menu-images')
              .getPublicUrl(remotePath);
          return publicUrl;
        } catch (remoteErr) {
          debugPrint('Remote Supabase storage sync failed, using persistent local: $remoteErr');
        }
      }

      return persistentFile.path;
    } catch (e) {
      debugPrint('Error saving persistent image: $e');
      return null;
    }
  }

  /// Helper widget to render any product image safely with MΛCHA placeholder fallback.
  static Widget buildProductImage(
    String? imageRef, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
  }) {
    Widget imageWidget;

    if (imageRef == null || imageRef.isEmpty) {
      imageWidget = _buildPlaceholder();
    } else if (imageRef.startsWith('http://') || imageRef.startsWith('https://')) {
      imageWidget = Image.network(
        imageRef,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    } else if (imageRef.startsWith('assets/')) {
      imageWidget = Image.asset(
        imageRef,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    } else {
      // Local persistent file
      final file = File(imageRef);
      if (file.existsSync()) {
        imageWidget = Image.file(
          file,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (_, __, ___) => _buildPlaceholder(),
        );
      } else {
        imageWidget = _buildPlaceholder();
      }
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: imageWidget,
      );
    }
    return imageWidget;
  }

  static Widget _buildPlaceholder() {
    return Container(
      color: AppColors.primaryContainer.withOpacity(0.5),
      alignment: Alignment.center,
      child: const Icon(
        Icons.restaurant_rounded,
        color: AppColors.primary,
        size: 28,
      ),
    );
  }
}
