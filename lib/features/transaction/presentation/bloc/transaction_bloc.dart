import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/features/transaction/domain/usecase/create_transaction_usecase.dart';
import 'package:movin/features/transaction/presentation/bloc/transaction_event.dart';
import 'package:movin/features/transaction/presentation/bloc/transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final CreateTransactionUseCase useCase;

  TransactionBloc(this.useCase) : super(TransactionInitial()) {
    on<CreateTransactionEvent>(_onCreate);
  }

  Future<void> _onCreate(
    CreateTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    try {
      final transaction = await useCase(event.activityId);
      emit(TransactionSuccess(transaction));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }
}