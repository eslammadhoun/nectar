import 'package:flutter/material.dart';
import 'package:nectar/V2/features/home/home_page_vm.dart';
import 'package:nectar/V2/features/widgets/custom_bottom_navbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageVm>(
      builder: (context, vm, child) {
        return Scaffold(
          bottomNavigationBar: CustomBottomNavbar(
            selectedIndex: vm.selectedIndex,
            onTap: vm.onItemTapped,
          ),
          body: IndexedStack(
            index: vm.selectedIndex,
            children: vm.pages,
          ),
        );
      },
    );
  }
}
