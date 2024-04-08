import 'package:flutter/material.dart';

final emptyView = SliverToBoxAdapter(
  child: Container(
    padding: const EdgeInsets.only(top: 100),
    alignment: Alignment.center,
    child: const Text(
      "暂无内容",
      style: TextStyle(
        fontSize: 12,
        color: Color(0xFF636C78),
      ),
    ),
  ),
);
