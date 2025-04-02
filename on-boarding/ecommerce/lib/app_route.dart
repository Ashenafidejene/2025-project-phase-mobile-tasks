import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product3/addPage.dart';
import 'package:product3/detailspage.dart';
import 'package:product3/home.dart';
import 'package:product3/models/product.dart';
import 'package:product3/searchPage.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
      routes: [
        GoRoute(
          path: 'search',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const ProductSearchScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        ),
        GoRoute(
          path: '/details',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: DetailsPage(
              product: state.extra as Product,
              onDeleteResult: (success) {
                Navigator.pop(context, success); // Handle deletion if needed
              },
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: animation,
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
          ),
        ),
        GoRoute(
          path: 'add',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const AddProductPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return RotationTransition(
                turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                child: child,
              );
            },
          ),
        ),
      ],
    ),
  ],
);
