import 'package:flutter/cupertino.dart';
import 'package:shamo_clone/domain/entities/transaction.dart';
import 'package:shamo_clone/domain/usecases/get_transactions.dart';
import 'package:shamo_clone/utils/request_state.dart';

class TransactionProvider extends ChangeNotifier {
  final GetTransactions getTransactions;
  TransactionProvider({required this.getTransactions});

  List<Transaction> _transactions = [];
  List<Transaction> get transactions => _transactions;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  RequestState _pagingState = RequestState.Empty;
  RequestState get pagingState => _pagingState;

  String _message = '';
  String get message => _message;

  late int _page;
  late bool _hasReachedMaxPage;
  bool get hasReachedMaxPage => _hasReachedMaxPage;

  Future<void> getTransactionList() async {
    _page = 1;
    _hasReachedMaxPage = false;
    _state = RequestState.Loading;
    notifyListeners();
    final result = await getTransactions.execute(_page);
    result.fold((error) {
      _message = error.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (transactions) {
      _hasReachedMaxPage = transactions.length < 10;
      _transactions = transactions;
      _state = RequestState.Loaded;
      _page++;
      notifyListeners();
    });
  }

  Future<void> fetchMoreTransactions() async {
    if (_hasReachedMaxPage) return;
    _pagingState = RequestState.Loading;
    notifyListeners();
    final result = await getTransactions.execute(_page);
    result.fold((error) {
      _message = error.message;
      _pagingState = RequestState.Error;
      notifyListeners();
    }, (transactions) {
      _hasReachedMaxPage = transactions.isEmpty;
      _transactions.addAll(transactions);
      _page++;
      _pagingState = RequestState.Loaded;
      notifyListeners();
    });
  }
}
