import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/models/api/customer/model.dart';
import 'package:washpro/data/models/api/getOrders/model.dart';
import 'package:washpro/data/repositories/bag/base.dart';
import 'package:washpro/data/repositories/customer/base.dart';
import 'package:washpro/logger.dart';

part 'state.dart';

class PrintScreenCubit extends Cubit<PrintScreenState> {
  final BagRepository bagRepository;
  final CustomerRepository customerRepository;
  PrintScreenCubit(
      {required CustomerRepository customerRepo,
      required BagRepository bagRepo})
      : customerRepository = customerRepo,
        bagRepository = bagRepo,
        super(const PrintScreenState(
          initialLoading: true,
        ));

  Future<void> loadCustomerAndOrder(int customerID, int orderID) async {
    try {
      final customer = await customerRepository.getCustomer(customerID);
      final order = await customerRepository.getOrder(customerID);

      emit(state.copyWith(
          customer: customer, order: order, initialLoading: false));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<bool> printTicket(
    Bag bag,
    String bagWeight,
    String itemsCount,
  ) async {
    try {
      emit(state.copyWith(printLoading: true));

      await customerRepository.printTicket(
        bag.order_id!,
        bag.bag_id,
        bagWeight,
        itemsCount,
      );

      emit(state.copyWith(printLoading: false));
      return true;
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(
          printLoading: false, errorMessage: "Could not print ticket"));
      return false;
    }
  }
}
