import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:verto/models/avatar_items.dart';
import 'package:verto/utils/requests.dart';

Future<List<AvatarItem>?> fetch({
  required BuildContext context,
}) async {
  List<AvatarItem>? items = await makeRequest<List<AvatarItem>>(
    type: RequestType.get,
    path: "/api/wardrobe",
    fromJson: (fetched) => fetched.map<AvatarItem>((item) => AvatarItem.fromJson(item)).tolist(),
  );

  // TODO: error handling in fetch
  if(items != null) {
    return items;
  }
  
}

Future<List<AvatarItem>?> fetchByCategory({
  required BuildContext context,
  required String category,
}) async {

  List<AvatarItem>? items = await makeRequest<List<AvatarItem>>(
    type: RequestType.get,
    path: "/api/wardrobe/$category",
    fromJson:  (fetched) => fetched.map<AvatarItem>((item) => AvatarItem.fromJson(item)).tolist()
    );

  // TODO: error handling in fetch by category
  if(items != null) {
    return items;
  }
}

void purchase({
  required BuildContext context,
  required String id,
}) async {
await makeRequest<void>(
  type: RequestType.post,
  path: "/api/wardrobe/purchase?id=$id",
);
}

